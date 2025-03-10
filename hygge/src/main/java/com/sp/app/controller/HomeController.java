package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.HomeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	/* private final MakerService makerService; */
	private final HomeService service;
	private final PaginateUtil paginateUtil;

	@GetMapping("/")
	public String handleHome(HttpSession session, Model model) {
		try {
			List<Category> parentCategories = service.subListCategory(0);
            model.addAttribute("parentCategories", parentCategories);

            Map<String, List<Category>> subCategoriesMap = new HashMap<>();
            
            for (Category parent : parentCategories) {
                long categoryNum = parent.getCategory_num();
                List<Category> subCategories = service.subListCategory(categoryNum);
                subCategoriesMap.put(parent.getName(), subCategories);
            }
            
            model.addAttribute("subCategoriesMap", subCategoriesMap);
            
            
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			// 프로젝트 조회
	        Map<String, Object> map = new HashMap<>();
	        
	        if (info != null) {
	            map.put("memberIdx", info.getMemberidx());
	        }
            
            List<Funding> newProjects = service.listNewProjects(map);
            model.addAttribute("newProjects", newProjects);
            
            List<Funding> popularProjects = service.listPopularProjects(map);
            model.addAttribute("popularProjects", popularProjects);
            
            List<Funding> deadlineProjects = service.listDeadlineProjects(map);
            model.addAttribute("deadlineProjects", deadlineProjects);
            
            List<Funding> comingProjects = service.listComingProjects(map);
            model.addAttribute("comingProjects", comingProjects);
            
            List<Funding> rankingProjects = service.listRankingProjects(map);
            model.addAttribute("rankingProjects", rankingProjects);
            
            model.addAttribute("isLoggedIn", info != null);
            
		} catch (Exception e) {
		}
		
		return "main/home";
	}

	@GetMapping("/search")
	public String search(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "") String keyword,
			Model model, HttpSession session) {
		try {
			model.addAttribute("keyword", keyword);
		} catch (Exception e) {
			log.info("search : ", e);
		}
		return "funding/funding_list2";
	}

	@ResponseBody
	@GetMapping("/search/fundingList")
	public Map<String, Object> searchFundingList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "") String keyword,
			@RequestParam(name = "order") String Order, HttpSession session) {
		Map<String, Object> model = new HashMap<>();
		try {
			int size = 20;
			int total_page = 0;
			int dataCount = 0;

			Map<String, Object> map = new HashMap<>();
			map.put("kwd", keyword);
			map.put("order", Order);

			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(total_page, current_page);
			int offset = (current_page - 1) * size;
			if (offset < 0 ) offset = 0;

			map.put("size", size);
			map.put("offset", offset);

			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info != null) {
				map.put("memberIdx", info.getMemberidx());
			}

			List<Funding> list = service.listFunding(map);

			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("page", current_page);
			model.put("total_page", total_page);
			model.put("keyword", keyword);
		} catch (Exception e) {
			log.info("searchFundingList : ", e);
		}
		return model;
	}
}