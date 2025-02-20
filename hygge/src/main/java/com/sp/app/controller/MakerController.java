package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.service.MakerService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@SessionAttributes("funding")
@Controller
@RequiredArgsConstructor
@RequestMapping("/makerPage/*")
@Slf4j
public class MakerController {
	private final MakerService service;

	@GetMapping("projectSign")
	public String projectSign() throws Exception {
		return "makerPage/projectSign";
	}

	@GetMapping("preProjectSubmit")
	public String projectPreSubmit() throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectPreSubmit : ", e);
		}
		return "makerPage/makerStudio2";
	}

	@GetMapping("projectSubmit1")
	public String projectForm1(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectForm1 : ", e);
		}
		return "makerPage/submit1";
	}

	@PostMapping("projectSubmit1")
	public String projectSubmit1(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit1 : ", e);
		}
		return "redirect:/makerPage/projectSubmit2";
	}

	@GetMapping("projectSubmit2")
	public String projectForm2(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit2 : ", e);
		}
		return "makerPage/submit2";
	}

	@GetMapping("projectSubmit3")
	public String projectForm3(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
			List<Category> parentCategory = service.listCategory(0);
			model.addAttribute("parentCategory", parentCategory);
		} catch (Exception e) {
			log.info("projectSubmit3 : ", e);
		}
		return "makerPage/submit3";
	}

	@GetMapping("projectSubmit4")
	public String projectForm4(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit4 : ", e);
		}
		return "makerPage/submit4";
	}

	@GetMapping("projectSubmit5")
	public String projectForm5(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit5 : ", e);
		}
		return "makerPage/submit5";
	}

	@ModelAttribute("funding")
	public Funding getFunding() {
		return new Funding();
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
