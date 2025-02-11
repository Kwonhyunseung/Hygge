package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.service.MemberManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/memberManagement/*")
public class MemberManageController {
	private final MemberManageService service;
	
	@GetMapping("normal")
	public String normalMember(Model model) {
			
		try {
			String authority = "USER";
			
			service.normalMember(authority);
			
			
		} catch (Exception e) {
			log.info("normalMember : ", e);
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
