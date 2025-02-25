package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Maker {
	private long memberIdx;
	private String introduction;
	private String bankAccount;
	private String makerName;
	private String profile_img;

	private MultipartFile profileImg_File;
}
