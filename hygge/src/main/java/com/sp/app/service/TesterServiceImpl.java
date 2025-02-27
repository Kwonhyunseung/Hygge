package com.sp.app.service;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
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
	public List<TestBoard> listTestBoard(Map<String, Object> map) {
		List<TestBoard> list = null;
		try {
			list = mapper.listTestBoard(map);
		} catch (Exception e) {
			log.error("listTestBoard 오류", e);
		}
		return list;
	}
	
	@Override
	public void insertTesterForm(Tester dto) throws Exception {
		try {
			mapper.insertTesterForm(dto);
		} catch (Exception e) {
			log.error("insertTesterForm 오류", e);
			throw e;
		}
	}
	
	@Override
	public boolean isAlreadyApplied(long memberIdx, long num) {
		boolean result = false;
		try {
			int count = mapper.checkTesterApplication(memberIdx, num);
			result = count > 0;
		} catch (Exception e) {
			log.error("isAlreadyApplied 오류", e);
		}
		return result;
	}
}