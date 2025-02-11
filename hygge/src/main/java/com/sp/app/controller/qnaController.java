package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.common.PaginateUtil;
import com.sp.app.service.QnaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/qna/*")
public class qnaController {
	
    private final QnaService qnaService;
    private final PaginateUtil paginateUtil;
	 
    
    @GetMapping(value = "list")
	    public String QnaList(Model model) {
	        try {
	            log.info("1대1문의 리스트 요청");
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
