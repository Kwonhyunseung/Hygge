package com.sp.app.admin.model;

import java.util.Date;

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
    private Date evt_date;
    private Date exp_date;
    private String photo; // 이미지 경로를 저장
    private String status;
    
    // DB에 저장되지 않는 임시 필드
    private MultipartFile photoFile;
}