package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.MemberManage;

public interface MemberManageService {
	// 일반유저
	public List<MemberManage> normalMember(Map<String, Object> map) throws Exception;
	// 일반유저 차단
	public void block(String memberIdx) throws Exception;
	// 차단 해제
	public void unblock(String memberIdx) throws Exception;
	// 신고 3회 이상
	public List<MemberManage> reportMembers(String authority) throws Exception;
	public int dataCount (Map<String, Object> map);
	
	// 처음 프로젝트 신청한 일반유저
    public List<MemberManage> getUserProjectRequests(Map<String, Object> map) throws Exception;
    public int getUserProjectRequestsCount(Map<String, Object> map) throws Exception;
    public List<Map<String, Object>> debugProjectRequestData();
    
    // 메이커 승인
    public void approve(long memberIdx) throws Exception;
}
