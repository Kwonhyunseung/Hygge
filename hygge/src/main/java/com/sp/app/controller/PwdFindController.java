package com.sp.app.controller;

import com.sp.app.model.Member;
import com.sp.app.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/member/*")
public class PwdFindController {

    private final MemberService memberService; // MemberService 주입

    @GetMapping("pwdFind")
    public String showPwdFindPage() {
        return "member/pwdFind";
    }

    @PostMapping("/password/find")
    public String findPassword(
            @RequestParam("userId") String userId,
            @RequestParam("userName") String userName,
            @RequestParam("userEmail") String userEmail,
            Model model) {

        log.info("비밀번호 찾기 요청 - ID: {}, 이름: {}, 이메일: {}", userId, userName, userEmail);

        // MemberService를 사용하여 DB에서 사용자 확인
        Member member = memberService.findByEmail(userEmail);
        
        if (member != null && member.getId().equals(userId) && member.getName().equals(userName)) {
            model.addAttribute("message", "비밀번호 재설정 링크가 이메일로 전송되었습니다.");
        } else {
            model.addAttribute("error", "입력한 정보가 올바르지 않습니다.");
        }
        
        return "member/pwdFindResult";
    }
}
