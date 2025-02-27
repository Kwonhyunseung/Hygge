package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;
import com.sp.app.service.TesterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/tester/*")
public class TesterController {
	private final TesterService service;

	@GetMapping("list/{num}")
	public String testerInfo(@PathVariable("num") long num, Model model) {
		try {
			TestBoard board = service.testerInfo(num);
			
			if(board == null) {
				return "redirect:/tester/list";
			}
			
			model.addAttribute("testBoard", board);
			
		} catch (Exception e) {
			log.info("testerInfo: ", e);
		}
		
		return "tester/list";
	}
	
	/*
	@GetMapping("testForm/{num}")
	public String testerForm(@PathVariable("num") long num, HttpSession session, Model model) {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) {
				return "redirect:/member/login";
			}
			
			TestBoard board = service.testerInfo(num);
			if(board == null) {
				return "redirect:/tester/list";
			}
			
			// 이미 신청한 체험단 확인?
			
			
			model.addAttribute("testBoard", board);
			
		} catch (Exception e) {
			log.info("testerForm: ", e);
		}
		return "tester/testForm";
	}
	*/
	
	@GetMapping("testForm")
	public String testerForm(HttpSession session, Model model) {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) {
				return "redirect:/member/login";
			}
			
		} catch (Exception e) {
			log.info("testForm: ", e);
		}
		return "tester/testForm";
	}
	
	@PostMapping("testForm")
	public String testSubmit(Tester dto, HttpSession session, Model model) {
		try {
			service.insertTesterForm(dto);
			
		} catch (Exception e) {
			log.info("testSubmit: ", e);
		}
		
		return "redirect:/tester/complete";
	}
	
	@GetMapping("complete")
	public String complete(Model model) {
		try {
			
		} catch (Exception e) {

		}
		return "tester/complete";
	}

}