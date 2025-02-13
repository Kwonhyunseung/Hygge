package com.sp.app.service;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.MyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService{
	private final MyPageMapper mapper;
	
	
	@Override
	public MyPage findById(String id) {
		MyPage dto = null;
		
		try {
			dto = mapper.findById(id);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}
}
