package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

@Mapper
public interface TesterMapper {
	public TestBoard testerInfo(long num);
	public void insertTesterForm(Tester dto) throws SQLException;
    int checkTesterApplication(@Param("memberIdx") long memberIdx, @Param("num") long num);
	public int checkTesterApplication(Map<String, Object> map);
}