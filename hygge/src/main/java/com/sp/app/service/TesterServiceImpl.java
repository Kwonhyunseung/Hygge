package com.sp.app.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.TesterMapper;
import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TesterServiceImpl implements TesterService {
	private final TesterMapper mapper;

	@Override
	public TestBoard testerInfo(long num) {
		TestBoard dto = null;
		try {
			dto = mapper.testerInfo(num);
		} catch (Exception e) {
			log.error("testerInfo 오류", e);
		}
		return dto;
	}

	@Override
	@Transactional
	public void insertTesterForm(Tester dto) throws Exception {
	    try {
	        mapper.insertTesterForm(dto);
	    } catch (Exception e) {
	        log.error("insertTesterForm 오류", e);
	        throw e;
	    }
	}

	@Override
	public boolean checkDuplicateApplication(long memberIdx, long num) {
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("memberIdx", memberIdx);
	        map.put("num", num);
	        
	        int count = mapper.checkTesterApplication(map);
	        return count > 0;
	    } catch (Exception e) {
	        log.error("checkDuplicateApplication 오류", e);
	        return false;
	    }
	}
}