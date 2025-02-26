package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.UsedBoardManage;

public interface UsedBoardManageService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<UsedBoardManage> UsedBoardList(Map<String, Object> map) throws SQLException;
	
	public int deleteUsedBoards(List<Long> boardNumList) throws SQLException;
	
	public List<UsedBoardManage> getPurchaseStatusList();
}
