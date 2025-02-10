package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UsedRequest {
	private long num; // 게시글 번호
	private String writerIdx; // 게시글 작성자 idx
	private String custormerIdx; // 거래유저 idx
	private int price;
	private String content;
}
