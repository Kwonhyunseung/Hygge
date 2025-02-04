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
@RequestMapping("/member/*")
public class IdFindController {

    @GetMapping("idFind")
    public String showIdFindPage() {
        return "member/idFind";  // 아이디 찾기 페이지로 이동
    }

    @GetMapping("/id/findResult")
    public String showFindResultPage(Model model) {
        // 아이디와 임시 비밀번호를 직접 설정
        String userId = "exampleUserId";  // 실제 아이디 찾기 로직으로 교체
        String tempPassword = "tempPassword123";  // 임시 비밀번호 생성 로직

        // 모델에 아이디와 임시 비밀번호 추가
        model.addAttribute("userId", userId);
        model.addAttribute("tempPassword", tempPassword);

        return "member/findResult";  // 아이디/비밀번호 찾기 결과 페이지로 이동
    }
}
