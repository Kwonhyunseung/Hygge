<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="vertical_nav" style="position: fixed;">
	<ul id="js-menu" class="menu">
	
		<li class="menu--item">
	        <a href="${pageContext.request.contextPath}/admin" class="menu--link" title="신고된글">
				<i class="menu--icon bi bi-ban"></i>
				<span class="menu--label">신고된 글</span>
			</a>
		</li>
	
		<li class="menu--item menu--item__has_sub_menu">
	        <label class="menu--link" title="회원관리">
				<i class="menu--icon bi bi-person-square"></i>
				<span class="menu--label">회원관리</span>
			</label>
	
			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/player/list" class="sub_menu--link">회원리스트</a>
				</li>
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/player/blind" class="sub_menu--link">Blind Player</a>
				</li>
			</ul>
		</li>
	
		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="게시글 관리">
				<i class="menu--icon bi bi-list-task"></i>
				<span class="menu--label">게시글 관리</span>
			</label>
	
			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/notice/list" class="sub_menu--link">공지사항</a>
				</li>
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/qna/list" class="sub_menu--link">FAQ</a>
				</li>
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/freeboard/list" class="sub_menu--link">자유게시판</a>
				</li>
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin" class="sub_menu--link">분석게시판</a>
				</li>
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/show/list" class="sub_menu--link">자랑게시판</a>
				</li>
			</ul>
		</li>
	
		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="상점관리">
				<i class="menu--icon bi bi-bag"></i>
				<span class="menu--label">상점관리</span>
			</label>
		
			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin" class="sub_menu--link">아이템</a>
				</li>
			</ul>
		</li>
	
		<li class="menu--item">
	        <a href="${pageContext.request.contextPath}/admin" class="menu--link" title="메인화면 설정">
				<i class="menu--icon bi bi-gear-fill"></i>
				<span class="menu--label">메인화면 설정</span>
			</a>
		</li>
	
		<li class="menu--item">
			<a href="${pageContext.request.contextPath}/login/logout" class="menu--link" title="Logout" title="로그아웃">
				<i class="menu--icon bi bi-unlock"></i>
				<span class="menu--label">Logout</span>
			</a>
		</li>
	</ul>
	
	<button id="collapse_menu" class="collapse_menu">
		<i class="collapse_menu--icon bi bi-chevron-left"></i>
		<span class="menu--label">Menu</span>
	</button>	
</nav>