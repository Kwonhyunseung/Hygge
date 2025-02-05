package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/member/*")
public class memberController {
	private final MemberService memberService;
	
	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "login_error", required = false) String login_error, 
			Model model) {
		
		
		if(login_error != null) {
			model.addAttribute("message", "이메일 또는 패스워드가 일치하지 않습니다.");
		}
		
		return "member/login";
	}
	
	@GetMapping("logout")
	public String logout(HttpServletRequest request) throws Exception {
	    HttpSession session = request.getSession();
	    session.removeAttribute("member");
	    session.invalidate();
	    
	    return "redirect:/";  // 메인 페이지로 리다이렉트
	}	
	/*
	@GetMapping(value = "noAuthorized")
	public String noAuthorized() {
		// 권한이 없는 경우
		return "member/noAuthorized";
	}
	
	@GetMapping(value="expired")
	public String expired() {
		// 세션이 익스파이어드(만료) 된 경우
		return "member/expired";
	}
	*/
}
