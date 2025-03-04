package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class QnaManage {
	private long num;
	private long memberIdx;
	private String q_title;
	private String q_content;
	private String a_title; // 답변 제목
	private String a_content; // 답변 내용
	private int block; // 차단 1, 비차단 0
	private String q_date; // 질문일자
	private String a_date;
	private int category;
	
	
	/*
	 * CREATE TABLE `QnA` (
	`num`	NUMBER	NOT NULL,
	`memberIdx`	NUMBER	NOT NULL	COMMENT '질문자',
	`q_title`	VARCHAR2(1000)	NOT NULL,
	`q_content`	VARCHAR2(4000)	NOT NULL,
	`a_title`	VARCHAR2(1000)	NULL,
	`a_content`	VARCHAR2(4000)	NULL,
	`block`	NUMBER(1)	NOT NULL	DEFAULT 0	COMMENT '비차단 0, 차단1',
	`q_date`	DATE	NOT NULL	DEFAULT SYSDATE,
	`a_date`	DATE	NULL,
	`category`	NUMBER	NOT NULL,
	`adminIdx`	NUMBER	NULL
);
	 */
}
