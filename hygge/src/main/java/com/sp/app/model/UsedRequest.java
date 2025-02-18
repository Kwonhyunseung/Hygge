package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UsedRequest {
	private long num; // 게시글 번호
	private String writer; // 게시글 작성자 idx
	private String customer; // 거래유저 idx
	private int price;
	private String content;
	private int progress;
}
