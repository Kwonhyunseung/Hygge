package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {
	private final MemberMapper mapper;
	private final PasswordEncoder bcryptEncoder;
	
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			// 패스워드 암호화
			String encPassword = bcryptEncoder.encode(dto.getPwd());
			dto.setPwd(encPassword);
			
			// 회원정보 저장
			mapper.insertMember(dto);

			// 권한저장
			dto.setAuthority("USER");
			mapper.insertAuthority(dto);
		} catch (Exception e) {
			log.info("insertMember", e);
			throw e;
		}
	}

	@Override
	public Member findById(String id) {
		Member dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findById(id));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById", e);
		}

		return dto;
	}
	
	
	
	
	
	
	@Override
	public void updateLastLogin(String id) throws Exception {
		try {
			mapper.updateLastLogin(id);
		} catch (Exception e) {
			log.info("updateLastLogin", e);
			throw e;
		}
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			/*
			boolean bPwdUpdate = ! isPasswordCheck(dto.getUserId(), dto.getPwd());
			if(bPwdUpdate) {
				// 패스워드가 변경된 경우만 member 테이블의 패스워드 변경
				String encPassword = bcryptEncoder.encode(dto.getPwd());
				dto.setUserPwd(encPassword);
				
				mapper.updateMember(dto);
			}
			*/
			
			String encPassword = bcryptEncoder.encode(dto.getPwd());
			dto.setPwd(encPassword);
			
			mapper.updateMember(dto);
			mapper.updateMember2(dto);
			
		} catch (Exception e) {
			log.info("updateMember", e);
			throw e;
		}
	}

	@Override
	public void deleteMember(String id) throws Exception {
		try {
			mapper.deleteMember2(id);
			mapper.deleteMember(id);
		} catch (Exception e) {
			log.info("deleteMember", e);
			throw e;
		}
	}

	@Override
	public void insertAuthority(Member dto) throws Exception {
		try {
			mapper.insertAuthority(dto);
		} catch (Exception e) {
			log.info("insertAuthority", e);
			throw e;
		}
	}

	@Override
	public void updateAuthority(Member dto) throws Exception {
		try {
			mapper.updateAuthority(dto);
		} catch (Exception e) {
			log.info("updateAuthority", e);
			throw e;
		}
	}

	@Override
	public List<String> listAuthority(String id) {
		List<String> authority = null;
		
		try {
			authority = mapper.listAuthority(id);
		} catch (Exception e) {
			log.info("listAuthority", e);
		}
		
		return authority;
	}
	
	// 일반유저 리스트 찾아오기
	
	@Override
	public void insertRefreshToken(Member dto) throws Exception {
		try {
			mapper.insertRefreshToken(dto);
		} catch (Exception e) {
			log.info("insertRefreshToken", e);
			throw e;
		}
	}
	
	@Override
	public void updateRefreshToken(Member dto) throws Exception {
		try {
			mapper.updateRefreshToken(dto);
		} catch (Exception e) {
			log.info("updateRefreshToken", e);
			throw e;
		}
	}
	
	@Override
	public Member findByToken(String id) {
		Member dto = null;

		try {
			dto = mapper.findByToken(id);
		} catch (Exception e) {
			log.info("findByToken", e);
		}

		return dto;
	}
	
	
	@Override
	public boolean isPasswordCheck(String id, String pwd) {
		Member dto = findById(id);
		if(dto == null) {
			return false;
		}
		
		return bcryptEncoder.matches(pwd, dto.getPwd());
	}

	@Override
	public Member findByEmail(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findAuthority(long id) {
		String authority = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("id", id);
			authority = mapper.findAuthority(map);
		} catch (Exception e) {
			log.info("findAuthority : ", e);
		}
		return authority;
	}
	
}
