package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Buy {
	
	private String thumbnail;
	private String title;
	private String price;
	private int amount;
	private int sum;
	
	private String name;
	private String email1;
	private String email2;
	private int tel1;
	private int tel2;
	private int tel3;
	private String addr1;
	private String addr2;
	
	private String receiver;
	private String address;
	private String detailAddr;
	private int postCode;

	
}