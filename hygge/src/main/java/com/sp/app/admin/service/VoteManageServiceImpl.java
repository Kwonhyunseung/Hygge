package com.sp.app.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.VoteManageMapper;
import com.sp.app.admin.model.ProjectManage;
import com.sp.app.admin.model.VoteManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class VoteManageServiceImpl implements VoteManageService{
	private final VoteManageMapper mapper;
	
	@Override
	public void insertVote(VoteManage dto) throws Exception {
		//mapper.insertVote(dto);
	}

	@Override
	public List<ProjectManage> projectList() throws Exception {
		
		
		return null;
	}

}
