package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.TesterManage;

public interface TesterManageService {
	public List<TesterManage> testerList(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public Map<String, Object> getStatusCount() throws Exception;
	
	public void approveTester(long memberIdx, long num) throws Exception;
	public void rejectTester(long memberIdx, long num) throws Exception;
}
