package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 세션에 저장할 정보(이메일, 이름 등)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SessionInfo {
	private long memberidx;
	private String id;
	private String name;
	private String authority;
}
