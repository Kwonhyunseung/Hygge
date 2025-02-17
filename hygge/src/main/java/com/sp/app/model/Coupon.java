package com.sp.app.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Coupon {
	  private long num;            // 쿠폰 번호
	    private long memberIdx;      // 회원 번호
	    private Date issue_Date;      // 발급 날짜
	    private double discount_Rate; // 할인율
	    private double discount;     // 할인 금액
	    private Date used_Date;       // 사용 날짜
	    private String coupon_Name;   // 쿠폰 이름
}
