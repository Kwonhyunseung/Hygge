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
@RequestMapping("/admin/memberManagement/*")
public class MemberManageController {
	
	@GetMapping("normal")
	public String normalMember(Model model) {
		try {
			
			
			
		} catch (Exception e) {
		}
		return "admin/member/normal";
	}
	
	@GetMapping("maker")
	public String makerMember(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "admin/member/maker";
	}
}
