package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.HomeMapper;
import com.sp.app.model.Category;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class HomeServiceImpl implements HomeService{
	private final HomeMapper mapper;
	
	@Override
	public List<Category> subListCategory(long parent_num) {
		List<Category> list = null;
		
		try {
			list = mapper.subListCategory(parent_num);
		} catch (Exception e) {
			log.info("subListCategory: ", e);
		}
		return list;

	}

}
