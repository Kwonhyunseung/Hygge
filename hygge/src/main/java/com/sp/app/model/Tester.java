package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Tester {
	private long memberIdx;
	private long num;
	private Date request_date; //SYSDATE
	private Date accept_date;
	private long review_num;
	private int block; //0:승인전 1:승인
	
}