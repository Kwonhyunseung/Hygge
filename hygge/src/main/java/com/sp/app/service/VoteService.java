package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

public interface VoteService {
	
	// 프로젝트 제목, 썸네일을 받아오기 위함
	public List<ProjectManage> projectList() throws Exception;
	
	public void insertVote(VoteManage dto) throws Exception;
	public void insertVoteCandidate(long num) throws Exception;
	
	public List<VoteManage> voteList(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	
	public void voteSubmit(Map<String, Object> map);

}
