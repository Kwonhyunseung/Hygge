package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MakerBoard;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MakerBoardService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/makerPage/*")
public class MakerBoardController {
		
	@Autowired
	private final MakerBoardService service;
	
	@Autowired
	private final PaginateUtil paginateUtil;
	
	@GetMapping("makerBoard")
	public String makerBoard(Model model,
			@RequestParam(name="makerIdx") long makerIdx,
    		@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpSession session,
            HttpServletRequest req) {
		
		
		try {
			log.info("메이커 페이지 요청");
           
			int size = 10;
            int total_page;
            int dataCount;
			
            kwd = URLDecoder.decode(kwd, "UTF-8");
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("makerIdx", makerIdx);

            
            dataCount = service.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);
            
            int offset = (current_page -1) * size;
            if(offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<MakerBoard> listBoard = service.listBoard(map);
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "makerPage/makerBoard";
            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
                listUrl = cp + "/makerPage/makerBoard?" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            System.out.println(dataCount+", "+current_page+", "+size);
            // 모델에 데이터 담기 (목록은 qnaList, 상세 링크는 articleUrl 등)
            model.addAttribute("listBoard", listBoard);
            //model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
		} catch (Exception e) {
			log.error("메이커 페이지 컨트롤러 오류", e);
		}
		
		return "makerPage/makerBoard";
		
	}
	@ResponseBody
	@PostMapping("boardLike")
	public Map<String, Object> boardLike(@RequestParam(name = "mkboard_Num") long num,
			@RequestParam(name = "userLiked", defaultValue = "false") 
			boolean userLiked,
			HttpSession session,
			HttpServletResponse resp) {
				
		Map<String, Object> model = new HashMap<>();
		String state = "true";
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				model.put("message", "로그인이 필요한 서비스입니다.");
				return model;
			}
			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("memberIdx", info.getMemberidx());
			
			int count = service.userBoardLiked(map);
			
			if(count > 0) {
				service.deleteBoardLike(map);
			}else {
				service.insertBoardLike(map);
			}
			
			int likeCount = service.countLike(num);
			
			model.put("state", state);
			model.put("likeCount", likeCount);
			model.put("isLiked", count == 0);
			
		} catch (Exception e) {
			log.error("좋아요 처리 중 오류", e);
			state = "false";
			model.put("state", state);
			model.put("message", "서버 오류가 발생했습니다.");
		}
		
		
		return model;
		
	}
	
	
}
