package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

@Mapper
public interface VoteManageMapper {
	public List<ProjectManage> projectList() throws SQLException;
	public void insertVote(VoteManage dto) throws SQLException;
}
