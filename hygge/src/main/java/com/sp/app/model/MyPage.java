package com.sp.app.model;


import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MyPage {
    private int memberIdx;
    private String id;
    private String pwd;
    private String name;
    private String nickName;
    private String addr1;
    private String addr2;
    private int age;
    private int gender;
    private Date birth;
    private String email1;
    private String email2;
    private int tel1;
    private int tel2;
    private int tel3;
    private String category1;
    private String category2;
    private String category3;
    private Long reviewNum;
    private String content;
    private int grade;
    private Long projectNum;
    private Long salesNum;
    private String profile_img;
    
    private MultipartFile profileImg_File;
}
