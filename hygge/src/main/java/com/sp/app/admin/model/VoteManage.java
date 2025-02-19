package com.sp.app.admin.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class VoteManage {
    private long voteNum; // 회차번호
    private Date start_date; // 투표기간
    private String content;
    private String title;
    
    private long project_num; // 프로젝트 번호
    private String thumbnail;
}
