package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/tester/*")
public class testerController {

	@GetMapping("list")
	public String handleHome(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "tester/list";
	}
	
	@GetMapping("testForm")
	public String handleHome1(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "tester/testForm";
	}
}

