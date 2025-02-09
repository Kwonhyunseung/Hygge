package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/project/*")
public class ProjectController {

	@GetMapping("ratePlan")
	public String ratePlan () {
		
		return "project/ratePlan";
	}
	
	@GetMapping("submit1")
	public String projectSubmit1 () {
		
		return "project/submit1";
	}
}
