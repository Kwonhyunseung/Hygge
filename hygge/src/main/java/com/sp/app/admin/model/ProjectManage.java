package com.sp.app.admin.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProjectManage {
	private long num;
	private long memberIdx;
	private Date request_date;
	private Date accept_date;
	private Integer accept_return;
	private String return_reason;
	private String title;
	private int business;
	private String content;
	private long target; // 목표금액
	private int term; // 기간
	private String thumbnail;
	private int category_num; // 카테고리 번호
	
	// 유저정보
	private String name;
	private String email1;
	private String email2;
	private String reg_date;
	
	
	
}
