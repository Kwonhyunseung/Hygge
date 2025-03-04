package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.QnaManage;

public interface QnaManageService {
	public List<QnaManage> qnaList(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public Map<String, Object> getStatusCounts() throws Exception;
	public List<Map<String, Object>> getCategoryList() throws Exception;
}
