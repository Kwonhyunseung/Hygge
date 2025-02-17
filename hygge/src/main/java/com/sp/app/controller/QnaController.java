package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Qna;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/qna/*")
public class QnaController {

    private final QnaService service;
    private final PaginateUtil paginateUtil;
     
    // 문의 목록 페이지 (GET)
    @GetMapping("list")
    public String qnaList(Model model,
                          @RequestParam(name = "page", defaultValue = "1") int current_page,
                          @RequestParam(name = "schType", defaultValue = "all") String schType,
                          @RequestParam(name = "kwd", defaultValue = "") String kwd,
                          HttpSession session,
                          HttpServletRequest req) throws Exception {
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
        try {
            log.info("1대1 문의 리스트 요청");

            int size = 10;
            int total_page;
            int dataCount;
            
            // URL 디코딩 처리 (검색어)
            kwd = URLDecoder.decode(kwd, "UTF-8");

            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("memberIdx", info.getMemberidx());
            
            
            // 데이터 개수 및 페이지 계산
            dataCount = service.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);

            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;
            
            
            map.put("offset", offset);
            map.put("size", size);


            // DB에서 문의 목록 조회
            List<Qna> qnaList = service.listQna(map);
            
            // URL 구성
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/qna/list";
            String articleUrl = cp + "/qna/article?page=" + current_page;
            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
                listUrl = cp + "/qna/list?" + query;
                articleUrl = cp + "/qna/article?page=" + current_page + "&" + query;
            }

            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            System.out.println(dataCount+", "+current_page+", "+size);
            // 모델에 데이터 담기 (목록은 qnaList, 상세 링크는 articleUrl 등)
            model.addAttribute("qnaList", qnaList);
            model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);

        } catch (Exception e) {
            log.error("1대1 문의 리스트 조회 오류", e);
            model.addAttribute("error", "1대1 문의 리스트 조회 오류");
        }
        return "qna/list";
    }

    // 문의 상세 페이지 (GET)
    @GetMapping("article")
    public String qnaArticle(Model model, @RequestParam("num") long num) {
        try {
            log.info("1대1 문의 상세 요청");
            Qna qna = service.findById(num);
            if (qna != null) {
                model.addAttribute("qna", qna);
            } else {
                model.addAttribute("error", "해당 문의 글을 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            log.error("1대1 문의 상세 조회 오류", e);
            model.addAttribute("error", "1대1 문의 상세 조회 오류");
        }
        return "qna/article";
    }

    // 문의 작성 페이지 (GET)
    @GetMapping("write")
    public String qnaWrite() {
        log.info("1대1 문의 작성 페이지 요청");
        return "qna/write";
    }
    
    
    // 문의 작성 처리 (POST)
    @PostMapping("write")
    public String qnaWriteSubmit(Qna qna, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
        // 세션에서 member 정보 가져오기
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            // 세션에 정보가 없으면 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        
        try {
            log.info("1대1 문의 작성 처리 요청");
            
            // 세션에서 얻은 userId 설정
            qna.setMemberIdx(info.getMemberidx());
            
            // Qna 삽입 처리
            service.insertQna(qna);
            
            // 성공 메시지 추가
            redirectAttributes.addFlashAttribute("message", "문의가 성공적으로 작성되었습니다.");
        } catch (Exception e) {
            log.error("1대1 문의 작성 오류", e);
            // 오류 발생 시 작성 페이지로 리다이렉트
            return "redirect:/qna/write";
        }
        
        // 문의 목록 페이지로 리다이렉트
        return "redirect:/qna/list";
    }

    // 문의 수정 처리 (POST) - 상세 페이지 내 수정 폼을 통해 처리
    @PostMapping("update")
    public String qnaUpdate(Qna qna) {
        try {
            log.info("1대1 문의 수정 요청");
            service.updateQna(qna);
        } catch (Exception e) {
            log.error("1대1 문의 수정 오류", e);
            return "redirect:/qna/article?num=" + qna.getNum();
        }
        return "redirect:/qna/article?num=" + qna.getNum();
    }

    // 문의 삭제 처리 (POST)
    @PostMapping("delete")
    public String qnaDelete(@RequestParam("num") long num) {
        try {
            log.info("1대1 문의 삭제 요청");
            service.deleteQna(num);
        } catch (Exception e) {
            log.error("1대1 문의 삭제 오류", e);
            return "redirect:/qna/list";
        }
        return "redirect:/qna/list";
    }
}
