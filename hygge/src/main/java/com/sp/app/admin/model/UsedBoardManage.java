package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UsedBoardManage {
	private long board_num;
	private String nickName;
	private String title;
	private String content;
	private String reg_date;
	private int block; // 블라인드 상태
	private long hitCount;
	private int category; // 판매:0 구매:1
	private int deal; // default:0 / 미거래(0), 거래중(1), 거래완료(-1)
	private int price; // 제품 가격
	private String product; //제품명
	
	// usedRequest
	private long writer; // 글쓴이
	private long customer; // 구매자
	private String buyerNickName; // 구매자
	private int progress; // 구매 진행 상황 0:대기중 :9 거래완료
	
}
