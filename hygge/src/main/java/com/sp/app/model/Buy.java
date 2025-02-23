package com.sp.app.model;

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
	// Coupon (쿠폰명, 할인율, 할인 최대 금액)
	// Payment (pay_way:결제수단. 0:카드결제 , shipping_fee:배송비 , pay_amount:결제금액)
	
	
	// shipping(배송)
	
	// receipt(카드기록)

}
