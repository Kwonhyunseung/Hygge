package com.sp.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import com.sp.app.security.LoginFailureHandler;
import com.sp.app.security.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig {
	
	// SecurityFilterChain : 보안 필터를 체인 형태로 구성
	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		// Security 환경 설정
		
		// ?continue 제거
		HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
		requestCache.setMatchingRequestParameterName(null);
		
		/*
		String[] excludeUri = {"/", "/index.jsp", "/member/login", 
				"/member/member", "/member/complete", "/member/pwdFind"
				, "member/expired", "/member/emailCheck", "/dist/**", "/uploads/photo/**",
				"/favicon.ico"};
		*/
		
		http.cors(Customizer.withDefaults())
        .csrf(AbstractHttpConfigurer::disable)
        .requestCache(request->request.requestCache(requestCache));
    
	    http.cors(Customizer.withDefaults())
	        .csrf(AbstractHttpConfigurer::disable)
	        .authorizeHttpRequests(auth -> auth
	            .requestMatchers("/**").permitAll()
	        );
	    
	    // 로그인 설정 추가
	    http.formLogin(form -> form
	        .loginPage("/member/login")                    // 로그인 페이지 경로
	        .loginProcessingUrl("/member/login")           // 로그인 처리 URL
	        .usernameParameter("id")                 	   // 아이디 파라미터명 (기본값 username을 id로 변경)
	        .passwordParameter("pwd")                      // 비밀번호 파라미터명
	        .successHandler(loginSuccessHandler())         // 로그인 성공 핸들러
	        .failureHandler(loginFailureHandler())         // 로그인 실패 핸들러
	    );
		
		// 권한이 없는 경우
		http.exceptionHandling((exceptionConfig) -> exceptionConfig
				.accessDeniedPage("/member/noAuthorized"));
		
		return http.build();
	}
	
	// BCryptPasswordEncoder : 암호화 클래스, 패스워드 암호화에 특화됨
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	LoginSuccessHandler loginSuccessHandler() {
		LoginSuccessHandler handler = new LoginSuccessHandler();
		handler.setDefaultUrl("/");
		return handler;
	}
	
	@Bean
	LoginFailureHandler loginFailureHandler() {
		LoginFailureHandler handler = new LoginFailureHandler();
		handler.setDefaultFailureUrl("/member/login?login_error");
		return handler;
	}
	
}
