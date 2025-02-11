package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.UsedBoard;
import com.sp.app.service.MemberService;
import com.sp.app.service.UsedBoardService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/usedBoard/*")
@Slf4j
public class UsedBoardController {
	private final UsedBoardService service;
	private final MemberService memberService;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = storageService.getRealPath("/uploads/usedBoard");
	}

	@GetMapping("list")
	public String main(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String searchType,
			@RequestParam(name = "kwd", defaultValue = "") String keyword,
			Model model, HttpServletRequest req) {
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			keyword = URLEncoder.encode(keyword, "utf-8");

			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", searchType);
			map.put("kwd", keyword);
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(total_page, current_page);

			int offset = (current_page - 1) * size;
			if (offset < 0) offset = 0;
			map.put("offset", offset);
			map.put("size", size);

			List<UsedBoard> list = service.listBoard(map);

			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/usedBoard/list";
			String articleUrl = cp + "/usedBoard/article";
			if (!keyword.isBlank()) {
				String qs = "schType=" + searchType + "&kwd=" + URLDecoder.decode(keyword, "utf-8");
				query += "&" + qs;
			}
			listUrl += "?" + query;
			articleUrl += "?" + query;
			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("schType", searchType);
			model.addAttribute("kwd", keyword);
			model.addAttribute("query", query);
		} catch (Exception e) {
			log.info("main : ", e);
		}
		return "usedBoard/list";
	}

	@GetMapping("write")
	public String writeForm(Model model, HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if (info == null) {
				
				return "redirect:/usedBoard/list";
			}
			model.addAttribute("mode", "write");
		} catch (Exception e) {
			log.info("writeForm: ", e);
		}
		return "usedBoard/write";
	}

	@PostMapping("write")
	public String writeSubmit(UsedBoard dto, HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto.setMemberIdx(info.getMemberidx());

			service.insertBoard(dto, uploadPath);
		} catch (Exception e) {
			log.info("writeSubmit: ", e);
		}
		return "redirect:/usedBoard/list";
	}

	@GetMapping("article")
	public String article(@RequestParam(name = "num") long number,
			@RequestParam(name = "page") String pageNo,
			@RequestParam(name = "schType", defaultValue = "all") String searchType,
			@RequestParam(name = "kwd", defaultValue="") String keyword, Model model) {
		try {
			UsedBoard dto = Objects.requireNonNull(service.findById(number));

			model.addAttribute("dto", dto);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		return "usedBoard/article";
	}

	@GetMapping("delete")
	public String delete(@RequestParam(name = "num") long number, HttpSession session) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			long memberidx = info.getMemberidx();
			String authority = info.getAuthority();
			service.deleteBoard(number, uploadPath, memberidx, authority);
		} catch (Exception e) {
			log.info("delete : ", e);
		}
		return "redirect:/usedBoard/list";
	}
}
