package com.sp.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sp.app.model.Category;
import com.sp.app.service.MakerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	private final MakerService makerService;

	@GetMapping("/")
	public String handleHome(Model model) {
		try {
			List<Category> parentCategories = makerService.listCategory(0);
			List<Category> childCategories01 = makerService.listCategory(1);
			List<Category> childCategories02 = makerService.listCategory(2);
			List<Category> childCategories03 = makerService.listCategory(3);
			List<Category> childCategories04 = makerService.listCategory(4);
			List<Category> childCategories05 = makerService.listCategory(5);
			List<Category> childCategories06 = makerService.listCategory(6);
			List<Category> childCategories07 = makerService.listCategory(7);
			List<Category> childCategories08 = makerService.listCategory(8);
			List<Category> childCategories09 = makerService.listCategory(9);

			model.addAttribute("parentCategories", parentCategories);
			model.addAttribute("childCategories01", childCategories01);
			model.addAttribute("childCategories02", childCategories02);
			model.addAttribute("childCategories03", childCategories03);
			model.addAttribute("childCategories04", childCategories04);
			model.addAttribute("childCategories05", childCategories05);
			model.addAttribute("childCategories06", childCategories06);
			model.addAttribute("childCategories07", childCategories07);
			model.addAttribute("childCategories08", childCategories08);
			model.addAttribute("childCategories09", childCategories09);
		} catch (Exception e) {
		}
		return "main/home";
	}
}
