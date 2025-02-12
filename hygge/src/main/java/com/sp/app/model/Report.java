package com.sp.app.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class Report {
	private long num;
	private String tablename;
	private long reportedNumber;
	private long memberIdx;
	private long memberIdx2;
}
