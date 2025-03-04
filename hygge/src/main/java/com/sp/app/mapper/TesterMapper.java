package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

@Mapper
public interface TesterMapper {
	public TestBoard testerInfo(long num);
	public void insertTesterForm(Tester dto) throws SQLException;
	public int checkTesterApplication(Map<String, Object> map);
	
	public List<TestBoard> testBoardList(Map<String, Object> map) throws SQLException;
    public int dataCount(Map<String, Object> map) throws SQLException;
}