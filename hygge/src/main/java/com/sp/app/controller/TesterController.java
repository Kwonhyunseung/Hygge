package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;
import com.sp.app.service.TesterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/tester/*")
public class TesterController {
	private final TesterService service;

	@GetMapping("list")
	public String list(Model model) {
		try {
			// TODO: 체험단 리스트 가져오기
		} catch (Exception e) {
			log.info("list: ", e);
		}
		return "tester/list";
	}

	@GetMapping("testForm/{num}")
	public String testerForm(@PathVariable("num") long num, HttpSession session, Model model) {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return "redirect:/member/login";
			}

			TestBoard board = service.testerInfo(num);
			if (board == null) {
				return "redirect:/tester/list";
			}

			model.addAttribute("testBoard", board);
			model.addAttribute("member", info);

		} catch (Exception e) {
			log.error("testerForm error: ", e);
			return "redirect:/tester/list";
		}
		return "tester/testForm";
	}

	@PostMapping("/testForm")
	public String testSubmit(@ModelAttribute Tester dto, Model model, RedirectAttributes ra) {
	    try {
	        // 중복 신청 체크
	        boolean isDuplicate = service.checkDuplicateApplication(dto.getMemberIdx(), dto.getNum());
	        
	        if (isDuplicate) {
	            ra.addFlashAttribute("duplicateError", true);
	            return "redirect:/tester/testForm/" + dto.getNum();
	        }
	        
	        service.insertTesterForm(dto);
	        ra.addFlashAttribute("message", "신청이 완료되었습니다.");
	        return "redirect:/";
	        
	    } catch (Exception e) {
	        log.error("testSubmit error: ", e);
	        ra.addFlashAttribute("systemError", true);
	        return "redirect:/tester/testForm/" + dto.getNum();
	    }
	}

	@GetMapping("complete")
	public String complete(Model model) {
		try {
			model.addAttribute("title", "체험단 신청 완료");
			model.addAttribute("message", "체험단 신청이 완료되었습니다.");
		} catch (Exception e) {
			log.info("complete: ", e);
		}
		return "tester/complete";
	}
}