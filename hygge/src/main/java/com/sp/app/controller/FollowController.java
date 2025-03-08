package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Maker;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.FollowService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/follow/*")
public class FollowController {
	private final FollowService service;

	@GetMapping("/list")
    public String followingList(HttpSession session, Model model) {
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) {
            return "redirect:/member/login";
        }
        
        long memberIdx = info.getMemberidx();
        List<Maker> list = service.followingList(memberIdx);
        int followCount = service.followCount(memberIdx);
        
        model.addAttribute("list", list);
        model.addAttribute("followCount", followCount);
        
        return "follow/list";
    }
    
    @PostMapping("/unfollow")
    @ResponseBody
    public Map<String, Object> unfollow(@RequestParam("makerIdx") long makerIdx, HttpSession session) {
        Map<String, Object> model = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                model.put("state", "error");
                model.put("message", "로그인이 필요한 서비스입니다.");
                return model;
            }
            
            Map<String, Object> map = new HashMap<>();
            map.put("makerIdx", makerIdx);
            map.put("memberIdx", info.getMemberidx());
            
            service.unfollow(map);
            
            model.put("state", "success");
        } catch (Exception e) {
        }
        
        return model;
    }
}

