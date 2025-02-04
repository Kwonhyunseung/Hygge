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
	    // ?continue 제거
	    HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
	    requestCache.setMatchingRequestParameterName(null);
	    
	    http
	        .cors(Customizer.withDefaults())
	        .csrf(AbstractHttpConfigurer::disable)
	        .requestCache(request -> request.requestCache(requestCache))
	        .authorizeHttpRequests(auth -> auth
	            .requestMatchers(
	                "/",                    // 메인 페이지
	                "/main",               // 메인 페이지 alternate
	                "/index",              // 메인 페이지 alternate
	                "/index.jsp",          // JSP 메인 페이지
	                "/member/login",        // 로그인
	                "/member/account",      // 회원가입
	                "/dist/**",            // 정적 리소스
	                "/uploads/photo/**",    // 업로드된 사진
	                "/favicon.ico"          // 파비콘
	            ).permitAll()
	            
	            .requestMatchers(
	                "/following/**",
	                "/alarm/**",
	                "/wishlist/**",
	                "/mypage/**"
	            ).authenticated()
	            .requestMatchers("/admin/**").hasRole("ADMIN")
	            .anyRequest().permitAll()    // 다른 모든 요청은 허용
	        )
	        .formLogin(form -> form
	            .loginPage("/member/login")
	            .loginProcessingUrl("/member/login")
	            .usernameParameter("id")
	            .passwordParameter("pwd")
	            .successHandler(loginSuccessHandler())
	            .failureHandler(loginFailureHandler())
	        )
	        .logout(logout -> logout
	            .logoutUrl("/member/logout")
	            .logoutSuccessUrl("/")
	            .invalidateHttpSession(true)
	            .deleteCookies("JSESSIONID")
	            .clearAuthentication(true)
	        )
	        .exceptionHandling(exception -> exception
	            .accessDeniedPage("/member/noAuthorized")
	        );
	    
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
