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

import com.sp.app.model.Coupon;
import com.sp.app.model.DeliveryList;
import com.sp.app.model.Member;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;
import com.sp.app.model.Sales;
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
			
			map.put("num", num);
			
	        List<Product> list = service.productList(map);
	        
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
	
	
	
	
	// 결제 화면에서 선택한 상품 정보 표시
	@GetMapping("productChoice")
	public String productChoiceForm(@PathVariable("num") long num, Model model, HttpSession session) {
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
	public String productChoiceSubmit(
	    @RequestParam("product_num") long product_num,
	    @RequestParam(value = "quantity", defaultValue = "1") int quantity,
	    Model model, HttpSession session) throws Exception {
	    try {
	        log.info("productChoice 호출: product_num={}, quantity={}", product_num, quantity);
	        
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
	            log.info("수량 설정: {}", quantity);
	            // 가격 계산
	            product.setSum(product.getPrice() * quantity);
	            
	            // 세션에 선택한 상품 정보 저장
	            Map<String, Object> selectedProduct = new HashMap<>();
	            selectedProduct.put("product_num", product_num);
	            selectedProduct.put("amount", quantity);
	            selectedProduct.put("sum", product.getPrice() * quantity);
	            selectedProduct.put("delivery_fee", product.getDelivery_fee());
	            selectedProduct.put("title", product.getTitle());
	            
	            session.setAttribute("selectedProduct", selectedProduct);
	            
	            // 쿠폰 리스트 조회
	            List<Coupon> coupons = service.listCoupon(info.getMemberidx());
	            log.info("쿠폰 리스트 개수: {}", (coupons != null) ? coupons.size() : 0);
	            
	            model.addAttribute("product", product);
	            model.addAttribute("member", member);
	            model.addAttribute("coupons", coupons);
	            
	            return "buy/productChoice";
	        } else {
	            return "redirect:/funding/list";  // 상품 목록 페이지로 리디렉션
	        }
	    } catch (Exception e) {
	        log.error("productChoice 오류: ", e);
	        return "redirect:/";
	    }
	}
	
	@PostMapping("processPayment")
	@ResponseBody
	public Map<String, Object> processPayment(
	        @RequestParam("product_num") long productNum,
	        @RequestParam("amount") int amount,
	        @RequestParam("sum") int sum,
	        @RequestParam(value = "couponNum", defaultValue = "0") long couponNum,
	        @RequestParam(value = "discountAmount", defaultValue = "0") int discountAmount,
	        @RequestParam("finalAmount") int finalAmount,
	        @RequestParam("deliveryFee") int deliveryFee,
	        @RequestParam(value = "receiver", required = false) String receiver,
	        @RequestParam(value = "addr1", required = false) String addr1,
	        @RequestParam(value = "addr2", required = false) String addr2,
	        @RequestParam(value = "postCode", required = false) String postCode,
	        @RequestParam(value = "request", required = false) String request,
	        @RequestParam(value = "pay_way", defaultValue = "1") int payWay,
	        HttpSession session) {
	    
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	        if(info == null) {
	            result.put("success", false);
	            result.put("message", "로그인이 필요합니다.");
	            return result;
	        }
	        
	        // 1. 결제 정보 등록
	        Payment payment = new Payment();
	        payment.setMemberIdx(info.getMemberidx());
	        payment.setTotal_amount(sum + deliveryFee); // 할인 전 총액
	        payment.setPay_amount(finalAmount); // 최종 결제 금액
	        payment.setPay_way(payWay); // 결제 방법
	        payment.setSort(1); // 종류 (1: 일반 결제)
	        payment.setShipping_fee(deliveryFee); // 배송비
	        payment.setCoupon(discountAmount); // 쿠폰 할인 금액
	        payment.setShipping_state(1); // 배송 상태 (1: 결제 완료)
	        
	        service.insertBuyPayment(payment);
	        log.info("생성된 payment_num: {}", payment.getPayment_num());
	        
	        // 2. 구매내역 등록
	        Sales sales = new Sales();
	        sales.setProduct_num(productNum);
	        sales.setAmount(amount);
	        sales.setSum(sum);
	        sales.setPayment_num(payment.getPayment_num());
	        
	        service.insertBuySales(sales);
	        
	        // 3. 배송지 정보가 변경된 경우 배송지 추가
	        if(addr1 != null && !addr1.isEmpty() && !addr1.equals("${member.addr1}")) {
	            DeliveryList delivery = new DeliveryList();
	            delivery.setMemberIdx(info.getMemberidx());
	            delivery.setAddr1(addr1);
	            delivery.setAddr2(addr2);
	            delivery.setPostCode(Integer.parseInt(postCode));
	            delivery.setReceiver(receiver);
	            delivery.setDefault_dest(1);
	            delivery.setRequest(request);
	            
	            service.insertBuyDelivery(delivery);
	        }
	        
	        // 4. 쿠폰을 사용한 경우 쿠폰 사용 처리
	        if(couponNum > 0) {
	            Coupon coupon = new Coupon();
	            coupon.setNum(couponNum);
	            coupon.setMemberIdx(info.getMemberidx());
	            
	            service.updateCoupon(coupon);
	        }
	        
	        // 5. 재고 감소 처리
	        Product product = new Product();
	        product.setProduct_num(productNum);
	        product.setAmount(amount);
	        
	        service.updateStock(product);
	        
	        // 결제 완료 정보를 세션에 저장
	        Product completeProduct = service.buyProductInfo(productNum);
	        completeProduct.setAmount(amount);
	        completeProduct.setSum(sum);

	        Member member = service.buyUserInfo(info.getMemberidx());

	        // 신규 배송지 정보를 포함하는 맵 생성
	        Map<String, Object> deliveryInfo = new HashMap<>();
	        deliveryInfo.put("receiver", receiver != null ? receiver : member.getName());
	        deliveryInfo.put("addr1", addr1 != null && !addr1.isEmpty() ? addr1 : member.getAddr1());
	        deliveryInfo.put("addr2", addr2 != null && !addr2.isEmpty() ? addr2 : member.getAddr2());
	        deliveryInfo.put("postCode", postCode != null && !postCode.isEmpty() ? postCode : member.getPostCode());

	        // 세션에 구매 완료 정보 저장
	        session.setAttribute("completeProduct", completeProduct);
	        session.setAttribute("completeMember", member);
	        session.setAttribute("paymentInfo", payment);
	        session.setAttribute("deliveryInfo", deliveryInfo); // 배송 정보 추가
	        
	        // 세션에서 선택한 상품 정보 제거
	        session.removeAttribute("selectedProduct");
	        
	        // 성공 응답
	        result.put("success", true);
	        result.put("redirectUrl", "/buy/complete");
	        
	    } catch (Exception e) {
	        log.error("결제 처리 중 오류: ", e);
	        result.put("success", false);
	        result.put("message", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
	    }
	    
	    return result;
	}
	
	@GetMapping("complete")
	public String complete(Model model, HttpSession session) {
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    if(info == null) {
	        return "redirect:/member/login";
	    }

	    // 세션에서 완료 정보 가져오기
	    Product product = (Product) session.getAttribute("completeProduct");
	    Member member = (Member) session.getAttribute("completeMember");
	    Payment payment = (Payment) session.getAttribute("paymentInfo");
	    Map<String, Object> deliveryInfo = (Map<String, Object>) session.getAttribute("deliveryInfo");
	    
	    if (product == null || member == null || payment == null || deliveryInfo == null) {
	        return "redirect:/";
	    }
	    
	    // 모델에 정보 추가
	    model.addAttribute("product", product);
	    model.addAttribute("member", member);
	    model.addAttribute("payment", payment);
	    model.addAttribute("deliveryInfo", deliveryInfo); // 배송 정보 추가
	    
	    // 세션에서 완료 정보 제거 (페이지 새로고침 방지)
	    session.removeAttribute("completeProduct");
	    session.removeAttribute("completeMember");
	    session.removeAttribute("paymentInfo");
	    session.removeAttribute("deliveryInfo");
	    
	    return "buy/complete";
	}

}