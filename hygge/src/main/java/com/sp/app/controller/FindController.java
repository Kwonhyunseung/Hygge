package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/member/*")
public class FindController {

    // 아이디 찾기 페이지로 이동
    @GetMapping("findResult")
    public String findResultPage() {
        return "member/findResult";  // 결과 페이지로 이동
    }

    // 아이디 찾기 POST 요청 처리
    @PostMapping("findResult")
    public String findId(@RequestParam("userName") String userName,
                         @RequestParam("userEmail") String userEmail,
                         RedirectAttributes redirectAttributes) {

        log.info("아이디 찾기 요청 - 이름: {}, 이메일: {}", userName, userEmail);

        // 아이디 찾기 로직 (예시)
        String userId = "exampleUserId";  // 실제 아이디 찾기 로직으로 교체
        String tempPassword = "tempPassword123";  // 임시 비밀번호 생성 로직

        // 리다이렉트 시 데이터를 전달하는 방법
        redirectAttributes.addFlashAttribute("userId", userId);
        redirectAttributes.addFlashAttribute("tempPassword", tempPassword);

        return "redirect:/member/findResult";  // 결과 페이지로 리다이렉트
    }
}
