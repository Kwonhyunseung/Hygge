package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.UsedBoardManageMapper;
import com.sp.app.admin.model.UsedBoardManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class UsedBoardManageServiceImpl implements UsedBoardManageService {
	private final UsedBoardManageMapper UsedMapper;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = UsedMapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<UsedBoardManage> UsedBoardList(Map<String, Object> map) throws SQLException {
		List<UsedBoardManage> list = null;
		
		try {
			list = UsedMapper.UsedBoardList(map);
		} catch (Exception e) {
			log.info("UsedBoardList : ", e);
		}
		
		return list;
	}

	@Override
	public int deleteUsedBoards(List<Long> boardNumList) throws SQLException {
		int result = 0;
		
		try {
			result = UsedMapper.deleteUsedBoards(boardNumList);
		} catch (Exception e) {
			log.info("deleteUsedBoards : ",e);
		}
		
		return result;
	}

	@Override
	public List<UsedBoardManage> getPurchaseStatusList() {
		List<UsedBoardManage> list = null;
		try {
			list = UsedMapper.getPurchaseStatusList();
		} catch (Exception e) {
			log.info("UsedBoardManage : ", e);
		}
		
		return list;
	}
	


}
