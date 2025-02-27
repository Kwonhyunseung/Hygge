package com.sp.app.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Coupon {
	private long num; //이벤트번호
	private long memberIdx;
	private Date issue_Date; //발급날짜.
	private double discount_Rate; // 할인율
	private double discount; // 할인 최대 금액
	private Date used_Date; // 사용 날짜. NULL허용
    private String coupon_Name; // 쿠폰 이름
    
    
    // Event 추가
	private Date evt_date; //이벤트 날짜
	private String title; //이벤트 제목
	private Date exp_date; //쿠폰 만기일
	
	private String photo; //이벤트 사진
	private String content; //내용
}
