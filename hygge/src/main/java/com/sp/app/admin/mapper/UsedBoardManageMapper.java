package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.UsedBoardManage;

@Mapper
public interface UsedBoardManageMapper {
	public int dataCount(Map<String, Object> map) throws SQLException;
	public List<UsedBoardManage> UsedBoardList(Map<String, Object> map) throws SQLException;
	
	public int deleteUsedBoards(List<Long> boardNumList) throws SQLException;
	
	public List<UsedBoardManage> getPurchaseStatusList() throws SQLException;
}
