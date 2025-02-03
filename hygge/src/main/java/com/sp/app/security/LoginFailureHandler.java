package com.sp.app.security;

import java.io.IOException;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginFailureHandler implements AuthenticationFailureHandler {
	private String defaultFailureUrl;
	
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String msg = "이메일 또는 패스워드가 일치하지 않습니다.";
		
		try {
			if(exception instanceof BadCredentialsException) {
				// 패스워드가 일치하지 않는 경우
				
			} else if(exception instanceof InternalAuthenticationServiceException) {
				// 존재하지 않는 이메일인 경우
				
			} else if(exception instanceof DisabledException) {
				// 인증거부 - 계정이 비활성화 된 경우
			}
			
		} catch (Exception e) {
			log.info("LoginFailureHandler : " + msg , e);
		}
		
		response.sendRedirect(defaultFailureUrl);
		
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

}
