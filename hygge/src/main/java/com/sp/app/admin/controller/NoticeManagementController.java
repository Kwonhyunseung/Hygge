package com.sp.app.admin.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.NoticeManage;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.SessionInfo;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/notice/*")
@RequiredArgsConstructor
public class NoticeManagementController {
	private final NoticeManageService service; 
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	private String uploadPath;
	
	// 공지 사항
    @PostConstruct
    public void init() {
        uploadPath = storageService.getRealPath("/uploads/notice");
    }
	
	@GetMapping("list")
	public String noticeManageList(
		 @RequestParam(name = "page", defaultValue = "1") int current_page,
		        @RequestParam(name = "schType", defaultValue = "all") String schType,
		        @RequestParam(name = "kwd", defaultValue = "") String kwd,
		        HttpServletRequest req,
		        Model model) throws Exception {
		
		try {
            int size = 10;
            int total_page;
            int dataCount;
			
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
            
            List<NoticeManage> list = service.listNotice(map);
            
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/admin/notice/list";
            String articleUrl = cp + "/admin/notice/article?page=" + current_page;
            
            if (schType.length() != 0) {
                query = "searchKey=" + schType + 
                       "&kwd=" + URLEncoder.encode(kwd, "utf-8");
            }
            
            if (query.length() != 0) {
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
			log.info("list :" ,e);
			throw e;
		}
		
		return "admin/notice/list";
	}
	
	@GetMapping("write")
	public String WriteForm (Model model) throws Exception {
		
		model.addAttribute("mode", "write");
		
		return "admin/notice/write";
	}
	
	@PostMapping("write")
	public String writeSubmit (NoticeManage dto, HttpSession session) throws Exception {
		
		try {
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			 if(info == null) {
	                return "redirect:/member/login"; // 로그인 페이지로 리다이렉트
	            }
			dto.setMemberIdx(info.getMemberidx());
			
			service.insertNotice(dto, uploadPath);
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		
		return "redirect:/admin/notice/list";
	}
	
	@GetMapping("article")
	public String article (
			@RequestParam(name="num") long num,
	        @RequestParam(name="page") String page,
	        @RequestParam(name="schType", defaultValue = "all") String schType,
	        @RequestParam(name="kwd", defaultValue = "") String kwd,
	        Model model,
	        HttpSession session) throws Exception {
		
		try {
			String query = "page=" + page;
			if(kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd,"utf-8");
			}
			
			NoticeManage dto = service.findById(num);
			if(dto == null) {
				return "redirect:/admin/notice/list?" + query;
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("num", num);
			
			NoticeManage prevDto = service.findByPrev(map);
			NoticeManage nextDto = service.findByNext(map);
			
			List<NoticeManage> files = service.listNoticeFile(num);
			
	        model.addAttribute("dto", dto);
	        model.addAttribute("prevDto", prevDto);
	        model.addAttribute("nextDto", nextDto);
	        model.addAttribute("files", files);
	        model.addAttribute("page", page);
	        model.addAttribute("query", query);
	        
	        return "admin/notice/article";
		} catch (Exception e) {
			log.info("article : ", e);
			return "redirect:/admin/notice/list";
		}
	}
	
	@GetMapping("update")
	public String updateForm(
	        @RequestParam(name = "num") long num,
	        @RequestParam(name = "page", defaultValue = "1") String page,
	        HttpSession session,
	        Model model) throws Exception {
	    
	    try {
	        NoticeManage dto = service.findById(num);
	        if(dto == null) {
	            return "redirect:/admin/notice/list?page=" + page;
	        }
	        
	        // 파일 리스트
	        List<NoticeManage> files = service.listNoticeFile(num);
	        
	        model.addAttribute("dto", dto);
	        model.addAttribute("files", files);
	        model.addAttribute("page", page);
	        model.addAttribute("mode", "update");
	        
	    } catch (Exception e) {
	        log.info("updateForm : ", e);
	    }
	    
	    return "admin/notice/write";
	}

	@PostMapping("update")
	public String updateSubmit(
	        NoticeManage dto,
	        @RequestParam(name = "page", defaultValue = "1") String page,
	        HttpSession session) throws Exception {
	    
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if(info == null) {
	            return "redirect:/member/login";
	        }
	        
	        service.updateNotice(dto, uploadPath);
	        
	    } catch (Exception e) {
	        log.info("updateSubmit : ", e);
	    }
	    
	    return "redirect:/admin/notice/list?page=" + page;
	}
	
	@GetMapping("delete")
	public String delete(
	        @RequestParam(name = "num") long num,
	        @RequestParam(name = "page") String page,
	        HttpSession session) throws Exception {
	    
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if(info == null) {
	            return "redirect:/member/login";
	        }
	        
	        service.deleteNotice(num, uploadPath);
	        
	    } catch (Exception e) {
	        log.info("delete : ", e);
	    }
	    
	    return "redirect:/admin/notice/list?page=" + page;
	}
	@PostMapping("deleteList")
	@ResponseBody
	public Map<String, Object> deleteList(
	        @RequestBody Map<String, List<Long>> requestBody,
	        HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    try {

	        List<Long> nums = requestBody.get("nums");

	        if (nums == null || nums.isEmpty()) {
	            response.put("status", "error");
	            response.put("message", "삭제할 공지사항을 선택해주세요.");
	            return response;
	        }

	        // 서비스 계층의 다중 삭제 메서드 호출
	        service.deleteNotices(nums, uploadPath);

	        response.put("status", "success");
	        response.put("message", nums.size() + "개의 공지사항이 삭제되었습니다.");

	    } catch (Exception e) {
	        log.error("Multiple notice deletion failed", e);
	        response.put("status", "error");
	        response.put("message", "공지사항 삭제 중 오류가 발생했습니다.");
	    }

	    return response;
	}
	
}
