package com.sp.app.admin.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.PaymentManage;
import com.sp.app.admin.service.PaymentManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/payment/*")
@RequiredArgsConstructor
public class PaymentManageController {
    
    private final PaymentManageService service;
    private final PaginateUtil paginateUtil;
    
    @GetMapping("list")
    public String purchaseList(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "sort", defaultValue = "") String sort,
            HttpServletRequest req,
            Model model) throws Exception {
        
        try {
            int size = 10;
            int total_page;
            int dataCount;
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            // 정렬 조건이 있으면 추가
            if (sort.length() != 0) {
                map.put("sort", sort);
            }
            
            dataCount = service.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            
            if (total_page < current_page) {
                current_page = total_page;
            }
            
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<PaymentManage> list = service.listPurchase(map);
            
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/admin/payment/list";
            
            if (kwd.length() != 0) {
                query = "schType=" + schType + 
                       "&kwd=" + URLEncoder.encode(kwd, "utf-8");
            }
            
            if (sort.length() != 0) {
                if (query.length() != 0) {
                    query += "&";
                }
                query += "sort=" + sort;
            }
            
            if (query.length() != 0) {
                listUrl += "?" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            
            model.addAttribute("list", list);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            model.addAttribute("sort", sort);
            
        } catch (Exception e) {
            log.error("구매 내역 목록 조회 에러", e);
            throw e;
        }
        
        return "admin/payment/list";
    }
    
    @GetMapping("listByType")
    @ResponseBody
    public Map<String, Object> listByType(
            @RequestParam(name = "type") String type,
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            HttpServletRequest req) {
        
        Map<String, Object> model = new HashMap<>();
        
        try {
            int size = 10; // 페이지당 표시할 항목 수
            
            Map<String, Object> map = new HashMap<>();
            if(type.equals("project")) {
                map.put("sort", "0");
            } else if(type.equals("used")) {
                map.put("sort", "1");
            }
            
            // 데이터 총 개수 가져오기
            int dataCount = service.dataCount(map);
            int total_page = paginateUtil.pageCount(dataCount, size);
            
            if (total_page < current_page) {
                current_page = total_page;
            }
            
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            String cp = req.getContextPath(); // 컨텍스트 경로 가져오기
            String listUrl = cp + "/admin/payment/listByType?type=" + type;
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            
            List<PaymentManage> list = service.listPurchase(map);
            
            model.put("state", "success");
            model.put("list", list);
            model.put("dataCount", dataCount);
            model.put("page", current_page);
            model.put("total_page", total_page);
            model.put("paging", paging);
        } catch (Exception e) {
            model.put("state", "error");
            model.put("message", e.getMessage());
        }
        
        return model;
    }
    
    @GetMapping("detail/{payment_num}")
    public String purchaseDetail(
            @PathVariable long payment_num,
            @RequestParam(name = "page", defaultValue = "1") String page,
            Model model) throws Exception {
        
        try {
            // 결제 상세 정보
        	PaymentManage dto = service.findByPayment(payment_num);
            if(dto == null) {
                return "redirect:/admin/payment/list?page=" + page;
            }
            
            // 결제 관련 판매 상품 목록
            List<PaymentManage> productList = service.listSalesByPayment(payment_num);
            
            model.addAttribute("dto", dto);
            model.addAttribute("productList", productList);
            model.addAttribute("page", page);
        } catch (Exception e) {
            log.error("구매 내역 상세 조회 에러", e);
            return "redirect:/admin/payment/list?page=" + page;
        }
        
        return "admin/payment/detail";
    }
    
}