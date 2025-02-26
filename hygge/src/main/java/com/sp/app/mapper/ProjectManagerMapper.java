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
	
	public List<ProjectManager> listboard(Map<String, Object> map);

	public void insertBoard(ProjectManager dto) throws SQLException;
	public void updateBoard(ProjectManager dto) throws SQLException;
	public void deleteBoard(long mkboard_Num) throws SQLException;
	
	public int b_dataCount(Map<String, Object> map);
	
	// 새로 추가된 메서드
	public void insertFile(Map<String, Object> map) throws SQLException; // 파일 정보 삽입
	public long makerBoardSeq();
	public List<ProjectManager> listFile(long mkboard_Num);
	public ProjectManager findByFileId(long fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	public ProjectManager findById(long mkboard_Num);
}
