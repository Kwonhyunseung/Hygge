package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.CouponManage;
import com.sp.app.admin.service.CouponManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/coupon/*")
public class CouponManageController {
    private final CouponManageService service;
    
    @PostMapping("insert")
    @ResponseBody
    public Map<String, Object> insertCoupon(@RequestBody CouponManage dto) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            log.info("쿠폰 등록 요청: {}", dto);
            
            // 쿠폰 등록 서비스 호출
            service.insertCoupon(dto);
            
            response.put("status", "success");
            response.put("message", "쿠폰이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            log.error("쿠폰 등록 중 오류 발생: ", e);
            response.put("status", "error");
            response.put("message", "쿠폰 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
}
