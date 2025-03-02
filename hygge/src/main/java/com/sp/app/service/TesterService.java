package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

public interface TesterService {
	public TestBoard testerInfo(long num);
	public void insertTesterForm(Tester dto) throws Exception;
    boolean checkDuplicateApplication(long memberIdx, long num);
    
    public List<TestBoard> testBoardList(Map<String, Object> map) throws Exception;
    public int dataCount(Map<String, Object> map) throws Exception;
}