package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;
import com.sp.app.admin.service.VoteManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.VoteService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/vote/*")
public class VoteController {
	private final VoteManageService service;
	private final VoteService service1;
	private final PaginateUtil paginateUtil;
	
	
	@GetMapping("list")
	public String VoteList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		try {
			int size = 6;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page-1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/vote/list";
			
			if(! kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" +
						URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			List<VoteManage> vote = service.voteList(map);
			
			model.addAttribute("vote", vote);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);
			
		} catch (Exception e) {
			log.info("VoteList : ", e);
		}
		
		return "vote/list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		List<ProjectManage> projects = null;
		try {
			
			projects = service.projectList();
			
			model.addAttribute("projects", projects);
			
			System.out.println(projects.size());
			
		} catch (Exception e) {
			log.info("writeForm : ",e);
		}
		
		return "vote/write";
	}	
	
	@PostMapping("write")
	public String writeSubmit(
			@RequestParam(name = "title") String title,
			@RequestParam(name = "content") String content,
			@RequestParam(name = "start_date") String start_date,
			@RequestParam(name = "projectNum1") long projectNum1,
			@RequestParam(name = "projectNum2") long projectNum2,
			@RequestParam(name = "projectNum3") long projectNum3,
			@RequestParam(name = "projectNum4") long projectNum4,
			Model model) throws Exception {
		
		try {
			
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Date startDate = sdf.parse(start_date);
			
			VoteManage voteDto = new VoteManage();
			voteDto.setContent(content);
			voteDto.setTitle(title);
			voteDto.setStart_date(startDate);
			service.insertVote(voteDto);
			
			service.insertVoteCandidate(projectNum1);
			service.insertVoteCandidate(projectNum2);
			service.insertVoteCandidate(projectNum3);
			service.insertVoteCandidate(projectNum4);
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		
		return "redirect:/vote/list";
	}

	
	@GetMapping("article/{vote_num}")
	public String article(
			@PathVariable("vote_num") long vote_num,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpSession session) throws Exception {
		
		String query = "page=" + page;
		
		try {
			kwd = URLDecoder.decode(kwd, "utf-8");
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd="
						+ URLEncoder.encode(kwd, "utf-8");
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("num", vote_num);
			
			VoteManage dto = service.findVote(vote_num);
			
		    List<ProjectManage> projectDto = service.findVoteCandidates(vote_num);
		    System.out.println("Projects size: " + projectDto.size());  // 크기 확인
		    for(ProjectManage p : projectDto) {
		        System.out.println("Project title: " + p.getTitle());  // 각 프로젝트 제목 출력
		    }
			
			model.addAttribute("projectDto", projectDto);
			model.addAttribute("dto", dto); // 게시글 정보
			model.addAttribute("query", query);
			model.addAttribute("page", page);
			
			return "vote/article";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/vote/list?" + query;
	}	
	
	@GetMapping("delete")
	public String deleteVote(
			@RequestParam(name = "vote_num") long vote_num
			) throws Exception {
		
		try {
			service.deleteVote(vote_num);
		} catch (Exception e) {
			log.info("deleteVote : ", e);
		}
		
		return "redirect:/vote/list";
	}
	
	@PostMapping("article/{vote_num}")
	public String voteSubmit(@PathVariable("vote_num") long vote_num,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "project_num") long num,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		
		try {
			long memberIdx = info.getMemberidx();
			Map<String, Object> map = new HashMap<>();
			
			map.put("memberIdx", memberIdx); // memberIdx 전달
			map.put("project_num", num);
			map.put("vote_num", vote_num);
			map.put("page", current_page);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			service1.voteSubmit(map);
			
		} catch (Exception e) {
			log.info("voteSubmit : ", e);
		}
		
		return "redirect:/vote/list";
	}
}
