package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UsedBoard {
	private long num;
	private long memberIdx;
	private String nickName;
	private String title;
	private String content;
	private String reg_date;
	private int block;
	private int hitCount;
	private int category; // 구매 / 판매여부
	private int deal; // 미거래(0), 거래중(승인 대기 중, 1), 거래완료(-1)
	private int price;
	private String priceFormat;
	private String product; // 제품명

	private List<String> s_Filename;

	private List<MultipartFile> selectFile;
}
