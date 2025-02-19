package com.sp.app.admin.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class EventManage {
    private long num;
    private String title;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date evt_date;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date exp_date;
    
    private String photo;      // DB에서 가져온 파일명 리스트
    private List<MultipartFile> photoFiles; // 업로드할 파일들
}