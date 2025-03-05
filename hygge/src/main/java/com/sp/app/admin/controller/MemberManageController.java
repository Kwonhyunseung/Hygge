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
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("authority", "User");
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			String authority = "User";
			map.put("authority", authority);
			
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

	
	@GetMapping("maker")
	public String makerMember(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model
			) {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("authority", "User");
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			String authority = "Maker";
			map.put("authority", authority);
			
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
			log.info("makerMember : ", e);
		}
		
		return "admin/member/maker";
	}
	
	@GetMapping("reportOver")
	public String reportOver(Model model) {
	    try {
	        String authority = "User";
	        List<MemberManage> member = service.reportMembers(authority);
	        
	        model.addAttribute("member", member);
	        model.addAttribute("reportOnly", true); 
	        
	    } catch (Exception e) {
	        log.info("reportOver : ", e);
	    }
	    return "admin/member/normal";
	}
	
	@GetMapping("makerSubmit")
	public String makerSubmitMember (
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model) {
		
		try {
			int size = 5;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			//map.put("authority", "MAKER");
			
			dataCount = service.getUserProjectRequestsCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MemberManage> makers = service.getUserProjectRequests(map);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/admin/memberManagement/maker";
			
			if(! kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" +
						URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
            log.info("데이터 카운트: {}", dataCount);
            log.info("메이커 리스트 크기: {}", makers.size());
            if (!makers.isEmpty()) {
                for (MemberManage m : makers) {
                    log.info("메이커 데이터: {}", m);
                }
            }
			
			model.addAttribute("makers", makers);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);
			
		} catch (Exception e) {
			log.info("makerMember : ", e);
		}
		
		return "admin/member/makerSubmit";
		
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
	
	@ResponseBody
	@PostMapping("maker/approve")
	public Map<String, Object> approveMaker(@RequestParam(name = "memberIdx") long memberIdx) throws Exception {
		Map<String, Object> response = new HashMap<>();
		
		try {
			service.approve(memberIdx);
			response.put("success", true);
			
		} catch (Exception e) {
			log.info("approveMaker : ", e);
			response.put("success", false);
		}
		
		return response;
	}
	
	@ResponseBody
	@PostMapping("maker/reject")
	public Map<String, Object> rejectMaker(@RequestParam(name = "memberIdx") long memberIdx,
			@RequestParam(name = "projectNum") long projectNum) throws Exception {
		Map<String, Object> response = new HashMap<>();
		
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", memberIdx);
			map.put("projectNum", projectNum);
			service.reject(map);
			
			response.put("success", true);
			
		} catch (Exception e) {
			log.info("rejectMaker : ", e);
			response.put("false", false);
		}
		
		return response;
	}
	
}
