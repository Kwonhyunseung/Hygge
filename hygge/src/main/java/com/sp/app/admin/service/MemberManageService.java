package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.MemberManage;

public interface MemberManageService {
	public List<MemberManage> normalMember(String authority) throws Exception;
}
