package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MemberManage {
	private Long memberIdx; // 멤버 번호
	private String id;
	private String pwd;
	private String name;
	private int userLevel;
	private int block;
	private String reg_date;
	private String mod_date;
	private String last_login;
	private int login_failure;
	private String nickName;
	private Integer category1;
	private Integer category2;
	private Integer category3;
	
	// 신고 횟수
	
	/*
	private String zip;
	private String addr1;
	private String addr2;
	private int failure_cnt;
	*/
	
	private String authority;
	private String oldAuthority;
	
	private String rt_value;
}
