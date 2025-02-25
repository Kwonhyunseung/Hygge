package com.sp.app.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Product {
	private long product_num; //상품번호
	private int price;
	private int stock; //상품수량
	private String detail; //상품상세정보
	private String title;
	private String origin; //원산지
	private long num; //신청번호
	
	// Payment
	private int total_amount;
	
	// TODO 결제 때문에 추가
	private String delivery_info; //배송정보
	private int shipping_fee; //배송비

	private List<Integer> priceList;
	private List<Integer> stockList;
	private List<String> detailList;
	private List<String> titleList;
	private List<String> originList;
}