package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Collections;
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
import com.sp.app.common.StorageService;
import com.sp.app.model.SessionInfo;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/event/")

public class EventManageController {
	private final EventManageService service;
    private final PaginateUtil paginateUtil;
    private final StorageService storageService;
    
    private String uploadPath;
    
    @PostConstruct
    public void init() {
    	uploadPath = this.storageService.getRealPath("/uploads/event");
    }
    
    @GetMapping("list")
    public String eventList(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {
        
        try {
            int size = 10;
            int total_page = 0;
            int dataCount = 0;
            
            SessionInfo info = (SessionInfo)session.getAttribute("member");
            
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
            String listUrl = cp + "/admin/event/list";
            String articleUrl = cp + "/admin/event/article?page=" + current_page;
            
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
        
        return "admin/event/list";
    }
    
    @GetMapping("write")
    public String writeForm(Model model) throws Exception {
    	model.addAttribute("mode", "write");
    	return "admin/event/write";
    }
    
    @PostMapping("write")
    public String writeSubmit(EventManage dto) throws Exception {
        try {
            service.insertEvent(dto, uploadPath);
            
        } catch (Exception e) {
        	log.info("writeSubmit : ", e);
        }
        
        return "redirect:/admin/event/list";
    }
    
    @GetMapping("delete")
    public String delete(@RequestParam(name = "num") long num,
    		Model model) throws Exception {
    	
    	try {
			
    		service.deleteEvent(num, uploadPath);
    		
		} catch (Exception e) {
			log.info("delete : ", e);
		}
    	
    	return "redirect:/event/list";
    }
    
    @GetMapping("update")
    public String update(@RequestParam(name = "num") long num,
    		Model model) throws Exception {
    	
    	try {
    		EventManage dto = service.readEvent(num);
    		
    		
    		model.addAttribute("dto", dto);
    		model.addAttribute("mode", "update");
    		
		} catch (Exception e) {
			log.info("update : ", e);
		}
    	
    	return "admin/event/write";
    }
    
    @PostMapping("update")
    public String updateSubmit(EventManage dto) throws Exception {
    	
    	try {
    		service.updateEvent(dto, uploadPath);
    		
		} catch (Exception e) {
			log.info("update : ", e);
		}
    	
    	return "redirect:/admin/event/list";
    }
    
    @GetMapping("{eventId}/members")
    @ResponseBody
    public List<EventManage> getEventMembers(@PathVariable("eventId") Long num) {
        try {
            // 이벤트 번호로 해당 이벤트에 참여한 회원 목록 조회
            List<EventManage> list = service.getEventMembers(num);
            
            log.info("조회된 회원 수: {}", list.size());
            for (EventManage em : list) {
                log.info("회원 정보: memberIdx={}, name={}", em.getMemberIdx(), em.getName());
            }
            
            return list;
        } catch (Exception e) {
            log.error("getEventMembers : ", e);
            return Collections.emptyList();
        }
    }
    

}
