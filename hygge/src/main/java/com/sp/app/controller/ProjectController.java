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
	
	@GetMapping("submit2")
	public String projectSubmit2 () {
		
		return "project/submit2";
	}
	
	@GetMapping("submit3")
	public String projectSubmit3 () {
		
		return "project/submit3";
	}
}
