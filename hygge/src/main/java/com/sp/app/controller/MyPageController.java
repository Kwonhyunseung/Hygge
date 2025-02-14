package com.sp.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.MyPage;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyPageService;
import com.sp.app.service.ReviewService; // ReviewService 추가

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/myPage/*")
public class MyPageController {

    @Autowired
    private final MyPageService myPageService;

    @Autowired
    private final ReviewService reviewService;  // ReviewService 주입

    @GetMapping("myPage")
    public String myPage(Model model, HttpSession session) {
        try {
        	SessionInfo info = (SessionInfo)session.getAttribute("member");
            log.info("마이페이지 요청");

            // 프로필 정보 조회
            MyPage myPage = myPageService.findById(info.getId());
            model.addAttribute("myPage", myPage);
            
            // 리뷰 카운트 조회
            int reviewCount = reviewService.reviewCount(info.getMemberidx());  // 리뷰 카운트 조회
            model.addAttribute("reviewCount", reviewCount);  // 리뷰 카운트를 모델에 추가
            
        } catch (Exception e) {
            log.error("마이페이지 오류", e);
        }
        return "myPage/myPage";
    }

    @GetMapping("profileEdit")
    public String profileEdit(HttpSession session, Model model) {
        try {
        	SessionInfo info = (SessionInfo)session.getAttribute("member");
            log.info("프로필 수정 페이지 요청");

            // 프로필 정보 조회
            MyPage myPage = myPageService.findById(info.getId());
            model.addAttribute("myPage", myPage);

        } catch (Exception e) {
            log.error("프로필 수정 페이지 오류", e);
        }
        return "myPage/profileEdit";
    }
    
    @PostMapping("profileEdit")
    public String updateProfile(MyPage myPage, HttpSession session, Model model, RedirectAttributes rttr) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            log.info("프로필 수정 요청: {}", myPage);

            myPage.setId(info.getId());

            myPageService.updateProfile(myPage);

            rttr.addFlashAttribute("msg", "프로필이 수정되었습니다.");
            return "redirect:/myPage/myPage";

        } catch (Exception e) {
            log.error("프로필 수정 오류", e);
            model.addAttribute("msg", "프로필 수정에 실패했습니다.");
            model.addAttribute("myPage", myPage);
            return "myPage/profileEdit"; 
        }
    }

    @GetMapping("buyHistory")
    public String buyHistory(Model model) {
        try {
            log.info("구매내역 페이지 요청");
        } catch (Exception e) {
            log.error("구매내역 페이지 오류", e);
        }
        return "myPage/buyHistory";
    }

    @GetMapping("couponList")
    public String couponList(Model model) {
        try {
            log.info("쿠폰 페이지 요청");
        } catch (Exception e) {
            log.error("쿠폰 페이지 오류", e);
        }
        return "myPage/couponList";
    }

    @GetMapping("review")
    public String review(Model model) {
        try {
            log.info("리뷰페이지 요청");
        } catch (Exception e) {
            log.error("리뷰 페이지 오류", e);
        }
        return "myPage/review";
    }

    @GetMapping("chat")
    public String chat(Model model) {
        try {
            log.info("채팅 요청");
        } catch (Exception e) {
            log.error("채팅 오류", e);
        }
        return "myPage/chat";
    }
}
