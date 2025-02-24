package com.sp.app.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.support.SessionStatus;

import com.sp.app.common.StorageService;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MakerService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@SessionAttributes({"funding", "product"})
@Controller
@RequiredArgsConstructor
@RequestMapping("/makerPage/*")
@Slf4j
public class MakerController {
	private final MakerService service;
	private final StorageService storageService;
	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = storageService.getRealPath("/uploads/project");
	}

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
			if (dto.getThumbnail_File() != null) {
				dto.setThumbnail(storageService.uploadFileToServer(dto.getThumbnail_File(), uploadPath));
			}
			if (dto.getBusiness_File() != null) {
				dto.setBusiness(1);
			} else {
				dto.setBusiness(0);
			}
		} catch (Exception e) {
			log.info("projectSubmit1 : ", e);
		}
		return "redirect:/makerPage/projectSubmit2";
	}

	@GetMapping("projectSubmit2")
	public String projectForm2(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
			
		} catch (Exception e) {
			log.info("projectForm2 : ", e);
		}
		return "makerPage/submit2";
	}

	@PostMapping("projectSubmit2")
	public String projectSubmit2(@ModelAttribute("funding") Funding dto, Model model, SessionStatus sessionStatus, HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if (info == null) {
				model.addAttribute("msg", "로그인처리가 되지 않았습니다.");
				return "redirect:/makerPage/projectSubmit2";
			}
			dto.setMemberIdx(info.getMemberidx());
			service.insertTempProjectRequest(dto, uploadPath);
			model.addAttribute("msg", "임시 저장되었습니다.");
			sessionStatus.setComplete();
		} catch (Exception e) {
			log.info("projectSubmit2 : ", e);
		}
		return "redirect:/makerPage/projectSubmit3";
	}

	@GetMapping("projectSubmit3")
	public String projectForm3(Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectForm3 : ", e);
		}
		return "makerPage/submit3";
	}
	
	@PostMapping("projectSubmit3")
	public String projectSubmit3(Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit3 : ", e);
		}
		return "redirect:/makerPage/projectSubmit4";
	}

	@GetMapping("projectSubmit4")
	public String projectForm4(Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit4 : ", e);
		}
		return "makerPage/submit4";
	}
	
	@PostMapping("projectSubmit4")
	public String projectSubmit4(@ModelAttribute("funding") Funding dto, Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit4 : ", e);
		}
		return "redirect:/makerPage/projectSubmit5";
	}

	@GetMapping("projectSubmit5")
	public String projectForm5(Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectForm5 : ", e);
		}
		return "makerPage/submit5";
	}

	@PostMapping("projectSubmit5")
	public String projectSubmit5(Model model) throws Exception {
		try {
		} catch (Exception e) {
			log.info("projectSubmit5 : ", e);
		}
		return "redirect:/makerPage/projectSubmit";
	}

	@GetMapping("projectSubmit")
	public String submit() {
		return "";
	}

	@ModelAttribute("funding")
	public Funding getFunding() {
		return new Funding();
	}
	
	@ModelAttribute("product")
	public List<Product> getProductList() {
		List<Product> listProduct = new ArrayList<>();
		return listProduct;
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

	@ResponseBody
	@PostMapping("deleteThumbnail")
	public Map<String, Object> deleteThumbnail(@ModelAttribute("funding") Funding dto, @RequestParam(name = "fileName") String filename) throws Exception {
		Map<String, Object> model = new HashMap<>();
		try {
			storageService.deleteFile(uploadPath, filename);
			dto.setThumbnail(null);
			model.put("state", "true");
		} catch (Exception e) {
			log.info("deleteThumbnail : ", e);
			model.put("state", "false");
		}
		return model;
	}
}
