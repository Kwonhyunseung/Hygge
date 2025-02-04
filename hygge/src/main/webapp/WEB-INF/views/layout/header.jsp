<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<head>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/layout/header.css" type="text/css"> --%>
<title>hygge</title>
<link rel="icon" href="${pageContext.request.contextPath}/dist/images/hygge_logo.ico" type="image/x-icon">
<style>
.navbar-expand-lg {
	max-width: 1300px;
	margin: 0 auto;
}

.nav-item a {
	color: #000;
	font-weight: 600;
	font-size: 20px;
	margin: 0 10px;
}

.nav-item a:hover {
	color: #82B10C;
}

.nav-item a:active {
	color: #82B10C;
}

.navbar-nav {
	margin-left: 20px;
}

.btn-upload {
	background-color: #4CAF50;
	color: white;
	font-weight: bold;
	border-radius: 20px;
	padding: 5px 15px;
}

.btn-upload:hover {
	background-color: #45A049;
}

.header-right a {
	color: #333;
	font-size: 14px;
	margin: 0 10px;
	text-decoration: none;
}

.header-right a:hover {
	color: #4CAF50;
}

@media ( max-width : 768px) {
	.navbar-brand img {
		width: 60px;
	}
	.nav-item a {
		font-size: 14px;
		margin: 0 5px;
	}
	.btn-upload {
		font-size: 14px;
		padding: 5px 10px;
	}
}

/* 로그인 css */
.logo-container {
	text-align: center;
	margin-bottom: 20px;
}

.logo-img {
	width: auto;
	height: 50px;
}

.form-control {
	margin-bottom: 10px;
}

.btn-primary, .kakao-login {
	border: none;
}

.kakao-login {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 12px;
	background-color: #FEE500;
	border-radius: 10px;
	font-weight: bold;
	cursor: pointer;
}

.spacer {
	height: 10px;
}

.form-control-plaintext {
	text-align: center;
}

.btn-primary, .kakao-login {
	height: 50px;
	border-radius: 10px;
	font-size: 16px;
}

.btn-primary:hover {
	color: black !important;
	border: 1px solid #5C7F00;
}

.kakao-login:hover {
	color: white !important;
	border: 1px solid #E6C200;
}

.kakao-login:hover i {
	color: white !important;
}

.kakao-login i {
	color: black;
	.
	btn-primary
	{
}
</style>
</head>
<header>
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/"> <img
				src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
				style="width: 100px;">
			</a>

			<div class="collapse navbar-collapse">
				<ul class="nav nav-underline">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="#">인기</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="#">신규</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="#">공개예정</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="#">마감임박</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="#">더보기</a></li>
					<%--
					<li class="nav-item dropdown">
						<a class="nav-link" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						더보기 <i class="bi bi-chevron-down" style="font-size: 1.2rem"></i>
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">공지사항</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">이벤트</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">투표</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">체험단</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">중고장터</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">QnA</a></li>
						</ul>
					</li>
					--%>
				</ul>
			</div>

			<div class="header-right d-flex align-items-center">

				<div class="nav-item">
					<a class="nav-link"
						href="${pageContext.request.contextPath}/following">팔로잉</a>
				</div>
				<div class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/alarm">알림</a>
				</div>
				<div class="nav-item">
					<a class="nav-link"
						href="${pageContext.request.contextPath}/wishlist">위시리스트</a>
				</div>
				
				<c:choose>
			        <c:when test="${not empty member}">
			            <span class="nav-link me-2">${member.name}님</span>
			            <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
			        </c:when>
			        <c:otherwise>
			            <a href="javascript:dialogLogin();">로그인</a>
			            <a href="${pageContext.request.contextPath}/member/account">회원가입</a>
			        </c:otherwise>
    			</c:choose>
				
				<a href="${pageContext.request.contextPath}/member/account">회원가입</a>
				<button class="btn btn-upload">프로젝트 올리기</button>
			</div>
		</div>
	</nav>
</header>

<script>
const menuItems = document.querySelectorAll('.nav-link');

menuItems.forEach(item => {
    item.addEventListener('click', () => {
        menuItems.forEach(i => i.classList.remove('active'));
        item.classList.add('active');
    });
});
</script>

<!-- Login Modal -->
<script type="text/javascript">
function dialogLogin() {
	$('form[name=modelLoginForm] input[name=id]').val('');
	$('form[name=modelLoginForm] input[name=pwd]').val('');
	 
	$('#loginModal').modal('show');   
	
	$('form[name=modelLoginForm] input[name=id]').focus();
}

function sendModelLogin() {
	var f = document.modelLoginForm;
	var str;
	
	str = f.id.value;
	if(!str) {
		f.id.focus();
		return;
	}
	
	str = f.pwd.value;
	if(!str) {
		f.pwd.focus();
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/member/login';
	f.submit();
}

$(function(){
	$('#loginModal').on('hide.bs.modal', function() {
		$('button, input, select, textarea').each(function(){
			$(this).blur();
		});
	});
});
</script>

<div class="modal fade" id="loginModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 600px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="login-container">
					<div class="logo-container">
						<img
							src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
							class="logo-img">
					</div>

					<form name="modelLoginForm" action="" method="post">
						<input type="text" name=id class="form-control"
							placeholder="아이디"> 
							<input type="password" name="pwd"
							class="form-control" autocomplete="off" placeholder="패스워드">

						<div class="form-check"
							style="display: flex; align-items: center;">
							<input class="form-check-input" type="checkbox"
								id="rememberMeModel"> <label class="form-check-label"
								for="rememberMeModel" style="margin-left: 8px;">아이디 저장</label>
						</div>

						<button type="button" class="btn btn-primary w-100"
							style="background-color: #75A400; color: white; margin-top: 10px;"
							onclick="sendModelLogin();">회원 로그인</button>

						<button type="button" class="kakao-login w-100 mt-3">
							<i class="bi bi-chat-fill"
								style="font-size: 20px; margin-right: 10px;"></i> 카카오로 로그인
						</button>

						<!-- 여백 추가 -->
						<div class="spacer"></div>

						<p class="form-control-plaintext text-center">
							<a href="#" class="text-decoration-none me-2">패스워드를 잊으셨나요 ?</a>
						</p>
					</form>
					<hr class="mt-3">
					<div>
						<p class="form-control-plaintext">
							아직 회원이 아니세요 ? <a
								href="${pageContext.request.contextPath}/member/account"
								class="text-decoration-none">회원가입</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>