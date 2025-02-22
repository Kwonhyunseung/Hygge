package com.sp.app.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Buy {
	
	// product (가격, 상품명, 상품상세, 수량, 원산지)
	// ProjectRequest-> Funding (delivery_info:배송 일정)
	// Sales (amount:구매개수, sum:구매금액)
	// member (이름, 이메일, 번호)
	// DeliveryList (번호, memberIdx, 주소1, 주소2, 우편번호, 받는사람, 기본배송지 여부, 요청사항)
		// 배송지 기본정보 ==> member (이름(=받는사람), 주소1, 주소2, 우편번호)
	// Coupon (쿠폰명, 할인율)
	private long num; //쿠폰 번호
	private long memberIdx;
    private String issue_date; //발급 날짜
    private double discount_rate; //할인율
    private double discount; //할인 최대 금액
    private String used_date; //사용 날짜
    
    private String coupon_name; // 쿠폰 이름
    private String exp_date; //만기일 - 추가
		 
	// Payment (pay_way:결제수단. 0:카드결제 , shipping_fee:배송비 , pay_amount:결제금액)
	private long payment_num; //결제번호
	private int total_amount; //총금액(상품*개수*가격 토탈)==모인금액
	private int pay_amount; //결제금액. 내가 최종적으로 구매하는 상품에 대한 금액+쿠폰+배송비 등의 적용금액
	private int pay_way; //결제수단. 0:카드결제
	private int sort; //결제종류. 0:프로젝트를 통한 결제, 1:중고장터를 통한 결제
	private int shipping_fee; //배송비
	private int coupon; //쿠폰. 기본: 0
	private String payment_date; //결제일자. SYSDATE
	
	/* private long memberIdx; */
	private int shipping_state;
	
	
	// shipping(배송)
	
	// receipt(카드기록)

}
