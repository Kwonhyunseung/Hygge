package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.service.MakerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/makerPage/*")
@Slf4j
public class MakerController {
	private final MakerService service;

	@GetMapping("projectSign")
	public String projectSign() throws Exception {
		return "project/projectSign";
	}

	@GetMapping("projectSubmit")
	public String projectPreSubmit1(Funding dto, Model model) throws Exception {
		try {
			List<Category> parentCategory = service.listCategory(0);
			model.addAttribute("parentCategory", parentCategory);
		} catch (Exception e) {
			log.info("projectPreSubmit1 : ", e);
		}
		return "project/makerStudio";
	}

	@ResponseBody
	@GetMapping("categories")
	public Map<String, Object> projectPreSubmitCategories(@RequestParam(name = "num") long number) throws Exception {
		Map<String, Object> model = new HashMap<>();
		try {
			List<Category> categories = service.listCategory(number);
			model.put("categories", categories);
			model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
			log.info("projectPreSubmitCategories : ", e);
		}
		return model;
	}
}
