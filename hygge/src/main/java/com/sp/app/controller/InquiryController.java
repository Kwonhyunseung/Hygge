package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/inquiry/*")
public class InquiryController {
	 @GetMapping("list")
	    public String InquiryList(Model model) {
	        try {
	            log.info("1대1문의 리스트 요청");
	        } catch (Exception e) {
	            log.error("1대1문의 리스트 오류", e);
	        }
	        return "inquiry/list";
	    }
	 
	 @GetMapping("article")
	    public String InquiryArticle(Model model) {
	        try {
	            log.info("1대1문의 아티클 요청");
	        } catch (Exception e) {
	            log.error("1대1문의 아티클 오류", e);
	        }
	        return "inquiry/article";
	    }
	 
	 @GetMapping("write")
	    public String Inquirywrite(Model model) {
	        try {
	            log.info("1대1문의 write 요청");
	        } catch (Exception e) {
	            log.error("1대1문의 write 오류", e);
	        }
	        return "inquiry/write";
	    }
}
