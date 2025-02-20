package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

@Mapper
public interface VoteManageMapper {
	public List<ProjectManage> projectList() throws SQLException;
	public void insertVote(VoteManage dto) throws SQLException;
	public void insertVoteCandidate(long num) throws SQLException;
	
	public List<VoteManage> voteList(Map<String, Object> map) throws SQLException;
	public int dataCount(Map<String, Object> map) throws SQLException;
}
