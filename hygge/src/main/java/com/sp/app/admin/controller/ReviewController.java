package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/review/*")
public class ReviewController {
	
	@GetMapping("list")
	public String ReviewList() {
		
		return "admin/review/list";
	}
}
