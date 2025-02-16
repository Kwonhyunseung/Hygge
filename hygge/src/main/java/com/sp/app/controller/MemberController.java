package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.Member;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {
	private final MemberService service;

	// ss
	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "login_error", required = false) String login_error, 
			Model model) {
		
		if(login_error != null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		
		return "member/login";
	}
	
	// 회원가입
	@GetMapping("account")
	public String accountSelect(Model model) {
		
		return "member/account";
	}
	@PostMapping("account")
	public String accountSelectSubmit(Model model) {

		return "member/account2";
	}
	
	@GetMapping("account2")
	public String accountForm(Model model) {

		return "member/account2";
	}
	// 회원가입 성공 후 리다이렉트
	@PostMapping("account2")
	public String accountSubmit(Member dto, final RedirectAttributes reAttr, Model model, HttpServletRequest req) {
	    try {
	        service.insertMember(dto);
	    } catch (Exception e) {
	    }

	    return "account/account2";
	}
	
	// 회원가입 완료 페이지
	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {
	    System.out.println("message: " + message); // message가 null이 아닌지 확인

	    if (message == null || message.isBlank()) {
	        return "redirect:/"; // F5로 새로고침했을 때 message가 null이면 홈으로 리다이렉트
	    }

	    return "member/complete";
	}
	
	@ResponseBody
	@PostMapping("checkUserId")
	public Map<String, ?> idCheck(@RequestParam(name = "userId") String userId) throws Exception {
		// ID 중복 검사
		Map<String, Object> model = new HashMap<>();
		
		String p = "false";
		try {
			Member dto = service.findById(userId);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}
		
		model.put("passed", p);
		
		return model;
	}
	
	
	
	
}