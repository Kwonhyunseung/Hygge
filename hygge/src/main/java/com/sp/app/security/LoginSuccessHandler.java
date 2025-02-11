package com.sp.app.security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	private String defaultUrl;
	
	@Autowired
	private MemberService service;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
	        Authentication authentication) throws IOException, ServletException {
	    
	    try {
	        String username = authentication.getName();
	        System.out.println("로그인 성공 : " + username);  // 디버깅용 로그
	        
	        // 로그인 날짜 변경
	        service.updateLastLogin(username);
	        
	        // 로그인 정보 (findByEmail -> findById로 변경)
	        Member member = service.findById(username);
	        
	        if (member == null) {
	            System.out.println("회원 정보를 찾을 수 없음");
	            response.sendRedirect("/member/login");
	            return;
	        }
	        
	        // 로그인 정보 세션에 저장
	        SessionInfo info = SessionInfo.builder()
	                .memberidx(member.getMemberIdx())
	                .id(member.getId())
	                .name(member.getName())
	                .authority(member.getAuthority())
	                .build();
	        
	        HttpSession session = request.getSession();
	        session.setAttribute("member", info);
	        
	        System.out.println(info.getMemberidx());
	        System.out.println(info.getId());
	        System.out.println(info.getName());
	        
	        // redirect 설정
	        resultRedirectStrategy(request, response, authentication);
	        
	    } catch (Exception e) {
	        System.out.println("로그인 처리 중 오류: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
	
	protected void resultRedirectStrategy(
			HttpServletRequest request,
			HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		if(savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStrategy.sendRedirect(request, response, targetUrl);
			
		} else {
			redirectStrategy.sendRedirect(request, response, defaultUrl);
		}
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}
	
	
	
}
