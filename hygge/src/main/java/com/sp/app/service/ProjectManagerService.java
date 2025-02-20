package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.ProjectManager;

public interface ProjectManagerService {
	List<ProjectManager> listProject(Map<String, Object> map); 
	
	public int dataCount(Map<String, Object> map);
	public ProjectManager findById(String id) throws SQLException;
}
