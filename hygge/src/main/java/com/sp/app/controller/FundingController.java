package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;
import com.sp.app.model.Review;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.FundingProjectService;
import com.sp.app.service.FundingService;
import com.sp.app.service.MakerService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/funding/*")
public class FundingController {
	private final FundingProjectService detailService;
	private final FundingService service;
	private final PaginateUtil paginateUtil;
	private final MakerService makerService;

	@GetMapping("/product/{num}")
	public String productDetail(@PathVariable("num") long num, Model model, HttpSession session) {
	    Map<String, Object> map = new HashMap<>();
	    
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        Funding project = detailService.fundingProduct(num);
	        detailService.calculateProject(project);
	        boolean isUserLiked = false;
	        boolean isUserFollow = false;
	        
	        map.put("num", num);
	        List<Product> productList = detailService.detailProduct(map);
	        
	        int likeCount = detailService.projectLikeCount(num);
	        if (info != null) {
	            map.put("memberIdx", info.getMemberidx());
	            map.put("makerIdx", project.getMemberIdx());
	            isUserLiked = detailService.userFundingLiked(map) > 0;
	            isUserFollow = detailService.userFollowing(map) > 0;
	        }
	        
	        if (project != null) {
	            model.addAttribute("thumbnail", "/uploads/project/" + project.getThumbnail());
	            model.addAttribute("profile_img", "/uploads/profile/" + project.getProfile_img());
	            model.addAttribute("project", project);
	            model.addAttribute("likeCount", likeCount);
	            model.addAttribute("isUserLiked", isUserLiked);
	            model.addAttribute("isUserFollow", isUserFollow);
	            model.addAttribute("product", productList);
	        }
	    } catch (Exception e) {
	        log.error("Error fetching project details", e);
	        model.addAttribute("error", "데이터를 불러오는 중 오류가 발생했습니다.");
	    }
	    return "funding/product";
	}

	// 프로젝트 좋아요
	@ResponseBody
	@PostMapping("userFundingLiked")
	public Map<String, Object> productLiked(@RequestParam(name = "num") long num,
			@RequestParam(name = "userLiked", defaultValue = "false") boolean userLiked, HttpSession session,
			HttpServletResponse resp) {

		Map<String, Object> model = new HashMap<>();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return handleUnauthorized(resp, model);
			}

			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("memberIdx", info.getMemberidx());

			int count = detailService.userFundingLiked(map);
			boolean newLikeState;

			if (count > 0) {
				detailService.deleteProjectLikeCount(map);
				newLikeState = false;
			} else {
				detailService.insertProjectLikeCount(map);
				newLikeState = true;
			}

			int likeCount = detailService.projectLikeCount(num);
			model.put("state", "true");
			model.put("likeCount", likeCount);
			model.put("isLiked", newLikeState);

		} catch (Exception e) {
			log.error("좋아요 처리 중 오류", e);
			model.put("state", "false");
			model.put("message", "서버 오류가 발생했습니다.");
		}

		return model;
	}

	// 메이커 팔로우
	@ResponseBody
	@PostMapping("toggleFollow")
	public Map<String, Object> toggleFollow(@RequestParam(name = "makerIdx") long makerIdx,
			@RequestParam(name = "num", required = false, defaultValue = "0") long num, HttpSession session,
			HttpServletResponse resp) {

		Map<String, Object> model = new HashMap<>();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return handleUnauthorized(resp, model);
			}

			Map<String, Object> map = new HashMap<>();
			map.put("makerIdx", makerIdx);
			map.put("memberIdx", info.getMemberidx());
			map.put("num", num);

			int count = detailService.userFollowing(map);
			boolean newFollowState;

			if (count > 0) {
				detailService.deleteFollowing(map);
				newFollowState = false;
			} else {
				detailService.insertFollowing(map);
				newFollowState = true;
			}

			int followingCount = 0;
			if (num > 0) {
				Funding project = detailService.fundingProduct(num);
				followingCount = project != null ? project.getFollowingCount() : 0;
			}

			model.put("state", "true");
			model.put("followingCount", followingCount);
			model.put("isFollowing", newFollowState);

		} catch (Exception e) {
			log.error("팔로우 처리 중 오류", e);
			model.put("state", "false");
			model.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
		}

		return model;
	}

	@GetMapping("plan")
	public String plan(@RequestParam(name = "num") long number, Model model) {
		try {
			String content = service.fundingContent(number);
			model.addAttribute("content", content);
		} catch (Exception e) {
			log.info("plan : ", e);
		}
		return "funding/contentPlan";
	}

	@GetMapping("review")
	public String review(@RequestParam(name = "num") long number, Model model) {
		try {
			// 리뷰 리스트
			List<Review> list = service.listReview(number);
			double gradeAvg = service.gradeAvg(list);
			model.addAttribute("list", list);
			model.addAttribute("gradeAvg", gradeAvg);
		} catch (Exception e) {
			log.info("review : ", e);
		}
		return "funding/contentReview";
	}
	
	private Map<String, Object> handleUnauthorized(HttpServletResponse resp, Map<String, Object> model) {
		resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		model.put("message", "로그인이 필요한 서비스입니다.");
		return model;
	}

	// -------------------------------------------------------------------

	@GetMapping("{menu}")
	public String fundingList(@PathVariable(name = "menu") String Menu,
			@RequestParam(name = "kwd", defaultValue = "") String keyword, Model model, HttpSession session) {
		try {
			model.addAttribute("menu", Menu);
			List<Category> parentCategories = makerService.listCategory(0);
			List<Category> childCategories01 = makerService.listCategory(1);
			List<Category> childCategories02 = makerService.listCategory(2);
			List<Category> childCategories03 = makerService.listCategory(3);
			List<Category> childCategories04 = makerService.listCategory(4);
			List<Category> childCategories05 = makerService.listCategory(5);
			List<Category> childCategories06 = makerService.listCategory(6);
			List<Category> childCategories07 = makerService.listCategory(7);
			List<Category> childCategories08 = makerService.listCategory(8);
			List<Category> childCategories09 = makerService.listCategory(9);

			model.addAttribute("parentCategories", parentCategories);
			model.addAttribute("childCategories01", childCategories01);
			model.addAttribute("childCategories02", childCategories02);
			model.addAttribute("childCategories03", childCategories03);
			model.addAttribute("childCategories04", childCategories04);
			model.addAttribute("childCategories05", childCategories05);
			model.addAttribute("childCategories06", childCategories06);
			model.addAttribute("childCategories07", childCategories07);
			model.addAttribute("childCategories08", childCategories08);
			model.addAttribute("childCategories09", childCategories09);
		} catch (Exception e) {
			log.info("fundingList : ", e);
		}
		return "funding/funding_list";
	}

	@ResponseBody
	@GetMapping("{menu}/fundingList")
	public Map<String, Object> fundingList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@PathVariable(name = "menu") String Menu, @RequestParam(name = "order") String Order,
			@RequestParam(name = "kwd", defaultValue = "") String keyword, HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		try {
			int size = 20;
			int total_page = 0;
			int dataCount = 0;

			Map<String, Object> map = new HashMap<>();
			if (Menu.indexOf("category") >= 0) {
				int flag = Integer.parseInt(Menu.substring(8));
				map.put("flag", flag);
				map.put("menu", Menu.substring(0, 8));
			} else {
				map.put("menu", Menu);
			}
			map.put("kwd", keyword);
			map.put("order", Order);

			dataCount = service.dataCountFunding(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(total_page, current_page);
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			map.put("size", size);
			map.put("offset", offset);

			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info != null) {
				map.put("memberIdx", info.getMemberidx());
			}

			List<Funding> list = service.listFunding(map);

			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("page", current_page);
			model.put("total_page", total_page);
			model.put("menu", Menu);

		} catch (Exception e) {
			log.info("fundingList : ", e);
		}
		return model;
	}

	@ResponseBody
	@PostMapping("userLikeProject")
	public Map<String, Object> fundingLike(@RequestParam(name = "num") long number,
			@RequestParam(name = "liked") boolean isUserLiked, HttpSession session, HttpServletResponse resp)
			throws Exception {
		Map<String, Object> model = new HashMap<>();
		try {
			SessionInfo info = Objects.requireNonNull((SessionInfo) session.getAttribute("member"));
			model.put("num", number);
			model.put("memberIdx", info.getMemberidx());

			if (isUserLiked) {
				service.deleteFundingLike(model);
			} else {
				service.insertFundingLike(model);
			}
		} catch (NullPointerException e) {
			log.info("비로그인 상태 : ");
			resp.sendError(401);
		} catch (Exception e) {
			log.info("fundingLike : ", e);
		}
		return model;
	}

}