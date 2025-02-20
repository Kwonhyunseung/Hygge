package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.model.Funding;
import com.sp.app.model.Vote;

public interface VoteService {
	
	// 프로젝트 제목, 썸네일을 받아오기 위함
	public List<Funding> projectList() throws Exception;
	
	public List<Vote> voteList(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
}
