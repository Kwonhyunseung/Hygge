package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.VoteMapper;
import com.sp.app.model.Funding;
import com.sp.app.model.Vote;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
/*
@Service
@Slf4j
@RequiredArgsConstructor
public class VoteServiceImpl implements VoteService{
	private final VoteMapper mapper;
	
	@Override
	public List<Funding> projectList() throws Exception {
		List<Funding> list = mapper.projectList();
		
		try {
			list = mapper.projectList();
		} catch (Exception e) {
			log.info("projectList : ", e);
		}
		
		return list;
	}

	@Override
	public List<Vote> voteList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
*/
