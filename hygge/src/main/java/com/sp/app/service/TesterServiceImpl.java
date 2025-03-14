package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
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
		log.info("Inserting Tester Form: {}", dto);
		try {
			mapper.insertTesterForm(dto);
		} catch (Exception e) {
			log.error("insertTesterForm 오류", e);
		}
	}

	@Override
	public boolean checkDuplicateApplication(long memberIdx, long num) {
		log.info("Checking duplicate - memberIdx: {}, num: {}", memberIdx, num);
		Map<String, Object> map = new HashMap<>();
		map.put("memberIdx", memberIdx);
		map.put("num", num);

		int count = mapper.checkTesterApplication(map);
		return count > 0;
	}

	@Override
	public List<TestBoard> testBoardList(Map<String, Object> map) throws Exception {
		List<TestBoard> list = null;
		try {
			list = mapper.testBoardList(map);
		} catch (Exception e) {
			log.info("testBoardList : ", e);
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

}