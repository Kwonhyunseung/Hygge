package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class wishListController {

	@GetMapping("wishlist")
	public String handleHome(Model model) {
		try {
			
		} catch (Exception e) {
		}
		return "wish/list";
	}
}

