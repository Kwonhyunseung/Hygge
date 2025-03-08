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

import com.sp.app.model.Funding;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.WishService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/wish/*")
public class WishController {
    private final WishService service;
    
    @GetMapping("/list")
    public String wishList(HttpSession session, Model model) {
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) {
            return "redirect:/member/login";
        }
        
        long memberIdx = info.getMemberidx();
        List<Funding> list = service.wishProjects(memberIdx);
        
        model.addAttribute("list", list);
        
        return "wish/list";
    }
    
    @PostMapping("/remove")
    @ResponseBody
    public Map<String, Object> removeWish(@RequestParam("num") long num, HttpSession session) {
        Map<String, Object> model = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                model.put("message", "로그인이 필요한 서비스입니다.");
                return model;
            }
            
            Map<String, Object> map = new HashMap<>();
            map.put("num", num);
            map.put("memberIdx", info.getMemberidx());
            
            service.removewish(map);
            
            model.put("state", "success");
        } catch (Exception e) {
        }
        
        return model;
    }
    
}