package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProjectManagerMapper;
import com.sp.app.model.ProjectManager;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProjectManagerServiceImpl implements ProjectManagerService{
	
	@Autowired
	private final ProjectManagerMapper mapper;
	
	
	
	@Override
	public List<ProjectManager> listProject(Map<String, Object> map) {
		List<ProjectManager> list = null;
		
		try {
			list = mapper.listProject(map);
		} catch (Exception e) {
			log.error("리스트 조회 실패 : " , e);
		}	
		
		return list;
	}



	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.error("dataCount : " , e);
		}
		
		return result;
	}



	@Override
	public ProjectManager findById(String id) throws SQLException {
		ProjectManager dto = null;
		
		try {
			dto = mapper.findById(id);
			
		} catch (Exception e) {
			log.error("findById : " , e);
		}
		
		return dto;
	}



	@Override
	public List<ProjectManager> listBoard(Map<String, Object> map) {
		List<ProjectManager> list = null;
		
		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			log.error("리스트 조회 실패 : " , e);
		}	
		return list;	
	}



	@Override
	public int b_dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.b_dataCount(map);
		} catch (Exception e) {
			log.error("dataCount : " , e);
		}
		
		return result;
	}



	@Override
	public void insertBoard(ProjectManager dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}



	@Override
	public void updateBoard(ProjectManager dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}



	@Override
	public void deleteBoard(ProjectManager dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}
