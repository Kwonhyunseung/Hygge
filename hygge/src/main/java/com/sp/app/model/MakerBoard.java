package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MakerBoard {
   
	private int mkboard_Num; // 게시글 번호
    private String title;   // 제목
    private String content; // 내용 (CLOB)
    private String category; // 카테고리
    private int makeridx;   // 메이커 인덱스
    private int likeCount;  // 좋아요 개수
    private String name; // 이름
    private boolean userLiked;
}
