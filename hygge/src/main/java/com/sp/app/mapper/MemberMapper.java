package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Member;

@Mapper
public interface MemberMapper {
	public void insertMember(Member dto) throws SQLException;
	public void insertMaker(Member dto) throws SQLException;
	public void updateMember(Member dto) throws SQLException;
	public void updateMember2(Member dto) throws SQLException;
	public void deleteMember(String email) throws SQLException;
	public void deleteMember2(String email) throws SQLException;
	public void updateLastLogin(String email) throws SQLException;

	public long memberSeq();

	public Member findById(String id);
	public String findAuthority(Map<String, Object> map);
	
	public void insertAuthority(Member dto) throws SQLException;
	public void updateAuthority(Member dto) throws SQLException;
	public List<String> listAuthority(String email);	
	
	public void insertRefreshToken(Member dto) throws SQLException;
	public void updateRefreshToken(Member dto) throws SQLException;
	public void deleteRefreshToken(String email) throws SQLException;
	public Member findByToken(String email);	
}
