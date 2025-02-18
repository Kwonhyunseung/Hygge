package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sp.app.admin.model.ProjectManage;

@Mapper
public interface ProjectManageMapper {
	public List<ProjectManage> projectList(Map<String, Object> map) throws SQLException;
	public int dataCount (Map<String, Object> map) throws SQLException;
	
    public void approveProject(long num) throws SQLException;
    public void rejectProject(@Param("num") long num, @Param("reason") String reason) throws SQLException;
}
