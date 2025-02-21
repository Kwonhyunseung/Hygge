package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

public interface VoteManageService {
	
	// 프로젝트 제목, 썸네일을 받아오기 위함
	public List<ProjectManage> projectList() throws Exception;
	
	public void insertVote(VoteManage dto) throws Exception;
	public void insertVoteCandidate(long num) throws Exception;
	
	public List<VoteManage> voteList(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	
	// 투표 회차 정보
	public VoteManage findVote(long vote_num) throws Exception;
	// 투표 후보 프로젝트
	public List<ProjectManage> findVoteCandidates(long vote_num) throws Exception;
	// 투표 삭제
	public void deleteVote(long vote_num) throws Exception;
	public void updateVote(VoteManage dto) throws Exception;
	public void deleteVoteCandidate(long vote_num) throws Exception;
}
