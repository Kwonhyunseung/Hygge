package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class Lj_tempController {

	@GetMapping("/event")
	public String handleEvent(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "event/list";
	}

}
