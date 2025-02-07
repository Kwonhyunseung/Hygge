package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/notice/*")
public class NoticeManagementController {
	
	@GetMapping("list")
	public String noticeManageList() {
		
		return "admin/notice/list";
	}
	
	@GetMapping("write")
	public String noticeWrite() {
		
		return "admin/notice/write";
	}
}
