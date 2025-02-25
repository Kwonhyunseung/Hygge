package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.MemberManage;

@Mapper
public interface MemberManageMapper {
	// 일반유저 리스트
	public List<MemberManage> normalMember(Map<String, Object> map) throws SQLException;
	// 일반유저 차단
	public void block(String memberIdx) throws SQLException;
	// 일반유저 차단해제
	public void unblock(String memberIdx) throws SQLException;
	// 신고 3회 이상인 유저
	public List<MemberManage> reportMembers(String authority) throws SQLException;
	public int dataCount(Map<String, Object> map) throws SQLException;
	
	public List<MemberManage> getUserProjectRequests(Map<String, Object> map) throws SQLException;
    public int getUserProjectRequestsCount(Map<String, Object> map) throws SQLException;
    
    public List<Map<String, Object>> debugProjectRequestData() throws SQLException;
    public void approve(long memberIdx) throws SQLException;
}
