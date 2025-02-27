package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ReviewManageMapper;
import com.sp.app.admin.model.ReviewManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class ReviewManageServcieImpl implements ReviewManageServcie{
	private final ReviewManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
	
		return result;
	}

	@Override
	public List<ReviewManage> reviewList(Map<String, Object> map) throws Exception {
		List<ReviewManage> list = null;
		try {
			list = mapper.reviewList(map);
		} catch (Exception e) {
			log.info("reviewList : ", e);
		}
		
		return list;
	}

	@Override
	public void deleteReviews(List<Long> reviewIds) throws Exception {
		mapper.deleteReviews(reviewIds);
	}

	@Override
	public List<ReviewManage> categories() throws Exception {
		List<ReviewManage> list = null;
		
		try {
			list = mapper.categories();
		} catch (Exception e) {
			log.info("categories : ");
		}
		
		return list;
	}
	
	@Transactional
	@Override
	public void blockMembersByReviews(List<Long> reviewIds) throws Exception {
		List<Long> memberIds  = null;
		
		try {
			
			mapper.blockMembersByReviews(reviewIds);
			
		} catch (Exception e) {
		}
	
	    
	    // 회원 상태를 '차단'으로 변경
	    if (!memberIds.isEmpty()) {
	       // mapper.updateMembersStatus(memberIds, "BLOCKED");
	    }
		
	}

}
