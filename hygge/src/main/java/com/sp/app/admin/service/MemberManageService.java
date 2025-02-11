package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.MemberManage;

public interface MemberManageService {
	// 일반유저
	public List<MemberManage> normalMember(String authority) throws Exception;
}
