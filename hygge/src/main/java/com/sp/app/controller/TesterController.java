package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;
import com.sp.app.service.MemberService;
import com.sp.app.service.TesterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/tester/*")
public class TesterController {
    private final TesterService service;
    private final MemberService memberService;

    @GetMapping("list")
    public String list(Model model) {
        try {
            // TODO: 체험단 리스트 가져오기
        } catch (Exception e) {
            log.info("list: ", e);
        }
        return "tester/list";
    }

    @GetMapping("testForm/{num}")
    public String testerForm(@PathVariable("num") long num, HttpSession session, Model model) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                return "redirect:/member/login";
            }

            TestBoard board = service.testerInfo(num);
            if (board == null) {
                return "redirect:/tester/list";
            }

            // 중복 신청 확인
            boolean isApplied = service.isAlreadyApplied(info.getMemberidx(), num);
            if (isApplied) {
                model.addAttribute("message", "이미 신청한 체험단입니다.");
                return "tester/message";
            }

            model.addAttribute("testBoard", board);
            model.addAttribute("member", info);

        } catch (Exception e) {
            log.error("testerForm error: ", e);
        }
        return "tester/testForm";
    }

    @PostMapping("testForm")
    public String testSubmit(Tester dto, HttpSession session, Model model) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                return "redirect:/member/login";
            }

            // 폼에서 memberIdx를 받지 못하는 경우를 대비해 세션에서 설정
            dto.setMemberIdx(info.getMemberidx());

            // 중복 신청 확인
            boolean isApplied = service.isAlreadyApplied(info.getMemberidx(), dto.getNum());
            if (isApplied) {
                model.addAttribute("message", "이미 신청한 체험단입니다.");
                return "tester/message";
            }

            // 체험단 신청 처리
            service.insertTesterForm(dto);
            
            log.info("체험단 신청 완료: 회원번호=" + dto.getMemberIdx() + ", 상품번호=" + dto.getNum());

        } catch (Exception e) {
            log.error("testSubmit error: ", e);
            model.addAttribute("message", "신청 중 오류가 발생했습니다.");
            return "tester/error";
        }

        return "redirect:/tester/complete";
    }

    @GetMapping("complete")
    public String complete(Model model) {
        try {
            // 완료 페이지 데이터 설정
            model.addAttribute("title", "체험단 신청 완료");
            model.addAttribute("message", "체험단 신청이 완료되었습니다.");
        } catch (Exception e) {
            log.info("complete: ", e);
        }
        return "tester/complete";
    }
}