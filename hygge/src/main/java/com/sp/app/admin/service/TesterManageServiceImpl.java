package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.TesterManageMapper;
import com.sp.app.admin.model.TesterManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TesterManageServiceImpl implements TesterManageService {
	private final TesterManageMapper mapper;
	
	@Override
	public List<TesterManage> testerList(Map<String, Object> map) throws Exception {
		
		List<TesterManage> list = null;
		
		try {
			list = mapper.testerList(map);
		} catch (Exception e) {
			log.info("testerList : ", e);
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

	@Override
	public Map<String, Object> getStatusCount() throws Exception {
		Map<String, Object> map = null;
	
		try {
			map = mapper.getStatusCount();
		} catch (Exception e) {
			log.info("getStatusCount : ", e);
		}
		
		return map;
	}

	@Override
	public void approveTester(long memberIdx, long num) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", memberIdx);
			map.put("num", num);
			
			mapper.approveTester(map);
			
		} catch (Exception e) {
			log.info("approveTester : ", e);
		}
	}

	@Override
	public void rejectTester(long memberIdx, long num) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", memberIdx);
			map.put("num", num);
			
			mapper.rejectTester(map);
			
		} catch (Exception e) {
			log.info("rejectTester : ", e);
		}		
	}

}
