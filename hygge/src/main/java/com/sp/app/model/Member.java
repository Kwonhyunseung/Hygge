package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Member {
	private long memberIdx; // 멤버 번호
	private String id;
	private String pwd;
	private String name;
	private String nickName;
	private int block;
	private String reg_date;
	private String mod_date;
	private String last_login;
	private int login_failure;
	private Integer category1;
	private Integer category2;
	private Integer category3;
	private String birth;
	private String email1;
	private String email2;
	private String addr1;
	private String addr2;
	private String postCode;
	private String tel1;
	private String tel2;
	private String tel3;
	private int age;
	private int gender;
	private String profile_img;
	
	
	private String authority;
	/* private String oldAuthority; */
	
	/* private String rt_value; */
	
	private long num; //memberStatus
	private int state; //변경상태
	private String memo;
	private long adminIdx;

	// 메이커 전용
	private String makerName;
	private String bankAccount;
	private MultipartFile profile_img_file;
	private String introduction;
}