package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.MemberManage;

@Mapper
public interface MemberManageMapper {
	// 일반유저 리스트
	public List<MemberManage> normalMember(String authority) throws SQLException;
	
}
