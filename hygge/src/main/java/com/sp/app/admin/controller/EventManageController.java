package com.sp.app.admin.controller;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.model.EventManage;
import com.sp.app.admin.service.EventManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
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
            Model model) throws Exception {
        
        try {
            int size = 10;
            int total_page;
            int dataCount;
            
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
    
    
	
}
