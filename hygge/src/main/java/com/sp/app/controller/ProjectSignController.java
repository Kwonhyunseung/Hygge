package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/project/*")
@RequiredArgsConstructor
@Slf4j
public class ProjectSignController {

    @GetMapping("projectSign")
    public String showProjectSign(Model model) {
        try {
            log.info("프로젝트 신청 페이지 접속");
        } catch (Exception e) {
            log.error("프로젝트 신청 페이지 로딩 중 오류 발생", e);
        }
        return "project/projectSign";
    }

    @GetMapping("makerStudio")
    public String showMakerStudio(Model model) {
        try {
            log.info("메이커 스튜디오 페이지 접속");
        } catch (Exception e) {
            log.error("메이커 스튜디오 페이지 로딩 중 오류 발생", e);
        }
        return "project/makerStudio";
    }
    
    @GetMapping("makerStudio2")
    public String showMakerStudio2(Model model) {
        try {
            log.info("메이커 스튜디오 페이지2 접속");
        } catch (Exception e) {
            log.error("메이커 스튜디오 페이지2 로딩 중 오류 발생", e);
        }
        return "project/makerStudio2";
    }
    
    @GetMapping("projectManager")
    public String showprojectManager(Model model) {
        try {
            log.info("메이커 스튜디오 페이지2 접속");
        } catch (Exception e) {
            log.error("메이커 스튜디오 페이지2 로딩 중 오류 발생", e);
        }
        return "project/projectManager";
    }
}
