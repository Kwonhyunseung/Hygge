package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/projectManagement/*")

	public class ProjectManagementController {
		@GetMapping("list")
		public String normalMember(Model model) {
			try {
			
			} catch (Exception e) {
		}
			
		return "admin/project/list";
	}
}
