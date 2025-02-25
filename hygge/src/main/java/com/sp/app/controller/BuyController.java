package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.model.Coupon;
import com.sp.app.model.Member;
import com.sp.app.model.Product;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.BuyService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/buy/*")
public class BuyController {
	private final BuyService service;
	
	// 결제창 - 상품 리스트
	@GetMapping("productList/{num}")
	public String productList(@PathVariable("num") long num, Model model, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info != null) {
				map.put("memberIdx", info.getMemberidx());
			}
			
			map.put("num", num);  // 프로젝트 번호 추가
			
			// 상품 리스트 조회
	        List<Product> list = service.productList(map);
	        
	        // null 체크 후 모델에 추가
	        if (list != null && !list.isEmpty()) {
	            model.addAttribute("list", list);
	        } else {
	            model.addAttribute("message", "상품 목록을 불러올 수 없습니다.");
	        }
	        
		} catch (Exception e) {
			log.info("productList: ", e);
		}
		
		return "buy/productList";
	}
	
	/*
	@GetMapping("product/{product_num}")
	@ResponseBody
	public Product getProduct(@PathVariable("product_num") long product_num, Model model) {
	    return service.findByProductNum(product_num);
	}
	*/
	// 상품 리스트에서 상품 선택 시
	/*
	@PostMapping("selectProduct")
	public String selectProduct(
	        @RequestParam long product_num,
	        @RequestParam int amount,
	        HttpSession session) {
	    
	    try {
	        // 세션에서 회원 정보 가져오기
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if (info == null) {
	            return "redirect:/member/login";
	        }
	        
	        // 상품 정보 조회
	        Product product = service.findByProductNum(product_num);
	        
	        // 선택한 상품 정보를 세션에 저장
	        Map<String, Object> selectedProduct = new HashMap<>();
	        selectedProduct.put("product_num", product_num);
	        selectedProduct.put("amount", amount);
	        selectedProduct.put("price", product.getPrice());
	        selectedProduct.put("sum", product.getPrice() * amount);
	        selectedProduct.put("title", product.getTitle());
	        selectedProduct.put("delivery_fee", product.getDelivery_fee());
	        
	        session.setAttribute("selectedProduct", selectedProduct);
	        
	        return "redirect:/buy/productChoice";
	    } catch (Exception e) {
	        log.error("selectProduct 오류: ", e);
	        return "error";
	    }
	}
	*/
	
	
	
	// 결제 화면에서 선택한 상품 정보 표시
	@GetMapping("productChoice")
	public String productChoiceForm(Model model, HttpSession session) {
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if (info == null) {
	            return "redirect:/member/login";
	        }
	        
	        // 세션에서 선택한 상품 정보 가져오기
	        Map<String, Object> selectedProduct = (Map<String, Object>) session.getAttribute("selectedProduct");
	        if (selectedProduct == null) {
	            return "redirect:/funding/list"; // 상품 선택 페이지로 리디렉션
	        }
	        
	        // 상품 번호로 상세 정보 조회
	        long product_num = (long) selectedProduct.get("product_num");
	        Product product = service.findByProductNum(product_num);
	        
	        // 세션의 수량 및 합계 정보 설정
	        product.setAmount((int) selectedProduct.get("amount"));
	        product.setSum((int) selectedProduct.get("sum"));
	        
	        // 사용자 정보 조회
	        Member user = service.buyUserInfo(info.getMemberidx());
	        
	        // 쿠폰 리스트 조회
	        List<Coupon> coupons = service.listCoupon(info.getMemberidx());
	        
	        model.addAttribute("product", product);
	        model.addAttribute("user", user);
	        model.addAttribute("coupons", coupons);
	        
	        return "buy/productChoice";
	    } catch (Exception e) {
	        return "error";
	    }
	}
	
	@PostMapping("productChoice")
	public String productChoice(
	        @RequestParam("product_num") long product_num,
	        @RequestParam(value = "quantity", defaultValue = "1") int quantity,
	        @RequestParam(value = "debug_field", required = false) String debugField,
	        Model model, HttpSession session) throws Exception {
	    try {
	        // 디버깅 정보 로깅
	        log.info("productChoice 호출: product_num={}, quantity={}, debug_field={}", 
	                product_num, quantity, debugField);
	        
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if(info == null) {
	            return "redirect:/member/login";
	        }
	        
	        // 상품 정보 가져오기
	        Product product = service.buyProductInfo(product_num);
	        log.info("상품 정보 조회 결과: {}", product != null ? "성공" : "실패");
	        
	        // 로그인한 유저 정보 가져오기
	        Member member = service.buyUserInfo(info.getMemberidx());
	        
	        if (product != null && member != null) {
	            // 수량 설정
	            product.setAmount(quantity);
	            log.info("수량 설정: {}", quantity);
	            
	            // 가격 계산 (상품 가격 * 수량)
	            product.setSum(product.getPrice() * quantity);
	            
	            // 세션에 저장 (백업 방법)
	            Map<String, Object> selectedProduct = new HashMap<>();
	            selectedProduct.put("product_num", product_num);
	            selectedProduct.put("amount", quantity);
	            selectedProduct.put("price", product.getPrice());
	            selectedProduct.put("sum", product.getPrice() * quantity);
	            selectedProduct.put("title", product.getTitle());
	            selectedProduct.put("delivery_fee", product.getDelivery_fee());
	            
	            session.setAttribute("selectedProduct", selectedProduct);
	            
	            // 모델에 추가
	            model.addAttribute("product", product);
	            model.addAttribute("member", member);
	            
	            return "buy/productChoice";
	        } else {
	            model.addAttribute("message", "상품 정보를 불러올 수 없습니다.");
	            return "redirect:/";
	        }
	    } catch (Exception e) {
	        log.error("productChoice 오류: ", e);
	        model.addAttribute("message", "처리 중 오류가 발생했습니다.");
	        return "redirect:/";
	    }
	}
	

	// 결제창 - 완료 // 기존 complete 메서드는 GetMapping으로 변경하여 결제 완료 화면만 표시
	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) {
		// F5를 누른 경우
		if (message == null || message.isBlank()) { 
			return "redirect:/";
		}
		return "buy/complete";
	}

}