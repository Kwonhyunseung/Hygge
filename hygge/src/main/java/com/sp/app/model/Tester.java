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
	
	// 추가 필드 - 폼에서 받을 정보
	private String name;    // 닉네임
	private String age;     // 나이
	private String tel1;    // 전화번호1
	private String tel2;    // 전화번호2
	private String tel3;    // 전화번호3
	private int gender;     // 성별 (1: 남, 2: 여)
	private String addr1;   // 주소1
	private String addr2;   // 상세주소
	private String postCode; // 우편번호
}