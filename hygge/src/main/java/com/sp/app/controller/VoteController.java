package com.sp.app.controller;
/*
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

import com.sp.app.admin.model.VoteManage;
import com.sp.app.admin.service.VoteService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/vote/*")
public class VoteController {
	private final VoteService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("list")
	public String voteList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model, HttpServletRequest req) throws Exception {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			// dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/vote/list";
			
			if(! kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" +
						URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			// List<VoteManage> vote = service.voteList(map);
			
			// model.addAttribute("vote", vote);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);
			
			
			
		} catch (Exception e) {
			log.info("voteList : ", e);
		}
		
		return "vote/list";
	}
	
	@GetMapping("article")
	public String voteArticle(Model model) throws Exception {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "";
	}
	
	@GetMapping("write")
	public String voteWrite(Model model) throws Exception {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "";
	}
	
	@PostMapping("write")
	public String voteWriteSubmit(Model model) throws Exception {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "";
	}
	
	
}
*/
