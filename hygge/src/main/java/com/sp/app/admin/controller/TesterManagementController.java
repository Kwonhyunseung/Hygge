package com.sp.app.admin.controller;

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

import com.sp.app.admin.model.TesterManage;
import com.sp.app.admin.service.TesterManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/tester/*")
public class TesterManagementController {
	private final TesterManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String testerList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model
			) {
		List<TesterManage> member = null;
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map); // dataCount 쿼리 필요
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page -1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			member = service.testerList(map);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/admin/tester/list";
			
			if(! kwd.isBlank()) { 
				String qs = "schType=" + schType + "&kwd=" + kwd + URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
	        Map<String, Object> countMap = service.getStatusCount();
	        
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("countMap", countMap);
            model.addAttribute("member", member);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("page", current_page);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            model.addAttribute("query", query);
			
		} catch (Exception e) {
			log.info("testerList : ", e);
		}
		
		return "admin/tester/list";
	}
	
	@PostMapping("approve")
	@ResponseBody
	public Map<String, Object> approve (
			@RequestParam(name = "memberIdx") long memberIdx,
			@RequestParam(name = "num") long num
			) {
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.approveTester(memberIdx, num);
			model.put("state", "success");
			
		} catch (Exception e) {
			log.info("approve : ", e);
		}
		
		return model;
	}
	
	@PostMapping("reject")
	@ResponseBody
	public Map<String, Object> reject (
			@RequestParam(name = "memberIdx") long memberIdx,
			@RequestParam(name = "num") long num
			) {
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.rejectTester(memberIdx, num);
			model.put("state", "success");
			
		} catch (Exception e) {
			log.info("approve : ", e);
		}
		
		return model;
	}
}
