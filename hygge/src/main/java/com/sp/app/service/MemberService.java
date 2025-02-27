package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Member;

public interface MemberService {
	public void insertMember(Member dto) throws Exception;
	
	public void updateLastLogin(String email) throws Exception;
	public void updateMember(Member dto) throws Exception;
	
	public Member findById(String id);
	public Member findByEmail(String email);
	public String findAuthority(long id);

	public void deleteMember(String email) throws Exception;
	
	public void insertAuthority(Member dto) throws Exception;
	public void updateAuthority(Member dto) throws Exception;
	public List<String> listAuthority(String id);
	
	public void insertRefreshToken(Member dto) throws Exception;
	public void updateRefreshToken(Member dto) throws Exception;
	public Member findByToken(String email);
	
	public boolean isPasswordCheck(String id, String pwd);

}
