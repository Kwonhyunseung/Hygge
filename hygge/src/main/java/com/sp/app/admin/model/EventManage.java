package com.sp.app.admin.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class EventManage {
	public long num;
	public String title;
	public String content;
	public Date evt_date;
	public Date exp_date;
    public String photo;
    private String status;
    
    // DB에 저장되지 않는 임시 필드
    public MultipartFile photoFile;
}
