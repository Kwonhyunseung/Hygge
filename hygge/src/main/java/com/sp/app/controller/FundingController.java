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
	private final FundingService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("/product")
	public String handleHome(Model model) {
		try {
		
		} catch (Exception e) {
		}
		return "funding/main/product";
	}
	
	@GetMapping("/plan")
	public String plan(Model model) {
		return "funding/main/contentPlan";
	}
	
	@GetMapping("/review")
	public String review(Model model) {
		return "funding/main/contentReview";
	}
	
	@GetMapping("/funding/{menu}")
	public String fundingList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@PathVariable(name = "menu") String Menu, 
			@RequestParam(name = "kwd", defaultValue = "") String keyword,
			Model model, HttpSession session) {
		String url = "";
		try {
			int size = 20;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<>();
			map.put("menu", Menu);
			map.put("kwd", keyword);
			
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
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			
			if (Menu.equalsIgnoreCase("hotContent")) {
				url = "funding/hotContent";
			}
		} catch (Exception e) {
			log.info("fundingList : ", e);
		}
		return url;
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