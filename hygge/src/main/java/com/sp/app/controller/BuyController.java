package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@GetMapping("/productList/{num}")
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
	
	// 결제창 - 상품 선택
	
	@GetMapping("/product/{product_num}")
	@ResponseBody
	public Product getProduct(@PathVariable("product_num") long product_num, Model model) {
	    return service.findByProductNum(product_num);
	}
	
	// 결제창 - 상품 선택
	@PostMapping("/productChoice")
	public String productChoice(@RequestParam("product_num") long product_num, Model model) {
	    try {
	        Product product = service.findByProductNum(product_num);
	        if (product != null) {
	            model.addAttribute("product", product);
	            return "buy/productChoice";
	        } else {
	            model.addAttribute("message", "선택한 상품 정보를 찾을 수 없습니다.");
	            return "redirect:/buy/productList/{num}"; // 프로젝트 번호를 포함하여 리다이렉트
	        }
	    } catch (Exception e) {
	        log.error("Failed to retrieve product information for payment", e);
	        model.addAttribute("message", "상품 정보 조회 중 오류가 발생했습니다.");
	        return "redirect:/buy/productList/{num}"; // 프로젝트 번호를 포함하여 리다이렉트
	    }
	}
	
	
	
	
	
// 테스트용 ->실전은 위에껄로
@GetMapping("productChoice")
public String productSelect(Model model) {
	return "buy/productChoice";
}

	// 결제창 - 완료
	/*
	@GetMapping("/complete/{num}")
	public String complete(@PathVariable("num") long num, Model model) {

		return "buy/complete";
	}
	*/
// 테스트용 ->실전은 위에껄로
@GetMapping("complete")
public String complete(Model model) {
	return "buy/complete";
}

}