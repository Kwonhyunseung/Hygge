package com.sp.app.service;

import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

public interface TesterService {
	public TestBoard testerInfo(long num);
	public void insertTesterForm(Tester dto) throws Exception;
    boolean checkDuplicateApplication(long memberIdx, long num);
}