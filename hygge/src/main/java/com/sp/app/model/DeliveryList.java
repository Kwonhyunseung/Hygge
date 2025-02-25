package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class DeliveryList {
	private long dest_num; //번호
	private long memberxIdx;
	private String addr1;
	private String addr2;
	private int postCode;
	private String receiver; //받는사람. null 허용
	private int default_dest; //기본:0, 새로운주소:1
	private String request; //요청사항. null 허용
}