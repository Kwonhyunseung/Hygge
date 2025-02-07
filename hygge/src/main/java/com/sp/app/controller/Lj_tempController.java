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

	@GetMapping("/usedBoard/list")
	public String usedBoard(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "usedBoard/list";
	}

	@GetMapping("/usedBoard/article")
	public String usedBoardArticle() {
		try {
			
		} catch (Exception e) {
		}
		return "usedBoard/article";
	}

	@GetMapping("/usedBoard/write")
	public String usedBoardwriteForm() {
		try {
			
		} catch (Exception e) {
		}
		return "usedBoard/write";
	}

}
