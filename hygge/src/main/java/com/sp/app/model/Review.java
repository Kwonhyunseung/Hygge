package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Review {
    private Long reviewNum;
    private String content;
    private int grade;
    private Long projectNum;
    private Long salesNum;
    private Long memberIdx;
    private String memberId;
    private String memberName;
}
