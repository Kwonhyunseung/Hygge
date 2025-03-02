package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.EventManage;
import com.sp.app.admin.service.EventManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/event/")
public class EventController {
	private final EventManageService service;
	private final PaginateUtil paginateUtil;
	
    @GetMapping("list")
    public String eventList(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpServletRequest req,
            Model model) throws Exception {
        
        try {
            int size = 6;
            int total_page = 0;
            int dataCount = 0;
            
            kwd = URLDecoder.decode(kwd , "UTF-8");
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            dataCount = service.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            
            current_page = Math.min(current_page, total_page);
            
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<EventManage> list = service.listEvent(map);
            
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/event/list";
            String articleUrl = cp + "/event/article?page=" + current_page;
            
            if (! kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
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
            
        } catch (Exception e) {
            log.error("eventList : ", e);
        }
        
        return "event/list";
    }
	
	
	@GetMapping("article/{num}")
	public String article(
			@PathVariable(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpSession session) throws Exception {
		try {
			EventManage dto = service.readEvent(num);
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			model.addAttribute("now", new Date());
			
			model.addAttribute("dto", dto);
	        model.addAttribute("page", page);
	        model.addAttribute("schType", schType);
	        model.addAttribute("kwd", kwd);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "event/article";
	}
	
	@ResponseBody
	@PostMapping("apply")
	public Map<String, Object> applyEvent(
			@RequestParam(name = "num") long num,
			@RequestParam(name = "memberidx") long memberidx,
			Model model) throws Exception {
		Map<String, Object> map = new HashMap<>();
				
		try {
			map.put("memberidx", memberidx);
			map.put("num", num);
			
			service.applyEvent(map);
			
			map.put("status", "success");
			
		} catch (Exception e) {
			log.info("applyEvent : ", e);
		}
		
		return map;
	}

}
