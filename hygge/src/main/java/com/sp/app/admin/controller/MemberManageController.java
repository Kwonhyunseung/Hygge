package com.sp.app.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.model.MemberManage;
import com.sp.app.admin.service.MemberManageService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/memberManagement/*")
public class MemberManageController {
	private final MemberManageService service;
	
	@GetMapping("normal")
	public String normalMember(HttpServletRequest req,Model model) {
		List<MemberManage> member;
		
		try {
			String authority = "USER";
			
			member = service.normalMember(authority);
			
			model.addAttribute("member", member);
			
		} catch (Exception e) {
			log.info("normalMember : ", e);
		}
		
		return "admin/member/normal";
		
	}
	
	@GetMapping("maker")
	public String makerMember(Model model) {
		List<MemberManage> member;
		
		try {
			String authority = "MAKER";
			
			member = service.normalMember(authority);
			
			model.addAttribute("member", member);
			
		} catch (Exception e) {
			log.info("normalMember : ", e);
		}
		
		return "admin/member/maker";
		
	}
}
