package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ProjectManage;

public interface ProjectManageService {
	public List<ProjectManage> projectList(Map<String, Object> map);
	public int dataCount (Map<String, Object> map);
    public void approveProject(Map<String, Object> map) throws Exception;
    public void rejectProject(long num, String reason) throws Exception;
    
    // 프로젝트 테이블에 인서트
    public void insertProject(Map<String, Object> map) throws Exception;
}
