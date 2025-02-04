<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">
.body-container {
	max-width: 400px;
	margin-top: 100px;
}

.login-logo {
	display: block;
	margin: 0 auto 20px;
	width: 150px;
}

.btn-login {
	background-color: #688E26; /* 기본 배경색 */
	color: white;
	border: 1px solid transparent; /* 초기 상태에서 테두리 투명 */
	border-radius: 25px;
	padding: 10px;
	width: 100%;
	transition: color 0.3s ease, border-color 0.3s ease;
}

.btn-kakao {
	background-color: #FEE500; /* 기본 배경색 */
	color: #3C1E1E;
	border: 1px solid transparent; /* 초기 상태에서 테두리 투명 */
	border-radius: 25px;
	padding: 10px;
	width: 100%;
	font-weight: bold;
	transition: color 0.3s ease, border-color 0.3s ease;
}

.text-link {
	text-decoration: none;
	color: #007bff;
}

/* 회원 로그인 버튼 hover */
.btn-login:hover {
	color: black !important;
	border-color: #5C7F00; /* 테두리 색상만 변경 */
	background-color: #688E26; /* 호버 시 배경색 유지 */
}

/* 카카오 로그인 버튼 hover */
.kakao-login:hover {
	color: white !important;
	border-color: #E6C200; /* 테두리 색상만 변경 */
	background-color: #FEE500; /* 호버 시 배경색 유지 */
}

.kakao-login:hover i {
	color: white !important;
}

.text-link {
	text-decoration: none;
	color: #007bff;
	transition: color 0.3s ease;
}

.text-link:hover {
	color: black; /* hover 시 색상 변경 */
}

        }
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container mx-auto">

				<div class="row">
					<div class="col-md-12">
						<div class="border p-4 rounded bg-white"
							style="margin-bottom: 150px;">
							<!-- 로고 -->
							<img
								src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
								class="login-logo" alt="로고">

							<form name="loginForm" action="" method="post" class="row g-3">
								<div class="col-12">
									<input type="text" name="userId"
										class="form-control rounded-pill py-2" placeholder="아이디">
								</div>
								<div class="col-12">
									<input type="password" name="userPwd"
										class="form-control rounded-pill py-2" placeholder="패스워드"
										autocomplete="off">
								</div>
								<div class="col-12 text-start">
									<div class="form-check">
										<input class="form-check-input" type="checkbox"
											id="rememberMe"> <label class="form-check-label"
											for="rememberMe"> 아이디 저장</label>
									</div>
								</div>
								<div class="col-12">
									<button type="button" class="btn btn-login"
										onclick="sendLogin();">회원 로그인</button>
								</div>
								<div class="col-12">
									<button type="button" class="btn btn-kakao kakao-login">
										<i class="bi bi-chat-fill"></i> 카카오로 로그인
									</button>
								</div>
								<div class="col-12 text-center">
									<a href="${pageContext.request.contextPath}/member/idFind"
										class="text-link">아이디 찾기</a> / <a
										href="${pageContext.request.contextPath}/member/pwdFind"
										class="text-link">비밀번호 찾기</a>
								</div>

							</form>
							<hr class="mt-4">
							<div class="col-12 text-center">
								아직 회원이 아니세요? <a
									href="${pageContext.request.contextPath}/member/account"
									class="text-link">회원가입</a>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</main>

	<script type="text/javascript">
		function sendLogin() {
			const f = document.loginForm;
			let str;

			str = f.userId.value.trim();
			if (!str) {
				f.userId.focus();
				return;
			}

			str = f.userPwd.value.trim();
			if (!str) {
				f.userPwd.focus();
				return;
			}

			f.action = '${pageContext.request.contextPath}/member/login';
			f.submit();
		}
	</script>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>
