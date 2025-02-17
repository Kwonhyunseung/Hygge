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

	@GetMapping("/vote/list")
	public String handleVote(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "vote/list";
	}

	@GetMapping("/vote/article")
	public String voteArticle(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "vote/article";
	}

	@GetMapping("/vote/result")
	public String voteResult(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "vote/result";
	}
}
