package com.sp.app.model;

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
	
	private int num; //신청번호
	
	// project
	private String start_date;
	private String end_date; //종료일
	private int block;
	private String delivery_info;
	private String project_info;
	
	// projectLike
	
	// projectRequest
	private String accept_date; //승인일
	private String content;
	private int target; //목표금액
	private int term; //프로젝트 기간
	
	// memberAuthority
	private String authority;
	
	// follow
	
	
	
	
	
	
	
	private String request_date;
	private String return_reason;
	private String thumbnail;
	private int category_num;
	
	private int parent_num;
	private String name;
}