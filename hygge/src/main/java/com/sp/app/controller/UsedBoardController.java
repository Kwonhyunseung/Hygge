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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Reply;
import com.sp.app.model.Report;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.UsedBoard;
import com.sp.app.model.UsedRequest;
import com.sp.app.service.UsedBoardService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/usedBoard/*")
@Slf4j
public class UsedBoardController {
	private final UsedBoardService service;
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

			keyword = URLDecoder.decode(keyword, "utf-8");

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
				String qs = "schType=" + searchType + "&kwd=" + URLEncoder.encode(keyword, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
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
		String query = "page=" + pageNo;
		try {
			keyword = URLDecoder.decode(keyword, "utf-8");
			if (!keyword.isBlank()) {
				query += "&schType=" + searchType + "&kwd=" + URLEncoder.encode(keyword, "utf-8");
			}
			UsedBoard dto = Objects.requireNonNull(service.findById(number));

			service.updateHitCount(number);

			Map<String, Object> map = new HashMap<>();
			map.put("schType", searchType);
			map.put("kwd", keyword);
			map.put("num", number);

			UsedBoard nextDTO = service.findByNext(map);
			UsedBoard prevDTO = service.findByPrev(map);

			System.out.println(nextDTO);
			System.out.println(prevDTO);
			model.addAttribute("dto", dto);
			model.addAttribute("nextDTO", nextDTO);
			model.addAttribute("prevDTO", prevDTO);
			model.addAttribute("query", query);
			model.addAttribute("page", pageNo);
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

	@GetMapping("report")
	public String reportArticle(@RequestParam(name = "query") String qs,
			@RequestParam(name = "num") long number,
			@RequestParam(name = "reported") long reportedmemberIdx, HttpSession session) {
		try {
			Report dto = new Report();
			SessionInfo info = Objects.requireNonNull((SessionInfo)session.getAttribute("member"));
			dto.setReportedNumber(number);
			dto.setMemberIdx(info.getMemberidx());
			dto.setMemberIdx2(reportedmemberIdx);
			dto.setTablename("usedBoard");

			service.reportUsedBoard(dto);
		} catch (NullPointerException e) {
			log.info("비로그인 상태: ", e);
			return "redirect:/member/login";
		} catch (Exception e) {
			log.info("reportArticle : ", e);
		}
		return "redirect:/usedBoard/list?" + qs; // qs 는 페이지 번호때문이라도 반드시 존재
	}



	// 댓글 처리
	@ResponseBody
	@PostMapping("insertReply")
	public Map<String, Object> insertReply(Reply dto, HttpServletResponse resp, HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<>();
		try {
			SessionInfo info = Objects.requireNonNull((SessionInfo)session.getAttribute("member"));
			dto.setMemberIdx(info.getMemberidx());
			service.insertReply(dto);

			map.put("state", "true");
		} catch (NullPointerException e) {
			log.info("비로그인 상태 : ", e);
			resp.sendError(401);
		} catch (Exception e) {
			log.info("insertReply : ", e);
			map.put("state", "false");
			resp.sendError(406);
		}
		return map;
	}

	@GetMapping("listReply")
	public String listReply(@RequestParam(name = "num") long number,
			@RequestParam(name="pageNo", defaultValue="1") int current_page,
			Model model, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			dataCount = service.replyCount(number);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(total_page, current_page);

			int offset = (current_page - 1) * size;
			if (offset < 0) offset = 0;

			Map<String, Object> map = new HashMap<>();
			map.put("num", number);
			map.put("offset", offset);
			map.put("size", size);

			List<Reply> listReply = service.listReply(map);

			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");

			boolean isArticleRequested = service.isArticleRequested(number);
			long writerIdx = service.findWriter(number);
			model.addAttribute("boardwriterIdx", writerIdx);
			model.addAttribute("listReply", listReply);
			model.addAttribute("paging", paging);
			model.addAttribute("replyCount", dataCount);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("requested", isArticleRequested);
		} catch (Exception e) {
			log.info("listReply : ", e);
		}
		return "usedBoard/listReply";
	}

	@ResponseBody
	@PostMapping("deleteReply")
	public Map<String, Object> deleteReply(@RequestParam(name = "num") long number,
			@RequestParam(name = "mode") String Mode, HttpServletResponse resp) throws Exception {
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("num", number);
			map.put("mode", Mode);

			service.deleteReply(map);
		} catch (Exception e) {
			log.info("deleteReply : ", e);
			resp.sendError(406);
		}
		return map;
	}

	@GetMapping("listReplyAnswer")
	public String listReplyAnswer(@RequestParam(name = "num") long number,
			Model model, HttpServletResponse resp) throws Exception {
		try {
			List<Reply> listAnswer = service.listReplyAnswer(number);
			model.addAttribute("listAnswer", listAnswer);
		} catch (Exception e) {
			log.info("listReplyAnswer : ", e);
			resp.sendError(406);
			throw e;
		}
		return "usedBoard/listReplyAnswer";
	}

	@ResponseBody
	@PostMapping("countReplyAnswer")
	public Map<String, Object> countReplyAnswer(@RequestParam(name = "num") long number) throws Exception {
		Map<String, Object> model = new HashMap<>();
		int count = 0;
		try {
			count = service.replyAnswerCount(number);
		} catch (Exception e) {
			log.info("countReplyAnswer : ", e);
		}
		model.put("count", count);
		return model;
	}

	@ResponseBody
	@PostMapping("reportReply")
	public Map<String, Object> reportReply(Report dto, HttpSession session, HttpServletResponse resp) throws Exception {
		Map<String, Object> model = new HashMap<>();
		try {
			SessionInfo info = Objects.requireNonNull((SessionInfo)session.getAttribute("member"));
			dto.setMemberIdx(info.getMemberidx());
			dto.setTablename("usedBoardReply");
			service.reportUsedBoard(dto);
			model.put("state", "true");
		} catch (NullPointerException e) {
			log.info("비로그인 상태: ", e);
			resp.sendError(401);
		} catch (Exception e) {
			log.info("reportReply : ", e);
			model.put("state", "false");
		}
		return model;
	}

	@PostMapping("usedRequest")
	public Map<String, Object> requestSubmit(UsedRequest req) throws Exception {
		Map<String, Object> model = new HashMap<>();
		try {
			service.insertRequest(req);
			model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
			log.info("requestSubmit : ", e);
		}
		return model;
	}
}
