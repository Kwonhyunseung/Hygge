package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;
import com.sp.app.service.TesterService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/tester/*")
public class TesterController {
	private final TesterService service;
	private final PaginateUtil paginateUtil;
    
    
	@GetMapping("list")
	public String list(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpServletRequest req,
            HttpSession session,
			Model model) {
		
		try {
            int size = 6;
            int total_page = 0;
            int dataCount = 0;
            
            kwd = URLDecoder.decode(kwd , "UTF-8");
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            dataCount = service.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            
            current_page = Math.min(current_page, total_page);
            
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<TestBoard> list = service.testBoardList(map);
            
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/tester/list";
            String articleUrl = cp + "/tester/article?page=" + current_page;
            
            if (! kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
                listUrl += "?" + query;
                articleUrl += "&" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            
            model.addAttribute("list", list);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
			
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
	public String testSubmit(@ModelAttribute Tester dto, RedirectAttributes ra) {
	    try {
	        // 중복 신청 체크
	        boolean isDuplicate = service.checkDuplicateApplication(dto.getMemberIdx(), dto.getNum());

	        if (isDuplicate) {
	            ra.addFlashAttribute("duplicateError", true);
	            return "redirect:/tester/testForm/" + dto.getNum();
	        }

	        service.insertTesterForm(dto);
	        ra.addFlashAttribute("submitSuccess", true);
	        return "redirect:/tester/testForm/" + dto.getNum();

	    } catch (Exception e) {
	        log.error("testSubmit error: ", e);
	        return "redirect:/tester/list";
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