package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.ProjectManager;

public interface ProjectManagerService {
	List<ProjectManager> listProject(Map<String, Object> map); 
	
	public int dataCount(Map<String, Object> map);
	public ProjectManager findById(String id) throws SQLException;
	
	public List<ProjectManager> listboard(Map<String, Object> map);
	public int b_dataCount(Map<String, Object> map);
	
	public void insertBoard(ProjectManager dto,String uploadPath) throws SQLException;
	public void updateBoard(ProjectManager dto,String uploadPath) throws Exception;
	public void deleteBoard(String uploadPath,long mkboard_Num) throws Exception;
	public void insertFile(ProjectManager dto,String uploadPath) throws SQLException;
	
	
	public List<ProjectManager> listFile(long mkboard_Num);
	public ProjectManager findByFileId(long fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	public boolean deleteUploadFile(String uploadPath, String filename);
	public void updateFile(ProjectManager dto,String uploadPath);
	public ProjectManager findById(long mkboard_Num);
}
