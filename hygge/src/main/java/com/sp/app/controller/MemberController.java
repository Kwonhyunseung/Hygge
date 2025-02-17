package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class MemberController {

	@GetMapping("login") 
	public String loginForm() {
		
		
		
		return "member/login";
	}
	
	
	// 회원가입
	@GetMapping("account")
	public String accountSelect(Model model) {
		try {

		} catch (Exception e) {
		}
		return "member/account";
	}
	
	@PostMapping("account")
	public String accountSelectSubmit(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "member/account2";
	}
	
	@GetMapping("account2")
	public String accountForm(Model model) {
		try {

		} catch (Exception e) {
		}
		return "member/account2";
	}
	
	@PostMapping("account2")
	public String accountSubmit(Model model) {
		try {

		} catch (Exception e) {
		}
		return "redirect:/main/home";
	}
	
	
	
	
	
}