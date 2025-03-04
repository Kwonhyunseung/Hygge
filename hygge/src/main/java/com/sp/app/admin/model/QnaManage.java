package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class QnaManage {
    private long num;
    private long memberIdx;
    private String q_title;
    private String q_content;
    private String a_title; // 답변 제목
    private String a_content; // 답변 내용
    private int block; // 차단 1, 비차단 0
    private String q_date; // 질문일자
    private String a_date;
    private int category;
    private String nickname; // member1 테이블에서 조인하여 가져오는 사용자 닉네임
    private String category_name; // Q_Category 테이블에서 조인하여 가져오는 카테고리명
    private String answer_status; // 답변 상태 (미답변/답변완료)
    private Long adminIdx; // 답변 관리자 ID (null 가능)
    
    private long pending_count;
    private long completed_count;
    private long total_count;
}