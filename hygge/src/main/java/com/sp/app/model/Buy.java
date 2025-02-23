package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Buy {
	
	// product (가격, 상품명, 상품상세, 수량, 원산지)
	/*
	  ==>product.java 사용하기
	private long product_num; //상품번호
	private int price;
	private int stock; //상품수량
	private String title;
	private String detail; //상품상세정보
	private String origin; //원산지
	*/
	
	private int num; //신청번호, 구매번호
	
	// ProjectRequest-> Funding (delivery_info:배송 일정)
	private String thumbnail;
	private String delivery_info;
	
	// Sales (amount:구매개수, sum:구매금액)
	private int amount; //구매개수
	private int sum; //구매금액(가격*개수 합)
	
	// member (이름, 이메일, 번호 // 주소1,2,우편번호)
	// member1
	private long memberIdx;
	// member2
	private String email1;
	private String email2;
	private String addr1;
	private String addr2;
	private int postCode;
	private int tel1;
	private int tel2;
	private int tel3;
	
	// DeliveryList (번호, memberIdx, 주소1, 주소2, 우편번호, 받는사람, 기본배송지 여부, 요청사항) 
	//-->새로운 정보 받을경우 (receiver(=받는사람), 주소1, 주소2, 우편번호) + 요청사항 
	// 배송지 기본정보 ==> member(이름(=받는사람), 주소1, 주소2, 우편번호) + 요청사항
	private long dest_num;
	private String receiver; //받는사람. null 허용
	private int default_dest;//기본배송지 여부. 기본배송지(0), 나머지(1)
	private String request; //배송요청사항
	
	// Coupon (쿠폰명, 할인율, 할인 최대 금액)
	//==> 이벤트 테이블의 이벤트제목(title)이 쿠폰명임.
	//==> 쿠폰 만기일 (이벤트 테이블. exp_date)
	//==> 할인율 (쿠폰 테이블. discount_rate)
	//==> 할인최대금액 (쿠폰 테이블. discount)
		//==> 멤버번호 / 발급날짜 / 사용날짜
	
	// Event + Coupon
	private String title; //이벤트 제목
	private Date exp_date; //쿠폰 만기일
	private Date issue_date; //발급날짜. 쿠폰 발급받은 순간의 시간!!
	private int discount_rate; //할인율
	private int discount; //할인최대금액
	private Date used_date; //사용날짜. null허용
	
	
	// Payment (pay_way:결제수단. 0:카드결제 , sort:프로젝트를 통한 결제. 디폴트값:0
	//	shipping_fee:배송비 , coupon:쿠폰금액, payment_date:결제일자, pay_amount:결제금액, )
	private long payment_num; //결제번호
	private int pay_amount; //결제금액
	private int pay_way; //결제수단. 0:카드결제
	private int sort; //결제종류. 0:프로젝트를 통한 결제
	private int shipping_fee; //배송비
	private int coupon; //쿠폰금액. 0:디폴트값
	private Date payment_date; //SYSDATE
	
	
	
	// shipping(배송)
	

	// receipt(카드기록)
	

}
