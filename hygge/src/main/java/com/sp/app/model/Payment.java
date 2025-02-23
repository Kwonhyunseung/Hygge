package com.sp.app.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Payment {
    private long payment_num; //결제번호
	private int total_amount; //총금액(상품*개수*가격 토탈)==모인금액
	private int pay_amount; //결제금액. 내가 최종적으로 구매하는 상품에 대한 금액+쿠폰+배송비 등의 적용금액
	private int pay_way; //결제수단. 0:카드결제
	private int sort; //결제종류. 0:프로젝트를 통한 결제, 1:중고장터를 통한 결제
	private int shipping_fee; //배송비
	private int coupon; //쿠폰. 기본: 0
	private Date payment_date; //결제일자. SYSDATE
	
	private long memberIdx;
	private int shipping_state; //int로 변경
	
	private String title; //기존에 있던 거
}
