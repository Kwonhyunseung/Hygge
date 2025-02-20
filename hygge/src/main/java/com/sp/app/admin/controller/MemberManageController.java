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

import com.sp.app.admin.model.MemberManage;
import com.sp.app.admin.service.MemberManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/memberManagement/*")
public class MemberManageController {
	private final MemberManageService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("normal")
	public String normalMember(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model
			) {
		
		try {
			int size = 2;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("authority", "USER");
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MemberManage> member = service.normalMember(map);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/admin/memberManagement/normal";
			
			if(! kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" +
						URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.paging(current_page, 
					total_page, listUrl);
			
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
			log.info("normalMember : ", e);
		}
		
		return "admin/member/normal";
	}
	
	@GetMapping("reportOver")
	public String reportOver(Model model) {
	    try {
	        String authority = "USER";
	        List<MemberManage> member = service.reportMembers(authority);
	        
	        model.addAttribute("member", member);
	        model.addAttribute("reportOnly", true); 
	        
	    } catch (Exception e) {
	        log.info("reportOver : ", e);
	    }
	    return "admin/member/normal";
	}
	
	@GetMapping("maker")
	public String makerMember(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model
			) {
		
		try {
			int size = 2;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("authority", "MAKER");
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MemberManage> member = service.normalMember(map);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/admin/memberManagement/normal";
			
			if(! kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" +
						URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
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
			log.info("normalMember : ", e);
		}
		
		return "admin/member/maker";
		
	}
	
	@ResponseBody
	@PostMapping("block")
	public Map<String, Object> block(@RequestParam(name = "memberIdx") String memberIdx) {
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.block(memberIdx);
			model.put("state", "success");
			
		} catch (Exception e) {
			log.info("block : ", e);
			model.put("state", "false");
		}
		
		return model;
	}
	
	@ResponseBody
	@PostMapping("unblock")
	public Map<String, Object> unblock(@RequestParam(name = "memberIdx") String memberIdx) {
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.unblock(memberIdx);
			model.put("state", "success");
			
		} catch (Exception e) {
			log.info("block : ", e);
			model.put("state", "false");
		}
		
		return model;
	}
	
}
