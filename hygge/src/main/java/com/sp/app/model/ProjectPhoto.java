package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProjectPhoto {
	private long photo_num;
	private String s_FileName;
	private int photo_order;
	private long num;

	private List<MultipartFile> photoFiles;
}
