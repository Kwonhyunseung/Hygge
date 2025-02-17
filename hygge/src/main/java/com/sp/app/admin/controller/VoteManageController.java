package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/vote/")
public class VoteManageController {

	
	@GetMapping("list")
	public String VoteList() throws Exception {
		
		
		return "admin/vote/list";
	}
	
	@GetMapping("write")
	public String writeForm() throws Exception {
		
		
		return "admin/vote/write";
	}	

	
	@GetMapping("article")
	public String article() throws Exception {
		
		
		return "admin/vote/article";
	}	
}
