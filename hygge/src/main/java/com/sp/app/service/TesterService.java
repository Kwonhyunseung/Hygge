package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

public interface TesterService {
	// 체험단 상세 정보
	public TestBoard testerInfo(long num);

	// 체험단 목록
	public List<TestBoard> listTestBoard(Map<String, Object> map);

	// 체험단 신청
	public void insertTesterForm(Tester dto) throws Exception;

	// 체험단 신청 중복 확인
	public boolean isAlreadyApplied(long memberIdx, long num);
}