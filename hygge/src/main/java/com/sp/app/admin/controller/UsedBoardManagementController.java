package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.UsedBoardManage;
import com.sp.app.admin.service.UsedBoardManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin/usedBoard/*")
public class UsedBoardManagementController {
	private final PaginateUtil paginateUtil;
	private final UsedBoardManageService service;
	
	@GetMapping("list")
	public String usedBoardList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model) {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			if (total_page < current_page) {
                current_page = total_page;
            }
			
			int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;
			
            map.put("offset", offset);
            map.put("size", size);
			
			List<UsedBoardManage> UsedList = service.UsedBoardList(map);
			
			String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/admin/usedBoard/list";
            String articleUrl = cp + "/usedBoard/article?page=" + current_page;
			
            if (schType.length() != 0) {
                query = "schType=" + schType + 
                       "&kwd=" + URLEncoder.encode(kwd, "utf-8");
            }
            
            if (query.length() != 0) {
                listUrl += "?" + query;
                articleUrl += "&" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            
            model.addAttribute("dto", UsedList);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("paging", paging);
            
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
		} catch (Exception e) {
			log.info("list :" ,e);
		}
		
		return "admin/usedBoard/list";
	}
	
	@ResponseBody
	@PostMapping("deleteBoards")
	public Map<String, Object> deleteBoard(
			@RequestParam(name = "board_num") List<Long> board_num) throws SQLException {
		Map<String, Object> map = new HashMap<>();
		
		try {
			
			System.out.println(board_num.size() + "사이즈입니다.");
			
			int result = service.deleteUsedBoards(board_num);
			
			if(result > 0) {
	            map.put("status", "success");
	            map.put("deletedCount", result);
			} else {
	            map.put("status", "error");
	            map.put("message", "삭제할 데이터가 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
	        map.put("status", "error");
	        map.put("message", "데이터 삭제 중 오류가 발생했습니다: " + e.getMessage());
	        log.error("deleteBoards : ", e);
		}
		
		return map;
	}
	
	@ResponseBody
	@GetMapping("purchaseStatus")  
	public List<UsedBoardManage> getPurchaseStatus() {
	    return service.getPurchaseStatusList();
	}
	
	@ResponseBody
	@PostMapping("updateTrade")
	public Map<String, Object> handleTradeStatus(
			@RequestParam(name = "action") String action,
			@RequestParam(name = "board_num") long board_num
			) throws Exception{
		Map<String, Object> map = new HashMap<>();
		
		try {
			
			if("approve".equals(action)) {
				service.approveTrade(board_num);
				service.approveTrade1(board_num);
				
				map.put("status", "success");
			} else if ("reject".equals(action)) {
				service.rejectTrade(board_num);
				map.put("status", "false");
			} else {
				System.out.print("서버 전송 오류");
			}
			
		} catch (Exception e) {
			log.info("updateTrade : ", e);
		}
		
		return map;
	}
	
	
	
	
	
	
	
}
