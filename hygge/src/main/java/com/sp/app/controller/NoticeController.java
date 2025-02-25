package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.NoticeManage;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/notice/")
@Slf4j
@RequiredArgsConstructor
public class NoticeController {
	private final PaginateUtil paginateUtil;
	private final NoticeManageService service; 
	
	@GetMapping("list")
	public String noticeList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model
			) {
		
		try {
            int size = 5;
            int total_page;
            int dataCount;
			
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            dataCount = service.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            
            if (total_page < current_page) {
                current_page = total_page;
            }
            
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<NoticeManage> list = service.listNotice(map);
            
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/notice/list";
            String articleUrl = cp + "/notice/article?page=" + current_page;
            
            if (schType.length() != 0) {
                query = "schType=" + schType + 
                       "&kwd=" + URLEncoder.encode(kwd, "utf-8");
            }
            
            if (query.length() != 0) {
                listUrl += "?" + query;
                articleUrl += "&" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            
            model.addAttribute("query", query);
            model.addAttribute("list", list);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("paging", paging);
            
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
		} catch (Exception e) {
			log.info("list :" ,e);
		}
		
		return "notice/list";
	}
	
	@GetMapping("article/{num}")
	public String article(@PathVariable("num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpSession session) throws Exception {
		
		
		String query = "page=" + page;
		try {
			kwd = URLDecoder.decode(kwd, "utf-8");
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd="
						+ URLEncoder.encode(kwd, "utf-8");
			}
			
			Map<String, Object> map = new HashMap<>();
			
			NoticeManage dto = service.findById(num);
			if(dto == null) {
				return "redirect:/notice/list + query";
			}
			
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("num", num);
			
		    NoticeManage prevDto = service.findByPrev(map);
		    NoticeManage nextDto = service.findByNext(map);
		    
		    List<NoticeManage> files = service.listNoticeFile(num);
			
			model.addAttribute("dto", dto); // 게시글 정보
	        model.addAttribute("prevDto", prevDto);
	        model.addAttribute("nextDto", nextDto);
	        model.addAttribute("files", files);
			model.addAttribute("query", query);
			model.addAttribute("page", page);
			
			return "notice/article";
			
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/notice/list?" + query;
	}
	
}
