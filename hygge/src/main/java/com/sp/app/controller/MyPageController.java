package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MyPageController {

    @GetMapping("myPage")
    public String myPage(Model model) {
        try {
            log.info("마이페이지 요청");
        } catch (Exception e) {
            log.error("마이페이지 오류", e);
        }
        return "member/myPage";
    }

    @GetMapping("profileEdit")
    public String profileEdit(Model model) {
        try {
            log.info("프로필 수정 페이지 요청");
        } catch (Exception e) {
            log.error("프로필 수정 페이지 오류", e);
        }
        return "member/profileEdit";
    }
    
    @GetMapping("buyHistory")
    public String buyHistory(Model model) {
        try {
            log.info("구매내역 페이지 요청");
        } catch (Exception e) {
            log.error("구매내역 페이지 오류", e);
        }
        return "member/buyHistory";
    }
    
    @GetMapping("couponList")
    public String couponList(Model model) {
        try {
            log.info("쿠폰 페이지 요청");
        } catch (Exception e) {
            log.error("쿠폰 페이지 오류", e);
        }
        return "member/couponList";
    }
    
    @GetMapping("review")
    public String review(Model model) {
        try {
            log.info("리뷰페이지 요청");
        } catch (Exception e) {
            log.error("리뷰 페이지 오류", e);
        }
        return "member/review";
    }
    
    @GetMapping("chat")
    public String chat(Model model) {
        try {
            log.info("채팅 요청");
        } catch (Exception e) {
            log.error("채팅 오류", e);
        }
        return "member/chat";
    }
}
