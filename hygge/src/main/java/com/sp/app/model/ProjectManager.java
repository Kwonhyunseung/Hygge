package com.sp.app.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProjectManager {
    private Long num;              // 프로젝트 ID
    private Long memberIdx;        // 회원 ID
    private String name;           // 회원 이름 (member1 테이블)
    private Date request_date;     // 신청 날짜
    private Date accept_date;      // 승인 날짜
    private String title;          // 프로젝트 제목
    private Integer business;      // 사업 여부 (1=사업, 0=개인)
    private Integer end_date;      // 프로젝트 종료 날짜
    private String content;        // 프로젝트 내용 (CLOB)
    private Long target;           // 목표 금액
    private Integer term;          // 진행 기간 (일)
    private String thumbnail;      // 대표 이미지 경로
    private Long category_num;     // 카테고리 ID
    private Integer accept_return; // 승인 여부 (0=대기, 1=승인, 2=반려)
    private String return_reason;  // 반려 사유 (반려 시 입력됨)
}
