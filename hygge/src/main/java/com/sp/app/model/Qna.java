package com.sp.app.model;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class Qna {
    private int num; // NUM
    private long memberIdx; // MEMBERIDX
	private String userId;
	private String userName;
    private String q_Title; // 질문제목
    private String q_Content; // Q_CONTENT
    private String a_Title; // A_TITLE
    private String a_Content; // A_CONTENT
    private int block; // BLOCK
    private Date q_Date; // Q_DATE
    private Date a_Date; // A_DATE
    private int category; // CATEGORY
    private Integer adminIdx; // ADMINIDX
    private String name;
}


