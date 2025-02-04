﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #fff;
}

.container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	border: none; /* 테두리 제거 */
	border-radius: 10px;
}

h2 {
	text-align: center;
	font-size: 2rem;
	font-weight: bold;
	margin-bottom: 20px;
	color: #333;
}

label {
	font-weight: bold;
	font-size: 1rem;
	margin-bottom: 5px;
}

.form-control, .form-select {
	border-radius: 5px;
	border: 1px solid #ccc;
	padding: 8px;
	font-size: 1rem;
}

.btn-check {
	display: inline-block;
	padding: 5px 10px;
	background-color: #b2cc85;
	border: none;
	border-radius: 5px;
	color: #fff;
	cursor: pointer;
}

.btn-check:hover {
	background-color: #9ab370;
}

.category-container label {
	display: inline-block;
	background-color: #e0e0e0;
	padding: 8px 12px;
	border-radius: 5px;
	margin: 5px;
	cursor: pointer;
}

.category-container input:checked+label {
	background-color: #b2cc85;
	color: white;
}

.terms {
	font-size: 0.9rem;
}

.btn-primary {
	background-color: #b2cc85;
	border: none;
	padding: 10px;
	width: 100%;
	font-size: 1.2rem;
	border-radius: 5px;
}

.btn-primary:hover {
	background-color: #9ab370;
}

.btn-secondary {
	background-color: #d6d6d6;
	border: none;
	padding: 10px;
	width: 100%;
	font-size: 1.2rem;
	border-radius: 5px;
}

.btn-secondary:hover {
	background-color: #b5b5b5;
}

.line {
	border-bottom: 2.5px solid #000; /* 원하는 색상 */
	width: 100%;
	margin-top: 3px;
	margin-bottom: 10px;
}
</style>
</head>
<body>

	<div class="container">
		<div class="text-center">
			<img
				src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
				alt="Hygge Logo" width="150">
		</div>

		<h2 class="text-start"
			style="font-size: 20px; margin-top: 30px; margin-bottom: 1px;">
			<i class="bi bi-person-fill"></i> 회원가입
		</h2>

		<div class="line"></div>


		<form id="signupForm">
			<div class="mb-3">
				<label for="username">아이디 *</label>
				<div class="d-flex">
					<input type="text" class="form-control me-2" id="username" required>
					<button type="button" class="btn btn-secondary"
						onclick="checkUsername()">중복확인</button>

				</div>
				<span id="usernameStatus"></span>
				<!-- 아이디 중복 여부 표시 -->
			</div>

			<div class="mb-3">
				<label for="name">이름 *</label> <input type="text"
					class="form-control" id="name" required>
			</div>

			<div class="mb-3">
				<label for="nickname">닉네임 *</label> <input type="text"
					class="form-control" id="nickname" required>
			</div>

			<div class="mb-3">
				<label for="password">비밀번호 *</label> <input type="password"
					class="form-control" id="password" required>
			</div>

			<div class="mb-3">
				<label for="passwordConfirm">비밀번호 확인 *</label> <input
					type="password" class="form-control" id="passwordConfirm" required>
			</div>

			<div class="mb-3">
				<label for="birthdate">생년월일 *</label> <input type="date"
					class="form-control" id="birthdate" required>
			</div>

			<div class="mb-3">
				<label for="phone">전화번호 *</label>
				<div class="d-flex">
					<input type="tel" class="form-control me-2" id="phone1"
						maxlength="3" placeholder="xxx" required> <input
						type="tel" class="form-control me-2" id="phone2" maxlength="4"
						placeholder="xxxx" required> <input type="tel"
						class="form-control" id="phone3" maxlength="4" placeholder="xxxx"
						required>
				</div>
			</div>

			<div class="mb-3">
				<label for="email">이메일 *</label>
				<div class="d-flex">
					<!-- 이메일 앞부분 입력란 -->
					<input type="email" class="form-control me-2" id="emailPrefix"
						placeholder="이메일 앞부분" required>

					<!-- @ 기호 고정 -->
					<span class="me-2" style="line-height: 2.3;">@</span>

					<!-- 도메인 선택 또는 직접 입력란 -->
					<div class="d-flex">
						<select class="form-select me-2" id="emailDomain"
							onchange="updateEmail()">
							<option value="">직접 선택</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.com">daum.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="google.com">google.com</option>
							<option value="custom">직접 입력</option>
						</select> <input type="text" class="form-control" id="customDomain"
							placeholder="직접 입력" style="display: none;"
							onchange="updateEmail()">
					</div>
				</div>
			</div>

			<div class="mb-3">
				<label for="address">주소 *</label>
				<div class="d-flex">
					<input type="text" class="form-control me-2" id="address" required>
					<button type="button" class="btn-check" onclick="findAddress()">주소찾기</button>
				</div>
			</div>

			<div class="mb-3">
				<label>선호 카테고리 *</label>
				<div class="category-container">
					<input type="checkbox" id="cat1" name="category"><label
						for="cat1">가전</label> <input type="checkbox" id="cat2"
						name="category"><label for="cat2">패션</label> <input
						type="checkbox" id="cat3" name="category"><label
						for="cat3">뷰티</label> <input type="checkbox" id="cat4"
						name="category"><label for="cat4">홈·리빙</label> <input
						type="checkbox" id="cat5" name="category"><label
						for="cat5">푸드</label>
				</div>
			</div>

			<div class="mb-3">
				<label>성별 *</label>
				<div>
					<input type="radio" id="male" name="gender" value="남자"> <label
						for="male">남자</label> <input type="radio" id="female"
						name="gender" value="여자"> <label for="female">여자</label>
				</div>
			</div>

			<div class="mb-3 terms">
				<input type="checkbox" required> 이용약관 동의 (필수) <br> <input
					type="checkbox" required> 개인정보 수집 이용 동의 (필수) <br> <input
					type="checkbox"> 무료혜택 및 할인쿠폰 수신 동의 (선택)
			</div>

			<div class="mb-3">
				<button type="submit" class="btn btn-primary">가입하기</button>
			</div>

			<div>
				<button type="reset" class="btn btn-secondary">등록취소</button>
			</div>
		</form>
	</div>

	<script>
		// 아이디 중복 확인 함수
		function checkUsername() {
			const username = document.getElementById('username').value;
			const usernameStatus = document.getElementById('usernameStatus');

			if (username) {
				// 실제 서버 요청을 보내는 로직이 필요함
				// 아래는 임시로 '사용가능' 메시지 처리
				usernameStatus.style.color = '#82B10C';
				usernameStatus.innerText = '사용가능';
			} else {
				usernameStatus.style.color = 'red';
				usernameStatus.innerText = '아이디를 입력해 주세요.';
			}
		}
		<div class="mb-3">
	    <label for="email">이메일 *</label>
	    <div class="d-flex">
	        <!-- 이메일 앞부분 입력란 (길이를 줄여서 균형 맞춤) -->
	        <input type="email" class="form-control me-2" id="emailPrefix" placeholder="이메일 앞부분" style="flex: 2;" required>
	        
	        <!-- @ 기호 고정 -->
	        <span class="me-2" style="line-height: 2.3;">@</span>
	        
	        <!-- 도메인 선택 또는 직접 입력란 -->
	        <div class="d-flex" style="flex: 3;">
	            <select class="form-select me-2" id="emailDomain" onchange="updateEmail()">
	                <option value="">직접 선택</option>
	                <option value="naver.com">naver.com</option>
	                <option value="daum.com">daum.com</option>
	                <option value="hanmail.com">hanmail.com</option>
	                <option value="google.com">google.com</option>
	                <option value="custom">직접 입력</option>
	            </select>
	            <input type="text" class="form-control" id="customDomain" placeholder="직접 입력" style="display:none;" onchange="updateEmail()">
	        </div>
	    </div>
	</div>

		// 주소찾기 버튼 클릭 시 동작
		function findAddress() {
			alert("주소찾기 버튼이 클릭되었습니다. (주소 찾기 로직 추가 필요)");
		}

		// 폼 제출 시 비밀번호 확인
		document.getElementById("signupForm").onsubmit = function(event) {
			const password = document.getElementById('password').value;
			const passwordConfirm = document.getElementById('passwordConfirm').value;

			if (password !== passwordConfirm) {
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				event.preventDefault(); // 폼 제출 방지
			}
		}
	</script>

</body>
</html>
