package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Reply {
	private long num;
	private long board_num;
	private long memberIdx;
	private String content;
	private String reg_date;
	private int block;
	private long parent_num;
}
