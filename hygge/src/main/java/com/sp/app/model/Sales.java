package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Sales {
	private long num;
	private long product_num; //상품번호
	private int amount; //구매개수. EX) A라는 상품에 구성이 1,2,3일 경우, 1의 대한 구매 개수
	private int sum; //구매금액. EX) 1의 구매개수*가격 합
	private long payment_num; //결제번호
}