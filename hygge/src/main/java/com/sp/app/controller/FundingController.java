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
import com.sp.app.model.Funding;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.FundingProjectService;
import com.sp.app.service.FundingService;

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

	@GetMapping("main/product/{num}")
	public String productDetail(@PathVariable("num") long num, Model model) {
	    try {
	        // 서비스에서 프로젝트 정보 가져오기
	        Funding project = detailService.detailProduct(num);

	        if (project != null) {
	            model.addAttribute("project", project);
	        } else {
	            model.addAttribute("error", "해당 프로젝트를 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        log.error("Error fetching project details", e);
	        model.addAttribute("error", "데이터를 불러오는 중 오류가 발생했습니다.");
	    }
	    return "funding/main/product";
	}

	
	@GetMapping("plan")
	public String plan(Model model) {
		return "funding/main/contentPlan";
	}
	
	@GetMapping("review")
	public String review(Model model) {
		return "funding/main/contentReview";
	}
	




	@GetMapping("{menu}")
	public String fundingList(@PathVariable(name = "menu") String Menu, 
			@RequestParam(name = "kwd", defaultValue = "") String keyword,
			Model model, HttpSession session) {
		try {
			model.addAttribute("menu", Menu);

		} catch (Exception e) {
			log.info("fundingList : ", e);
		}
		return "funding/funding_list";
	}


	@ResponseBody
	@GetMapping("{menu}/fundingList")
	public Map<String, Object> fundingList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@PathVariable(name = "menu") String Menu,
			@RequestParam(name = "order") String Order,
			@RequestParam(name = "kwd", defaultValue = "") String keyword,
			HttpSession session) {
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
			if (offset < 0) offset = 0;
			
			map.put("size", size);
			map.put("offset", offset);

			SessionInfo info = (SessionInfo)session.getAttribute("member");
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
			@RequestParam(name = "liked") boolean isUserLiked,
			HttpSession session, HttpServletResponse resp) throws Exception {
		Map<String, Object> model = new HashMap<>();
		try {
			SessionInfo info = Objects.requireNonNull((SessionInfo)session.getAttribute("member"));
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