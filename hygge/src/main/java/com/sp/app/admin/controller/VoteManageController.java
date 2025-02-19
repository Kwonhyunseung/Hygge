package com.sp.app.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.service.VoteManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/vote/")
public class VoteManageController {
	private final VoteManageService service;
	
	@GetMapping("list")
	public String VoteList() throws Exception {
		
		return "admin/vote/list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		
		try {
			// 프로젝트 리스트
			
		} catch (Exception e) {
			log.info("writeForm : ",e);
		}
		
		return "admin/vote/write";
	}	
	
	@PostMapping("write")
	public String writeSubmit(Model model) throws Exception {
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "admin/vote/write";
	}

	
	@GetMapping("article")
	public String article() throws Exception {
		
		
		return "admin/vote/article";
	}	
}
