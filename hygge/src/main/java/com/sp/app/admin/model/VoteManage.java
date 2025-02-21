package com.sp.app.admin.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class VoteManage {
    private long vote_num; // 회차번호
    private Date start_date; // 투표기간
    private String content;
    private String title;
    private String thumbnail;
    
    private long total_votes;
    private long vote_count; // 프로젝트 번호
    
}
