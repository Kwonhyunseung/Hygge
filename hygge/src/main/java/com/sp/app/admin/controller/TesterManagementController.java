package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/tester/*")
public class TesterManagementController {
	
	@GetMapping("list")
	public String testerList(Model model) {
		try {
		} catch (Exception e) {
		}
		return "admin/tester/list";
	}
}
