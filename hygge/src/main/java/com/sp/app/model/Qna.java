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
    private int memberIdx; // MEMBERIDX
	private String userId;
	private String userName;
    private String qTitle; // 질문제목
    private String qContent; // Q_CONTENT
    private String aTitle; // A_TITLE
    private String aContent; // A_CONTENT
    private int block; // BLOCK
    private Date qDate; // Q_DATE
    private Date aDate; // A_DATE
    private int category; // CATEGORY
    private Integer adminIdx; // ADMINIDX
}


