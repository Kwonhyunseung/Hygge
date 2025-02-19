package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

public interface VoteManageService {
	
	// 프로젝트 제목, 썸네일을 받아오기 위함
	public List<ProjectManage> projectList() throws Exception;
	
	public void insertVote(VoteManage dto) throws Exception;
	//public void insertVoteCandidate(List<int, int>)

}
