package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class Funding {
	private long num;
	private long memberIdx;
	private String request_date;
	private String accept_date;
	private int accept_return; // 승인/반려 여부: 승인 1, 반려 0
	private String return_reason; // 반려 사유
	private String title;
	private int business; // 사업자 등록되어있는 경우 1, 아닌경우 0
	private String content;
	private int target;
	private int term;
	private String thumbnail;
	private int category_num;

	private String start_date;
	private String end_date;
	private int block;
	private String delivery_info;
	private String project_info;

	private int progress;
	private int total_amount;
	private boolean userLiked;
	
	private String name; //카테고리명 추가

	private MultipartFile thumbnail_File;
	private MultipartFile business_File;
	
}
