package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

@Mapper
public interface TesterMapper {
	// 체험단 상세 정보
	public TestBoard testerInfo(long num);

	// 체험단 목록
	public List<TestBoard> listTestBoard(Map<String, Object> map);

	// 체험단 신청
	public void insertTesterForm(Tester dto) throws SQLException;

	// 체험단 신청 중복 확인
	public int checkTesterApplication(@Param("memberIdx") long memberIdx, @Param("num") long num);
}