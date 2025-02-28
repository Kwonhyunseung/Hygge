package com.sp.app.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Review {
	private long review_num;
	private String content;
	private int grade; // 5점 만점
	private String reg_date;
	
	private long project_num;
	private long sales_num;
	
	private int pay_amount;
	private Date payment_date;
	private Long product_num;
	private Long memberIdx;
	private String memberId;
	private String memberName;
	private String title;

	private String nickName;
	private String profile_img;

	private long reviewphoto_num;
	private List<String> sfileName;
	private List<MultipartFile> selectFile;
	private String review_img;
	
	
}
