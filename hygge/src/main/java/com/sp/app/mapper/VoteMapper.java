package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Funding;
import com.sp.app.model.Vote;

public interface VoteMapper {
	public List<Funding> projectList() throws SQLException;
	
	public List<Vote> voteList(Map<String, Object> map) throws SQLException;
	public int dataCount(Map<String, Object> map) throws SQLException;
}
