package com.sp.app.controller;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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
import com.sp.app.model.Product;
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

	@GetMapping("/product/{num}")
	public String productDetail(@PathVariable("num") long num, Model model, HttpSession session) {
		try {
			Funding project = detailService.fundingProduct(num);
			
			 // 로그 추가
	        log.info("memberIdx: " + project.getMemberIdx());

			double funding_goal = (double)project.getTotal_amount() / project.getTarget() * 100;
			project.setFunding_goal(String.format("%.0f", funding_goal)); // 소수점 없이 반올림
			
			project.setRemained_date(calDiffDate(project.getEnd_date()));
			project.setPayment_date(payOneDay(project.getEnd_date()));
			
			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			List<Product> productList = detailService.detailProduct(map);

			// 좋아요 수 조회
			int likeCount = detailService.projectLikeCount(num);
			
			// 좋아요 / 팔로우 상태 확인
			boolean isUserLiked = false;
			boolean isUserFollow = false;
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info != null) {
				map.put("memberIdx", info.getMemberidx());
				map.put("makerIdx", project.getMemberIdx());
				
				// 좋아요가 있으면 true
				int count = detailService.userFundingLiked(map);
				isUserLiked = count > 0;
				
				// 팔로우 중이면 true
				int followCount = detailService.userFollowing(map);
				isUserFollow = followCount > 0;
				
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
	
	/*
	// 남은 시간
	public static String calDiffDate(String dateString) {
		// 날짜 형식 지정 (입력 문자열이 "yyyy-MM-dd" 형식일 경우)
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 문자열을 LocalDate로 변환
		LocalDate inputDate = LocalDate.parse(dateString, formatter);

		// 현재 날짜 가져오기
		LocalDate currentDate = LocalDate.now();

		// 두 날짜 사이의 차이 계산
		return String.valueOf(ChronoUnit.DAYS.between(currentDate, inputDate));
	}
	
	// 결제일
	public static String payOneDay(String dateString) {
		// 날짜 형식 지정 (입력 문자열이 "yyyy-MM-dd" 형식일 경우)
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 문자열을 LocalDate로 변환
		LocalDate inputDate = LocalDate.parse(dateString, formatter);

		// 두 날짜 사이의 차이 계산
		return String.valueOf(inputDate.plusDays(1));
	}
	
	public static String convertToString(Double input) {
		DecimalFormat df = new DecimalFormat("#,##0.00"); // 소수점 둘째 자리까지 표시
		String formattedValue = df.format(input);
		return formattedValue;
	}
	*/
	// 공통 날짜 파싱 메소드
	private static LocalDate parseDate(String dateString) {
	    try {
	        // 숫자만 있는 경우 (예: "20240312")
	        if (dateString.matches("\\d{8}")) {
	            return LocalDate.parse(
	                dateString.substring(0, 4) + "-" + 
	                dateString.substring(4, 6) + "-" + 
	                dateString.substring(6, 8), 
	                DateTimeFormatter.ofPattern("yyyy-MM-dd")
	            );
	        }
	        
	        // 하이픈, 점, 슬래시 형식 변환
	        String normalizedDate = dateString
	            .replace(".", "-")
	            .replace("/", "-");
	            
	        if (normalizedDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
	            return LocalDate.parse(normalizedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	        }
	        
	        // 다양한 포맷 시도
	        DateTimeFormatter[] formatters = {
	            DateTimeFormatter.ofPattern("yyyy-MM-dd"),
	            DateTimeFormatter.ofPattern("yyyy.MM.dd"),
	            DateTimeFormatter.ofPattern("yyyy/MM/dd"),
	            DateTimeFormatter.ofPattern("yyyyMMdd"),
	            DateTimeFormatter.ofPattern("dd-MM-yyyy"),
	            DateTimeFormatter.ofPattern("MM/dd/yyyy")
	        };
	        
	        for (DateTimeFormatter fmt : formatters) {
	            try {
	                return LocalDate.parse(dateString, fmt);
	            } catch (Exception e) {
	                // 이 형식으로 파싱 불가능하면 다음 형식 시도
	                continue;
	            }
	        }
	        
	        // 모든 형식이 실패하면 현재 날짜 반환
	        return LocalDate.now();
	    } catch (Exception e) {
	        return LocalDate.now();
	    }
	}

	// 남은 시간
	public static String calDiffDate(String dateString) {
	    try {
	        LocalDate inputDate = parseDate(dateString);
	        long daysBetween = ChronoUnit.DAYS.between(LocalDate.now(), inputDate);
	        return String.valueOf(daysBetween);
	    } catch (Exception e) {
	        return "0";
	    }
	}

	// 결제일
	public static String payOneDay(String dateString) {
	    try {
	        LocalDate inputDate = parseDate(dateString);
	        return inputDate.plusDays(1).format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
	    } catch (Exception e) {
	        return LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	    }
	}

	// 숫자 포맷팅
	public static String convertToString(Double input) {
	    return new DecimalFormat("#,##0.00").format(input);
	}
	
	
	@ResponseBody
	@PostMapping("userFundingLiked")
	public Map<String, Object> productLiked(@RequestParam(name = "num") long num,
			@RequestParam(name = "userLiked", defaultValue = "false") boolean userLiked, HttpSession session,
			HttpServletResponse resp) {

		Map<String, Object> model = new HashMap<>();
		String state = "true";

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				model.put("message", "로그인이 필요한 서비스입니다.");
				return model;
			}

			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("memberIdx", info.getMemberidx());

			// 현재 좋아요 상태 확인
			int count = detailService.userFundingLiked(map);

			if (count > 0) { // 이미 좋아요가 존재하면
				detailService.deleteProjectLikeCount(map);
			} else {
				detailService.insertProjectLikeCount(map);
			}

			// 업데이트된 좋아요 수 반환
			int likeCount = detailService.projectLikeCount(num);
			model.put("state", state);
			model.put("likeCount", likeCount);
			model.put("isLiked", count == 0); // 좋아요가 없었으면 true, 있었으면 false

		} catch (Exception e) {
			log.error("좋아요 처리 중 오류", e);
			state = "false";
			model.put("state", state);
			model.put("message", "서버 오류가 발생했습니다.");
		}

		return model;
	}
	
	@ResponseBody
	@PostMapping("toggleFollow")
	public Map<String, Object> toggleFollow(
	        @RequestParam(name = "makerIdx") long makerIdx,
	        @RequestParam(name = "num", required = false, defaultValue = "0") long num,
	        HttpSession session,
	        HttpServletResponse resp) {

	    Map<String, Object> model = new HashMap<>();
	    String state = "true";

	    try {
	        // 로그 추가
	        log.info("toggleFollow - makerIdx: {}, num: {}", makerIdx, num);
	        
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if (info == null) {
	            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            model.put("message", "로그인이 필요한 서비스입니다.");
	            return model;
	        }

	        Map<String, Object> map = new HashMap<>();
	        map.put("makerIdx", makerIdx);
	        map.put("memberIdx", info.getMemberidx());
	        map.put("num", num);

	        // 현재 팔로우 상태 확인
	        int count = detailService.userFollowing(map);

	        if (count > 0) { // 이미 팔로우 중이면
	            detailService.deleteFollowing(map);
	        } else {
	            detailService.insertFollowing(map);
	        }

	        // 업데이트된 팔로워 수
	        int followingCount = 0;
	        if (num > 0) {
	            Funding project = detailService.fundingProduct(num);
	            followingCount = project != null ? project.getFollowingCount() : 0;
	        }

	        model.put("state", state);
	        model.put("followingCount", followingCount);
	        model.put("isFollowing", count == 0);

	    } catch (Exception e) {
	        log.error("팔로우 처리 중 오류", e);
	        state = "false";
	        model.put("state", state);
	        model.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
	    }

	    return model;
	}

	@GetMapping("plan")
	public String plan(Model model) {
		return "funding/contentPlan";
	}

	@GetMapping("review")
	public String review(Model model) {
		return "funding/contentReview";
	}

	
	// -------------------------------------------------------------------

	
	@GetMapping("{menu}")
	public String fundingList(@PathVariable(name = "menu") String Menu,
			@RequestParam(name = "kwd", defaultValue = "") String keyword, Model model, HttpSession session) {
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