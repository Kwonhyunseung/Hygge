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

import jakarta.servlet.http.HttpSession;
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
	public String projectSubmit1(Funding dto, Model model, HttpSession session) throws Exception {
		try {
			if (session.getAttribute("submit1") == null) {
				session.setAttribute("submit1", dto);
			}
		} catch (Exception e) {
			log.info("projectSubmit1 : ", e);
		}
		return "makerPage/submit1";
	}

	@GetMapping("projectSubmit2")
	public String projectSubmit2(Funding dto, Model model, HttpSession session) throws Exception {
		try {
			session.setAttribute("submit1", dto);
		} catch (Exception e) {
			log.info("projectSubmit2 : ", e);
		}
		return "makerPage/submit2";
	}

	@GetMapping("projectSubmit3")
	public String projectSubmit3(Funding dto, Model model, HttpSession session) throws Exception {
		try {
			List<Category> parentCategory = service.listCategory(0);
			model.addAttribute("parentCategory", parentCategory);
			session.setAttribute("submit1", dto);
		} catch (Exception e) {
			log.info("projectSubmit3 : ", e);
		}
		return "makerPage/submit3";
	}

	@GetMapping("projectSubmit4")
	public String projectSubmit4(Funding dto, Model model, HttpSession session) throws Exception {
		try {
			session.setAttribute("submit1", dto);
		} catch (Exception e) {
			log.info("projectSubmit4 : ", e);
		}
		return "makerPage/submit4";
	}

	@GetMapping("projectSubmit5")
	public String projectSubmit5(Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit5 : ", e);
		}
		return "makerPage/submit5";
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
