package com.sp.app.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ProjectManageMapper;
import com.sp.app.admin.model.ProjectManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProjectManageServiceImpl implements ProjectManageService {
	private final ProjectManageMapper mapper;
	
	@Override
	public List<ProjectManage> projectList(Map<String, Object> map) {
		List<ProjectManage> list = null;
		
		try {
			list = mapper.projectList(map);
		} catch (Exception e) {
			log.info("projectList : ", e);
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Transactional
	@Override
	public void approveProject(Map<String, Object> map) throws Exception {
		try {
			mapper.approveProject((Long)map.get("num"));
			insertProject(map);
		} catch (Exception e) {
			log.info("approveProject : ", e);
			throw e;
		}
		
	}

	@Override
	public void rejectProject(long num, String reason) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("reason", reason);
			
			mapper.rejectProject(num, reason);
		} catch (Exception e) {
			log.info("approveProject : ", e);
		}
	}

	@Override
	public void insertProject(Map<String, Object> map) throws Exception {
		mapper.insertProject(map);
	}
	
	
}
