package com.sp.app.service;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.TesterMapper;
import com.sp.app.model.TestBoard;
import com.sp.app.model.Tester;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TesterServiceImpl implements TesterService{
	private final TesterMapper mapper;
	
	@Override
	public TestBoard testerInfo(long num) {
		TestBoard dto = null;
		try {
			dto = mapper.testerInfo(num);
		} catch (Exception e) {

		}
		return dto;
	}

	@Override
	public void insertTesterForm(Tester dto) throws Exception {
		try {
			mapper.insertTesterForm(dto);
		} catch (Exception e) {
			log.info("insertTesterForm: ", e);
		}
	}

	
}