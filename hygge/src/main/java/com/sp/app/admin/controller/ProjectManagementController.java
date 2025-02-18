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

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.service.ProjectManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/projectManagement/*")
public class ProjectManagementController {
	private final ProjectManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String projectList(
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			
			if(dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
			
			if(total_page > current_page) {
				current_page = total_page;
			}
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<ProjectManage> list = service.projectList(map);
			
	        String cp = req.getContextPath();
	        String query = "";
	        String listUrl = cp + "/admin/projectManagement/list";			
			
	        if (kwd.length() != 0) {
	            query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
	        }
	        
	        if (query.length() != 0) {
	            listUrl = listUrl + "?" + query;
	        }
	        
	        String paging = paginateUtil.paging(current_page, total_page, listUrl);
	        
	        model.addAttribute("list", list);
	        model.addAttribute("page", current_page);
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("size", size);
	        model.addAttribute("total_page", total_page);
	        model.addAttribute("paging", paging);
	        model.addAttribute("schType", schType);
	        model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
	        log.error("projectList error : ", e);
	        throw e;
		}
		
		return "admin/project/list";
	}
	
	@PostMapping("approve")
	@ResponseBody
	public Map<String, Object> approveProject(@RequestParam (name = "num") long num){
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.approveProject(num);
			model.put("state", "success");
		} catch (Exception e) {
			model.put("state", "failure");
		}
		
		return model;
	}
	
	@PostMapping("reject")
	@ResponseBody
	public Map<String, Object> rejectProject(
			@RequestParam(name = "num") long num,
			@RequestParam(name = "reason") String reason
			) {
		
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.rejectProject(num, reason);
			model.put("state", "failure");
		} catch (Exception e) {
			model.put("state", "failure");
		}
		
		return model;
	}

}
