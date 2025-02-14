package com.sp.app.admin.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TesterManage {
	private String memberIdx;
	private String nickName;
	private long num;
	private Date request_date;
	private Date accept_date;
	private long review_num;
	private int block;
	
	private String title;
	private String name;
}
