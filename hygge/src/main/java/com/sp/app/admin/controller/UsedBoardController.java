package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/usedBoard/*")
public class UsedBoardController {
	
	@GetMapping("list")
	public String usedBoardList() {
		
		return "admin/usedBoard/list";
	}
}
