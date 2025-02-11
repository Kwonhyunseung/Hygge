package com.sp.app.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.MemberManageMapper;
import com.sp.app.admin.model.MemberManage;
import com.sp.app.model.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Service
@RequiredArgsConstructor
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {
	private final MemberManageMapper mapper;
	
	
	@Override
	public List<MemberManage> normalMember(String authority) throws Exception {
		return mapper.normalMember(authority);
	}


}

