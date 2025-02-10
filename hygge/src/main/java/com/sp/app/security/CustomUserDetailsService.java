package com.sp.app.security;

import java.util.List;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

/*
  - UserDetailsService 인터페이스
  : 스프링 시큐리티에서 사용자 인증을 처리할 때 사용하는 인터페이스
  : 주로 사용자 정보를 db에서 조회하여 인증 및 권한 부여에 필요한 사용자 정보를 제공
  : 사용자가 로그인 할 때 필요한 사용자 정보(Username, password, 권한 등)을 
  	UserDetails 객체로 반환하여 인증 처리 및 권한 검증 진행
  
 */

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
	private final MemberService service;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("=== loadUserByUsername 호출됨 ===");
	    System.out.println("입력된 id: " + username);
	    
		Member dto = service.findById(username); // 나는 db에서 id로 조회 해야한다.
		
		if(dto == null) {
			System.out.println("사용자를 찾을 수 없음");
			throw new UsernameNotFoundException("아이디가 존재하지 않습니다.");
		}
		List<String> authorities = service.listAuthority(username); // 사용자의 권한 목록 조회
		
		 System.out.println("찾은 사용자: " + dto.getId());
		 System.out.println("사용자 권한: " + authorities);
		
		return toUserDetails(dto, authorities);
	}
	
	private UserDetails toUserDetails(Member dto, List<String> authorities) {
		String[] roles = authorities.toArray(new String[authorities.size()]);
		
		return User.builder()
				.username(dto.getId())
				.password(dto.getPwd())
				// .roles("USER", "ADMIN") // ROLE_ 로 시작할 수 없음
				.roles(roles)
				.build();
	}
	
}
