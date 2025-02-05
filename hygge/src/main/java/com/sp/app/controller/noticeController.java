package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/notice/*")
public class noticeController {

	@GetMapping("list")
	public String handleHome(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "notice/list";
	}
}
