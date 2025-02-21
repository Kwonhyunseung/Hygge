package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Vote {
    private long vote_num; // 회차번호
    private Date start_date; // 투표기간
    private String content;
    private String title;
    
    private int voteCount; // 투표 수
    
    private long project_num;
    private long project_num1; // 프로젝트 번호
    private long project_num2; // 프로젝트 번호
    private long project_num3; // 프로젝트 번호
    private long project_num4; // 프로젝트 번호
    
    // 투표 보내기
    private int memberIdx;
    private Date vote_date;
    
    // 페이징 처리 데이터
    private int page;
}
