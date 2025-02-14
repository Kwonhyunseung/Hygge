package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.TesterManage;

@Mapper
public interface TesterManageMapper {
	public List<TesterManage> testerList(Map<String, Object> map) throws SQLException;
	public int dataCount(Map<String, Object> map) throws SQLException;
	public Map<String, Object> getStatusCount() throws SQLException;
	public void approveTester(Map<String, Object> map) throws SQLException;
	public void rejectTester(Map<String, Object> map) throws SQLException;
}
