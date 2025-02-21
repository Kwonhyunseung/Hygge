package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	public VoteManage findVote(long vote_num) throws Exception {
		VoteManage dto = null;
		try {
			dto = mapper.findVote(vote_num);
		} catch (Exception e) {
			log.info("findVote : ", e);
		}
		
		return dto;
	}

	@Override
	public List<ProjectManage> findVoteCandidates(long vote_num) throws Exception {
		List<ProjectManage> list = null;
		try {
			list = mapper.findVoteCandidates(vote_num);
		} catch (Exception e) {
			log.info("findVoteCandidates : ", e);
		}
		
		return list;
	}

	@Transactional
	@Override
	public void deleteVote(long vote_num) throws Exception {
        mapper.deleteVoteCandidate(vote_num);
        mapper.deleteVoteHistory(vote_num);
        mapper.deleteVote(vote_num);
        
	}

	@Override
	public void updateVote(VoteManage dto) throws Exception {
		try {
			mapper.updateVote(dto);
		} catch (Exception e) {
			log.info("updateVote : ", e);
		}
	}

	@Override
	public void deleteVoteCandidate(long vote_num) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
