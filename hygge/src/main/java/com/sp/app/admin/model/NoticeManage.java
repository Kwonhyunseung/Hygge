package com.sp.app.admin.model;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NoticeManage {
    private long num;
    private String title;
    private String content;
    private Date regDate;
    private long memberIdx;
    
    // 파일 관리를 위한 필드
    private List<MultipartFile> attachFiles;
    private long noticeNum;  // notice_num 용
    private String s_FileName; // s_FileName 용
    
    private String name;
}
