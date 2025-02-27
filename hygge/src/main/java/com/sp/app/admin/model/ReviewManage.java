package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReviewManage {
	private long review_num;
	private long project_num;
	private long parent_num;
	private long sales_num; // 구매번호
	private long category_num; 
	private String category_name;
	private String project_title;
	private String nickName;
	private int report_count;
	
	private String reg_date;
	private String content;
	private int grade; // 평점
	
}
