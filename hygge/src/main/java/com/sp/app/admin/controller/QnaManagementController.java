package com.sp.app.admin.controller;

import java.math.BigDecimal;
import java.net.URLDecoder;
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

import com.sp.app.admin.model.QnaManage;
import com.sp.app.admin.service.QnaManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/qna/*")
public class QnaManagementController {
	private final QnaManageService service;
	private final PaginateUtil paginateUtil;
    
	@GetMapping("list")
	public String QnaList(@RequestParam(name = "page", defaultValue = "1") int current_page,
	                     @RequestParam(name = "schType", defaultValue = "all") String schType,
	                     @RequestParam(name = "kwd", defaultValue = "") String kwd,
	                     @RequestParam(name = "category", defaultValue = "0") int category,
	                     @RequestParam(name = "status", defaultValue = "") String status,
	                     @RequestParam(name = "startDate", required = false) String startDate,
	                     @RequestParam(name = "endDate", required = false) String endDate,
	                     HttpServletRequest req,
	                     HttpSession session,
	                     Model model) {

	    try {
	        int size = 13;
	        int total_page = 0;
	        int dataCount = 0;

	        kwd = URLDecoder.decode(kwd, "UTF-8");

	        Map<String, Object> map = new HashMap<>();
	        map.put("schType", schType);
	        map.put("kwd", kwd);
	        map.put("category", category);
	        map.put("status", status);
	        map.put("startDate", startDate);
	        map.put("endDate", endDate);

	        // 상태별 카운트 조회
	        Map<String, Object> statusCounts = service.getStatusCounts();
	        
	        log.info("상태별 카운트: {}", statusCounts);
	        
	        dataCount = service.dataCount(map);
	        total_page = paginateUtil.pageCount(dataCount, size);

	        current_page = Math.min(current_page, total_page);

	        int offset = (current_page - 1) * size;
	        if(offset < 0) offset = 0;

	        map.put("offset", offset);
	        map.put("size", size);

	        List<QnaManage> list = service.qnaList(map);

	        String cp = req.getContextPath();
	        String query = "";
	        String listUrl = cp + "/admin/qna/list";
	        String articleUrl = cp + "/admin/qna/article?page=" + current_page;

	        if (!kwd.isBlank()) {
	            query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
	        }
	        
	        if (category != 0) {
	            query += (query.isEmpty() ? "" : "&") + "category=" + category;
	        }
	        
	        if (!status.isBlank()) {
	            query += (query.isEmpty() ? "" : "&") + "status=" + status;
	        }
	        
	        if (startDate != null && !startDate.isBlank()) {
	            query += (query.isEmpty() ? "" : "&") + "startDate=" + startDate;
	        }
	        
	        if (endDate != null && !endDate.isBlank()) {
	            query += (query.isEmpty() ? "" : "&") + "endDate=" + endDate;
	        }
	        
	        if (!query.isEmpty()) {
	            listUrl += "?" + query;
	            articleUrl += "&" + query;
	        }

	        String paging = paginateUtil.paging(current_page, total_page, listUrl);

	        model.addAttribute("list", list);
	        model.addAttribute("page", current_page);
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("size", size);
	        model.addAttribute("total_page", total_page);
	        model.addAttribute("articleUrl", articleUrl);
	        model.addAttribute("paging", paging);

	        model.addAttribute("schType", schType);
	        model.addAttribute("kwd", kwd);
	        model.addAttribute("category", category);
	        model.addAttribute("status", status);
	        model.addAttribute("startDate", startDate);
	        model.addAttribute("endDate", endDate);
	        
	        // 상태별 카운트 정보 추가
	        BigDecimal pendingCount = (BigDecimal)statusCounts.get("pending_count");
	        BigDecimal completedCount = (BigDecimal)statusCounts.get("completed_count");
	        BigDecimal totalCount = (BigDecimal)statusCounts.get("total_count");

	        model.addAttribute("pendingCount", pendingCount != null ? pendingCount.intValue() : 0);
	        model.addAttribute("completedCount", completedCount != null ? completedCount.intValue() : 0);
	        model.addAttribute("totalCount", totalCount != null ? totalCount.intValue() : 0);
	        
	        // 카테고리 목록 조회
	        List<Map<String, Object>> categoryList = service.getCategoryList();
	        model.addAttribute("categoryList", categoryList);
	        
	    } catch (Exception e) {
	        log.info("QnaList : ", e);
	    }

	    return "admin/qna/list";
	}
	
	@PostMapping("answerQna")
	@ResponseBody
	public Map<String, Object> answerQna(
			@RequestParam(name = "num") long num,
			@RequestParam(name = "answerTitle") String answerTitle,
			@RequestParam(name = "answerContent") String answerContent,
			Model model) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		try {
			map.put("num", num);
			map.put("answerTitle", answerTitle);
			map.put("answerContent", answerContent);
			
			service.answerQna(map);
			
			model.addAttribute("success", "success");
			
		} catch (Exception e) {
			log.info(answerContent);
			model.addAttribute("false", "false");
		}
		
		return map;
	}
	
	@GetMapping("article")
	public String qnaArticle(
			@RequestParam(name = "num") long num) throws Exception {
		
		try {
			
			return "/qna/article?num=" + num;
		} catch (Exception e) {
			log.info("qnaArticle : ", e);
		}
		
		return "admin/qna/list";
	}
	
}

