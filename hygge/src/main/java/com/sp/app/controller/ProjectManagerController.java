package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/makerPage/*")
public class ProjectManagerController {
	
	@GetMapping("projectManager")
	public String projectManager() {
		return "project/projectManager";
	}
	
}
