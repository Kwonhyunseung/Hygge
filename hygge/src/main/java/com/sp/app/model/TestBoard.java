package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestBoard {
	private long tester_num;
	private String title;
	private String content;
	private String thumbnail;
	private Date accept_date; //승인|반려 날짜. null 허용
	private int accept_return; //1:승인, 0:반려. null 허용
	private String return_reason; //반려사유. null 허용
	private Date start_date;
	private Date end_date;
	private Date request_date; //신청일. null 허용
	
}