package com.sp.app.admin.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.ReviewManage;
import com.sp.app.admin.service.ReviewManageServcie;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/review/*")
public class ReviewManageController {
	private final ReviewManageServcie service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("list")
	public String ReviewList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "category", defaultValue = "") String category,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "reportFilter", defaultValue = "all") String reportFilter,
			HttpServletRequest req,
			Model model) {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			String queryParams = "";
			
			Map<String, Object> map = new HashMap<>();
			map.put("category", category);
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("reportFilter", reportFilter);
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<ReviewManage> review = service.reviewList(map);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/admin/review/list";
			
			if(!category.isBlank()) {
	            query += "&category=" + URLEncoder.encode(category, "utf-8");
	        }
			
			if(!kwd.isBlank()) {
			    queryParams += (queryParams.isEmpty() ? "" : "&") + "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
			}
			
			if(!"all".equals(reportFilter)) {
	            queryParams += (queryParams.isEmpty() ? "" : "&") + "reportFilter=" + reportFilter;
	        }

			if(!queryParams.isEmpty()) {
			    listUrl += "?" + queryParams;
			}

			query += (queryParams.isEmpty() ? "" : "&") + queryParams;
			
			String paging = paginateUtil.paging(current_page, 
					total_page, listUrl);
			log.info("검색 파라미터: category={}, schType={}, kwd={}", category, schType, kwd);
			List<ReviewManage> categories = service.categories();
			
			model.addAttribute("categories", categories);
			model.addAttribute("review", review);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);
			model.addAttribute("category", category);
			model.addAttribute("reportFilter", reportFilter);
			
		} catch (Exception e) {
			log.info("ReviewList : ", e);
		}
		
		return "admin/review/list";
	}
	
	@ResponseBody
	@PostMapping("deleteReviews")
	public Map<String, Object> deleteReviews(
			@RequestParam(name = "reviewIds") List<Long> reviewIds
			) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		try {
			service.deleteReviews(reviewIds);
			map.put("status", "success");
		} catch (Exception e) {
			map.put("status", "false");
			log.info("deleteReviews : ", e);
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("blockMember")
	public Map<String, Object> blockMember(
	        @RequestParam(name = "reviewIds") List<Long> reviewIds
	        ) throws Exception {
	    Map<String, Object> map = new HashMap<>();
	    
	    try {
	        // 리뷰 ID로부터 회원 정보를 조회하여 차단 처리
	        service.blockMembersByReviews(reviewIds);
	        map.put("status", "success");
	    } catch (Exception e) {
	        map.put("status", "error");
	        map.put("message", e.getMessage());
	        log.error("blockMember : ", e);
	    }
	    
	    return map;
	}
}
