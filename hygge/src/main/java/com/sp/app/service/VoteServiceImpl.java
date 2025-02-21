package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.VoteManageMapper;
import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class VoteServiceImpl implements VoteService{
	private final VoteManageMapper mapper;

	@Override
	public void insertVote(VoteManage dto) throws Exception {
		mapper.insertVote(dto);
	}

	@Override
	public List<ProjectManage> projectList() throws Exception {
		List<ProjectManage> list = null;
		
		try {
			list = mapper.projectList();
		} catch (Exception e) {
			 log.error("projectList error", e);
		}
		
		return list;
	}

	@Override
	public void insertVoteCandidate(long num) throws Exception {
		mapper.insertVoteCandidate(num);
	}

	@Override
	public List<VoteManage> voteList(Map<String, Object> map) throws Exception {
		List<VoteManage> list = null;
		
		try {
			list = mapper.voteList(map);
		} catch (Exception e) {
			log.info("voteList : ", e);
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount :", e);
		}
		return result;
	}
	
}

