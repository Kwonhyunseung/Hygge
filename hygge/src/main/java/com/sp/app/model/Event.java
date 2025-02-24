package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Event {
	private long num; //이벤트 번호
	private Date evt_date; //이벤트 날짜
	private String title; //이벤트 제목
	private Date exp_date; //쿠폰 만기일
	
	private String photo; //이벤트 사진
	private String content; //내용
	
	// Coupon
	private Date issue_date; //발급날짜. 쿠폰 발급받은 순간의 시간!!
	private int discount_rate; //할인율
	private int discount; //할인최대금액
	private Date used_date; //사용날짜. null허용
	
	private long memberIdx;
}