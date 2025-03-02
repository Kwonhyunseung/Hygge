package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CouponManage {
	private long num;
	private long memberIdx;
	private String issue_date; // 발급 날짜
	private int discount_rate;
	private long discount; // 최대 할인율
}
