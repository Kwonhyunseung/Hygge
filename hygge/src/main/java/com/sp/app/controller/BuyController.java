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
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@GetMapping("product/{product_num}")
	@ResponseBody
	public Product getProduct(@PathVariable("product_num") long product_num, Model model) {
	    return service.findByProductNum(product_num);
	}
	
	
	
	// 결제창 - 상품 선택
	@GetMapping("productChoice")
	public String productSelect(Model model) {
		return "buy/productChoice";
	}
	
	@PostMapping("/productChoice")
	public String productChoice(
	        @RequestParam("product_num") long product_num,
	        @RequestParam(value = "quantity", defaultValue = "1") int quantity,
	        Model model, HttpSession session) throws Exception {
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if(info == null) {
	            return "redirect:/member/login";
	        }
	        
	        // 상품 정보 가져오기
	        Product product = service.buyProductInfo(product_num);
	        // 로그인한 유저 정보 가져오기
	        Member member = service.buyUserInfo(info.getMemberidx());
	        
	        if (product != null && member != null) {
	            // 수량 설정
	            product.setAmount(quantity);
	            
	            // 가격 계산 (상품 가격 * 수량)
	            product.setSum(product.getPrice() * quantity);
	            
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
	
	
	
	// 결제창 - 완료
	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) {
		// F5를 누른 경우
		if (message == null || message.isBlank()) { 
			return "redirect:/";
		}
		return "buy/complete";
	}

}