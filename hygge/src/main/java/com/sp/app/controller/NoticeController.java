package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice/")
public class NoticeController {

	@GetMapping("list")
	public String noticeList() {
		
		return "notice/list";
	}
	
	@GetMapping("article")
	public String article() {
		
		return "notice/article";
	}
}
