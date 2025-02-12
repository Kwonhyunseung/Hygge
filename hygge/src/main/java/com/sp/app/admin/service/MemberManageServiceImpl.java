package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.MemberManageMapper;
import com.sp.app.admin.model.MemberManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Service
@RequiredArgsConstructor
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {
	private final MemberManageMapper mapper;
	
	
	@Override
	public List<MemberManage> normalMember(Map<String, Object> map) throws Exception {
		return mapper.normalMember(map);
	}


	@Override
	public void block(String memberIdx) throws Exception {
		mapper.block(memberIdx);
	}


	@Override
	public void unblock(String memberIdx) throws Exception {
		mapper.unblock(memberIdx);
	}


	@Override
	public List<MemberManage> reportMembers(String authority) throws Exception {
		List<MemberManage> list = null;
		
		try {
			list = mapper.reportMembers(authority);
		} catch (Exception e) {
			log.info("reportMembers : ", e);
		}
		
		return list;
	}


	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}


}

