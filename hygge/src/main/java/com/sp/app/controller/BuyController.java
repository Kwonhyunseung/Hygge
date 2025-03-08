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
	
	// 상품 리스트
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
            log.info("상품 리스트 조회 오류: ", e);
        }
        
        return "buy/productList";
    }
	
	// 결제창
    @GetMapping("productChoice")
    public String productChoiceForm(@PathVariable("num") long num, Model model, HttpSession session) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                return "redirect:/member/login";
            }
            
            // 세션에서 선택한 상품 정보 가져오기
            Map<String, Object> selectedProduct = getSelectedProductFromSession(session);
            
            // 상품 상세 정보 조회 및 설정
            Product product = setupProductFromSelectedProduct(selectedProduct, info);
            
            // 모델에 필요한 데이터 추가
            addProductChoiceDataToModel(model, product, info);
            
            return "buy/productChoice";
            
        } catch (Exception e) {
            log.error("productChoice GET 오류: ", e);
            return "error";
        }
    }
    
    // 결제창
    @PostMapping("productChoice")
    public String productChoiceSubmit(
            @RequestParam("product_num") long product_num,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            Model model, HttpSession session) throws Exception {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if(info == null) {
                return "redirect:/member/login";
            }
            
            Product product = service.buyProductInfo(product_num);
            Member member = service.buyUserInfo(info.getMemberidx());
            
            if (product != null && member != null) {
                // 수량 및 가격 설정
                product.setAmount(quantity);
                product.setSum(product.getPrice() * quantity);
                
                // 세션에 선택한 상품 정보 저장
                saveProductToSession(session, product_num, quantity, product);
                
                // 쿠폰 리스트 조회
                List<Coupon> coupons = service.listCoupon(info.getMemberidx());
                
                model.addAttribute("product", product);
                model.addAttribute("member", member);
                model.addAttribute("coupons", coupons);
                
                return "buy/productChoice";
                
            } else {
            	return "redirect:/funding/product/" + product.getNum();
            }
        } catch (Exception e) {
            log.error("productChoice POST 오류: ", e);
            return "redirect:/";
        }
    }
    
    // 결제 - AJAX 요청 처리
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
            
            // 결제정보 처리
            Payment payment = processPaymentInfo(info, sum, finalAmount, payWay, deliveryFee, discountAmount);
            
            // 구매내역 등록
            processSalesInfo(productNum, amount, sum, payment.getPayment_num());
            
            // 배송지 처리
            processDeliveryInfo(info, addr1, addr2, postCode, receiver, request);
            
            // 쿠폰사용 처리
            if(couponNum > 0) {
                processCouponUsage(couponNum, info.getMemberidx());
            }
            
            // 재고수량 처리
            updateProductStock(productNum, amount);
            
            // 결제 완료 정보 세션에 저장
            saveCompletionInfoToSession(session, info, productNum, amount, sum, payment, receiver, addr1, addr2, postCode);
            
            result.put("success", true);
            result.put("redirectUrl", "/buy/complete");
            
        } catch (Exception e) {
            log.error("결제 처리 오류: ", e);
            result.put("success", false);
            result.put("message", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    // 결제 완료
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
        
        model.addAttribute("product", product);
        model.addAttribute("member", member);
        model.addAttribute("payment", payment);
        model.addAttribute("deliveryInfo", deliveryInfo);
        
        // 세션에서 완료 정보 제거 (페이지 새로고침 방지)
        clearCompletionSessionData(session);
        
        return "buy/complete";
    }
    
    
    // 세션에서 선택한 상품정보 가져오기
    private Map<String, Object> getSelectedProductFromSession(HttpSession session) {
        return (Map<String, Object>) session.getAttribute("selectedProduct");
    }
    
    // 선택한 상품 정보 설정
    private Product setupProductFromSelectedProduct(Map<String, Object> selectedProduct, SessionInfo info) throws Exception {
        long product_num = (long) selectedProduct.get("product_num");
        Product product = service.findByProductNum(product_num);
        
        if (product != null) {
            // 세션의 수량 및 합계 정보 설정
            product.setAmount((int) selectedProduct.get("amount"));
            product.setSum((int) selectedProduct.get("sum"));
        }
        
        return product;
    }
    
    // 모델에 결제화면 정보 추가
    private void addProductChoiceDataToModel(Model model, Product product, SessionInfo info) throws Exception {
        // 사용자 정보 조회
        Member user = service.buyUserInfo(info.getMemberidx());
        
        // 쿠폰 리스트 조회
        List<Coupon> coupons = service.listCoupon(info.getMemberidx());
        
        model.addAttribute("product", product);
        model.addAttribute("member", user);
        model.addAttribute("coupons", coupons);
    }
    
    // 세션에 선택한 상품정보 저장
    private void saveProductToSession(HttpSession session, long product_num, int quantity, Product product) {
        Map<String, Object> selectedProduct = new HashMap<>();
        selectedProduct.put("product_num", product_num);
        selectedProduct.put("amount", quantity);
        selectedProduct.put("sum", product.getPrice() * quantity);
        selectedProduct.put("delivery_fee", product.getDelivery_fee());
        selectedProduct.put("title", product.getTitle());
        
        session.setAttribute("selectedProduct", selectedProduct);
    }
    
    // 결제 정보 처리
    private Payment processPaymentInfo(SessionInfo info, int sum, int finalAmount, int payWay, int deliveryFee, int discountAmount) throws Exception {
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
        return payment;
    }
    
    // 판매 정보 처리
    private void processSalesInfo(long productNum, int amount, int sum, long paymentNum) throws Exception {
        Sales sales = new Sales();
        sales.setProduct_num(productNum);
        sales.setAmount(amount);
        sales.setSum(sum);
        sales.setPayment_num(paymentNum);
        
        service.insertBuySales(sales);
    }
    
    // 배송지 정보 처리
    private void processDeliveryInfo(SessionInfo info, String addr1, String addr2, String postCode, String receiver, String request) throws Exception {
        // 배송지 정보가 변경된 경우에만 처리
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
    }
    
    // 쿠폰 사용
    private void processCouponUsage(long couponNum, long memberIdx) throws Exception {
        Coupon coupon = new Coupon();
        coupon.setNum(couponNum);
        coupon.setMemberIdx(memberIdx);
        
        service.updateCoupon(coupon);
    }
    
    // 상품 수량 감소
    private void updateProductStock(long productNum, int amount) throws Exception {
        Product product = new Product();
        product.setProduct_num(productNum);
        product.setAmount(amount);
        
        service.updateStock(product);
    }
    
    // 결제완료 정보 세션에 저장
    private void saveCompletionInfoToSession(HttpSession session, SessionInfo info, long productNum, int amount, int sum, 
                                            Payment payment, String receiver, String addr1, String addr2, String postCode) throws Exception {

    	Product completeProduct = service.buyProductInfo(productNum);
        completeProduct.setAmount(amount);
        completeProduct.setSum(sum);

        Member member = service.buyUserInfo(info.getMemberidx());

        Map<String, Object> deliveryInfo = createDeliveryInfoMap(receiver, addr1, addr2, postCode, member);

        session.setAttribute("completeProduct", completeProduct);
        session.setAttribute("completeMember", member);
        session.setAttribute("paymentInfo", payment);
        session.setAttribute("deliveryInfo", deliveryInfo);
        
        session.removeAttribute("selectedProduct");
    }
    
    // 배송지 정보 맵 생성
    private Map<String, Object> createDeliveryInfoMap(String receiver, String addr1, String addr2, String postCode, Member member) {
        Map<String, Object> deliveryInfo = new HashMap<>();
        deliveryInfo.put("receiver", receiver != null ? receiver : member.getName());
        deliveryInfo.put("addr1", addr1 != null && !addr1.isEmpty() ? addr1 : member.getAddr1());
        deliveryInfo.put("addr2", addr2 != null && !addr2.isEmpty() ? addr2 : member.getAddr2());
        deliveryInfo.put("postCode", postCode != null && !postCode.isEmpty() ? postCode : member.getPostCode());
        return deliveryInfo;
    }
    
    // 세션에서 완료된 정보 제거
    private void clearCompletionSessionData(HttpSession session) {
        session.removeAttribute("completeProduct");
        session.removeAttribute("completeMember");
        session.removeAttribute("paymentInfo");
        session.removeAttribute("deliveryInfo");
    }
}