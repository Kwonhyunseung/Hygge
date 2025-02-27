package com.sp.app.controller;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;

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
	
	@GetMapping("account2")
	public String accountForm(Model model) {
		return "member/account2";
	}

	@PostMapping("account2")
	public String accountSubmit(Member dto, final RedirectAttributes reAttr, Model model, HttpServletRequest req) {
	    try {
	    	
	    	service.insertMember(dto);
	        
	        StringBuilder sb = new StringBuilder();
			sb.append(dto.getName() + "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
			
			// 리다이렉트된 페이지에 값 넘기기
			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("title", "회원 가입");
		
			return "redirect:/member/complete";
			
		} catch (Exception e) {
			log.info("accountSubmit: ", e);
		}

		return "member/account2";
	}
	
	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		if (message == null || message.isBlank()) { // F5를 누른 경우
			return "redirect:/";
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
	
	public void calculateAge(Member dto) {
	    String birthString = dto.getBirth();
	    
	    if (birthString != null && !birthString.isEmpty()) {
	        try {
	            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	            LocalDate birthDate = LocalDate.parse(birthString, formatter);
	            
	            // 나이 계산
	            int age = Period.between(birthDate, LocalDate.now()).getYears();
	            dto.setAge(age);
	            
	        } catch (DateTimeParseException e) {
	            System.out.println("잘못된 날짜 형식: " + birthString);
	        }
	    }
	    
	}

	
	
	
	
}