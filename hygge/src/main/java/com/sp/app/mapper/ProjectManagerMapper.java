package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProjectManager;

@Mapper
public interface ProjectManagerMapper {
	public ProjectManager findById(String id) throws SQLException;
	public int dataCount(Map<String, Object> map);
	List<ProjectManager> listProject(Map<String, Object> map); 
}
