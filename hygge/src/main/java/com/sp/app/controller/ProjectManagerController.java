package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.ProjectManager;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProjectManagerService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/makerPage/*")
public class ProjectManagerController {
	
	@Autowired
	private final ProjectManagerService service;
   
	@Autowired
    private final PaginateUtil paginateUtil;
	
	@Autowired
	private final StorageService storageService;
	
	private String uploadPath;
	
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/makerBoard");
		
	}		
	@GetMapping("projectManager")
	public String projectManager(Model model,
    		@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "tab", defaultValue = "1") int tab,
            HttpSession session,
            HttpServletRequest req) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			log.info("리스트 요청");
			
		     int size = 10;
	         int total_page;
	         int dataCount;
	         
	         kwd = URLDecoder.decode(kwd, "UTF-8");
	         
	         
	         Map<String, Object> map = new HashMap<>();
	         map.put("schType", schType);
	         map.put("kwd", kwd);
	         map.put("memberIdx", info.getMemberidx());
	         map.put("makeridx", info.getMemberidx());
	         
	         
	         dataCount = service.dataCount(map);
	         dataCount = service.b_dataCount(map);
	         total_page = paginateUtil.pageCount(dataCount, size);
	         current_page = Math.min(current_page, total_page);
	         
	         int offset = (current_page - 1) * size;
	         if (offset < 0) offset = 0;
	        
	         
	         map.put("offset", offset);
	         map.put("size", size);
	         
	         
	         List<ProjectManager> listProject = service.listProject(map);
	         List<ProjectManager> listboard = service.listboard(map);
	         String cp = req.getContextPath();
	         String query = "tab=" + tab;
	         String listUrl = cp + "/makerPage/projectManager";
	           
	         
	         if (!kwd.isBlank()) {
	                query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
	                listUrl = cp + "/makerPage/projectManager?" + query;
	            }	         
	         
	            String paging = paginateUtil.paging(current_page, total_page, listUrl);
	            System.out.println(dataCount+", "+current_page+", "+size);
	            // 모델에 데이터 담기 (목록은 qnaList, 상세 링크는 articleUrl 등)
	            model.addAttribute("listProject", listProject);
	            model.addAttribute("listboard", listboard);
	            //model.addAttribute("articleUrl", articleUrl);
	            model.addAttribute("page", current_page);
	            model.addAttribute("dataCount", dataCount);
	            model.addAttribute("size", size);
	            model.addAttribute("total_page", total_page);
	            model.addAttribute("paging", paging);
	            model.addAttribute("schType", schType);
	            model.addAttribute("kwd", kwd);
	            model.addAttribute("tab", tab);
	                 
	         
		} catch (Exception e) {
			log.error("리스트 오류" ,e);
		}
		
		
		return "makerPage/projectManager";
	}
	   // 문의 작성 처리 (POST)
   
	
	
    @GetMapping("mwrite")
    public String makerWrite() {
        log.info("메이커 게시글 작성 페이지 요청");
        return "makerPage/mwrite";
    }
    
	
	
	@PostMapping("mwrite")
    public String makerWriteSubmit(ProjectManager dto, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
        // 세션에서 member 정보 가져오기
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            // 세션에 정보가 없으면 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        
        try {
            log.info("메이커 게시글 작성 처리 요청");
            
            // 세션에서 얻은 userId 설정
            dto.setMakerIdx(info.getMemberidx());
            
            // 삽입 처리
            service.insertBoard(dto,uploadPath);
            
            // 성공 메시지 추가
            redirectAttributes.addFlashAttribute("message", "게시글이 성공적으로 작성되었습니다.");
        } catch (Exception e) {
            log.error("메이커 게시글 작성 오류", e);
            // 오류 발생 시 작성 페이지로 리다이렉트
            return "redirect:/makerPage/projectManager";
        }
        
        // 문의 목록 페이지로 리다이렉트
        return "redirect:/makerPage/projectManager";
    }

	
	@GetMapping("delete")
	public String delete(@RequestParam(name = "mkboard_Num") long mkboard_Num,
			@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			HttpSession session)throws Exception {
	
		String query = "tab=2&page=" + page;
		try {
			service.deleteBoard(uploadPath, mkboard_Num);
			
		} catch (Exception e) {
			log.info("delete : ", e);
		}
		
		
		return "redirect:/makerPage/projectManager?" + query;
	}
	
	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, ?> deleteFile(@RequestParam(name = "fileNum") long fileNum, 
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String state = "false";
		
		try {
			ProjectManager dto = Objects.requireNonNull(service.findByFileId(fileNum));
			
			service.deleteUploadFile(uploadPath, dto.getSfileName());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "fileNum");
			map.put("mkboard_Num", fileNum);
			
			service.deleteFile(map);
			
			state = "true";
			
			
		} catch (NullPointerException e) {
			log.info("deleteFile : ", e);
		} catch (Exception e) {
			log.info("deleteFile : ", e);
		}
		model.put("state", state);
		return model;
	}
	@GetMapping("medit")
	public String updateForm(@RequestParam(name = "mkboard_Num") long mkboard_Num,
	        @RequestParam(name = "page", required = false, defaultValue = "1") String page,
	        Model model,
	        HttpSession session) {
	    String query = "tab=2&page=" + page;

	    try {
	        // 게시글 정보 조회
	        ProjectManager dto = service.findById(mkboard_Num);
	        
	        if (dto == null) {
	        	System.out.println("dto null 임");
	            return "redirect:/makerPage/projectManager?" + query;
	        }
	        
	       
	        
	        model.addAttribute("dto", dto);
	        model.addAttribute("mkboard_Num", mkboard_Num);
	        model.addAttribute("page", page);
	        model.addAttribute("mode", "update");

	        return "makerPage/medit"; 

	    } catch (NullPointerException e) {
	        log.info("updateForm : ", e);
	    } catch (Exception e) {
	        log.info("updateForm : ", e);
	    }

	    return "redirect:/makerPage/projectManager?" + query;
	}


	
	@PostMapping("medit")
	public String updateSubmit(ProjectManager dto,
	        @RequestParam(name = "page", required = false, defaultValue = "1") String page,
	        RedirectAttributes redirectAttributes) {
	    String query = "tab=2&page=" + page;

	    try {
	        // 게시글 업데이트 처리
	        service.updateBoard(dto, uploadPath); 
	        redirectAttributes.addFlashAttribute("message", "게시글이 성공적으로 수정되었습니다."); 
	    } catch (Exception e) {
	        log.info("updateSubmit : ", e);
	        redirectAttributes.addFlashAttribute("message", "게시글 수정 중 오류가 발생했습니다.");
	    }
	    	
	    return "redirect:/makerPage/projectManager?" + query; // 목록 페이지로 리다이렉트
	}
	
	
}
