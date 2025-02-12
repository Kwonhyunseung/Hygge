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
@RequestMapping(value = "/funding/*")
public class FundingController {

	@GetMapping("/product")
	public String handleHome(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "funding/main/product";
	}

	@GetMapping("/plan")
	public String plan(Model model) {
		return "funding/main/contentPlan";
	}

	@GetMapping("/review")
	public String review(Model model) {
		return "funding/main/contentReview";
	}

    @GetMapping("/funding/hotContent")
	public String hotContentList() {
    	try {
			
		} catch (Exception e) {
			log.info("hotContentList : ", e);
		}
		return "funding/hotContent";
	}
}