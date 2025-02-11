package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Qna;
import com.sp.app.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/qna/*")
public class QnaController {
	
    private final QnaService service;
    private final PaginateUtil paginateUtil;
	 
    
    @GetMapping("list")
	    public String QnaList(
	    		@RequestParam(name = "page", defaultValue = "1") int current_page,
				@RequestParam(name = "schType", defaultValue = "all") String schType,
				@RequestParam(name = "kwd", defaultValue = "") String kwd,
				Model model,
				HttpServletRequest req) throws Exception {
	        try {
	        	log.info("1대1문의 리스트 요청");
	        	int size = 10;
				int total_page;
				int dataCount;
				
				kwd = URLDecoder.decode(kwd, "UTF-8");
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("schType", schType);
				map.put("kwd", kwd);
				
				dataCount = service.dataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);

				current_page = Math.min(current_page, total_page);

				int offset = (current_page - 1) * size;
				if(offset < 0) offset = 0;

				map.put("offset", offset);
				map.put("size", size);
				
				List<Qna> list = service.listQna(map);
				
				String cp = req.getContextPath();
				String query = "";
				String listUrl = cp + "/qna/list";
				String articleUrl = cp + "/qna/article?page=" + current_page;
				if (! kwd.isBlank()) {
					query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");

					listUrl = cp + "/qna/list?" + query;
					articleUrl = cp + "/qna/article?page=" + current_page + "&" + query;
				}

				String paging = paginateUtil.paging(current_page, total_page, listUrl);

				model.addAttribute("list", list);
				model.addAttribute("articleUrl", articleUrl);
				model.addAttribute("page", current_page);
				model.addAttribute("dataCount", dataCount);
				model.addAttribute("size", size);
				model.addAttribute("total_page", total_page);
				model.addAttribute("paging", paging);

				model.addAttribute("schType", schType);
				model.addAttribute("kwd", kwd);
				
	        } catch (Exception e) {
	            log.error("1대1문의 리스트 오류", e);
	        }
	        return "qna/list";
	    }
	 
	 @GetMapping("article")
	    public String QnaArticle(Model model) {
	        try {
	            log.info("1대1문의 아티클 요청");
	        } catch (Exception e) {
	            log.error("1대1문의 아티클 오류", e);
	        }
	        return "qna/article";
	    }
	 
	 @GetMapping("write")
	    public String Qnawrite(Model model) {
	        try {
	            log.info("1대1문의 write 요청");
	        } catch (Exception e) {
	            log.error("1대1문의 write 오류", e);
	        }
	        return "qna/write";
	    }
}
