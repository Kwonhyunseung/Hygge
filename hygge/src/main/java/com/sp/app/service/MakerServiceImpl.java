package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MakerMapper;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MakerServiceImpl implements MakerService {
	private final MakerMapper mapper;

	@Override
	public void insertProjectRequest(Funding dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Category> listCategory(long num) {
		List<Category> list = null;
		try {
			list = mapper.listCategory(num);
		} catch (Exception e) {
			log.info("listCategory : ", e);
		}
		return list;
	}

}
