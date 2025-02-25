package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.VoteManage;
import com.sp.app.model.Funding;
import com.sp.app.model.Vote;

@Mapper
public interface VoteMapper {
	public List<Funding> projectList() throws SQLException;
	
	public List<Vote> voteList(Map<String, Object> map) throws SQLException;
	public int dataCount(Map<String, Object> map) throws SQLException;
	
	public VoteManage findVote(long voteNum) throws SQLException;

	public void voteSubmit(Map<String, Object> map);
}
