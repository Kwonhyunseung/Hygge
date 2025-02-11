package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import com.sp.app.model.Member;

public interface MemberManageMapper {
	// 일반유저 리스트
	public List<Member> normalMember(String authority) throws SQLException;
	
}
