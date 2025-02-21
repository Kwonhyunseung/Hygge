package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;
import com.sp.app.admin.service.VoteManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/vote/")
public class VoteManageController {
	private final VoteManageService service;
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
			String listUrl = cp + "/admin/vote/list";
			
			if(! kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" +
						URLEncoder.encode(kwd, "utf-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			List<VoteManage> vote = service.voteList(map);
			
			//총 투표수
			
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
		
		return "admin/vote/list";
	}
	
	@GetMapping("write")
	public String writeForm(@RequestParam(name = "vote_num") Long vote_num,
			Model model) throws Exception {
		
		String mode = "write";
		List<ProjectManage> projects = null;
		VoteManage dto = new VoteManage();
		List<ProjectManage> selectedProjects = null;
		
		try {
			projects = service.projectList();
			
			if(vote_num != null) {
				mode = "update";
				dto = service.findVote(vote_num);
				selectedProjects = service.findVoteCandidates(vote_num);
			}
			
	        model.addAttribute("mode", mode);
	        model.addAttribute("dto", dto);
	        model.addAttribute("projects", projects);
	        model.addAttribute("selectedProjects", selectedProjects);			
			
		} catch (Exception e) {
			log.info("writeForm : ",e);
		}
		
		return "admin/vote/write";
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
		
		return "redirect:/admin/vote/list";
	}
	
	@GetMapping("update")
	public String updateForm(@RequestParam(name = "vote_num") long vote_num,
			Model model) {
		
		
		try {
			VoteManage dto = service.findVote(vote_num);
			if(dto == null) {
				return "redirect:/admin/vote/list";
			}
			
			List<ProjectManage> projects = service.projectList();
			
			List<ProjectManage> currentCandidates = service.findVoteCandidates(vote_num);
			
			model.addAttribute("dto", dto);
			model.addAttribute("projects", projects);
			model.addAttribute("currentCandidates", currentCandidates);
			
			
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "admin/vote/write";
	}
	
	@PostMapping("update")
	public String updateSubmit(VoteManage voteManage,
		    @RequestParam(name = "projectNum1") long projectNum1,
		    @RequestParam(name = "projectNum1") long projectNum2,
		    @RequestParam(name = "projectNum1") long projectNum3,
		    @RequestParam(name = "projectNum1") long projectNum4
		    ) throws Exception {
		
		try {
			service.updateVote(voteManage);
			
			service.deleteVoteCandidate(voteManage.getVote_num());
			
	        service.insertVoteCandidate(projectNum1);
	        service.insertVoteCandidate(projectNum2);
	        service.insertVoteCandidate(projectNum3);
	        service.insertVoteCandidate(projectNum4);
			
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}
		
		return "redirect:/admin/vote/list";
	}
	

}
