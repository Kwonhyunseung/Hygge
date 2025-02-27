package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
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
	private int parent_num;
	private int category_num;

	private String start_date;
	private String end_date;
	private int block;
	private String delivery_info;
	private String project_info;
	private int delivery_fee;

	private int progress;
	private int total_amount;
	private boolean userLiked;
	
	private String name; //카테고리명 추가
	
	private String profile_img; //프로필 이미지
	private String makerName;

	private MultipartFile thumbnail_File;
	private MultipartFile business_File;
	private List<MultipartFile> photoFiles;

	private long photo_num;
	private String sfileName; // ProjectPhoto 에 들어갈 서버에 저장된 파일 이름
	private int photo_order;

	//TODO 메이커 소개
	private int followingCount; //팔로우 수
	private String nickname;
	//TODO Custom
	private String funding_goal;
	private String remained_date;
	private String payment_date;

	private List<Product> product;
}
