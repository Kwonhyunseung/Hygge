package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.model.Member;

public interface MemberManageService {
	public List<Member> normalMember(String authority) throws Exception;
}
