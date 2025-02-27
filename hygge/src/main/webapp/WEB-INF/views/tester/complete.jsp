<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험단 신청 완료</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<style>
.completion-container {
	max-width: 600px;
	margin: 100px auto;
	text-align: center;
	padding: 30px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.success-icon {
	font-size: 72px;
	color: #82B10C;
	margin-bottom: 20px;
}

.completion-title {
	font-size: 24px;
	margin-bottom: 15px;
	color: #333;
}

.completion-message {
	font-size: 16px;
	color: #666;
	margin-bottom: 30px;
	line-height: 1.5;
}

.home-button {
	display: inline-block;
	padding: 12px 30px;
	background-color: #82B10C;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	font-size: 16px;
	transition: background-color 0.2s;
}

.home-button:hover {
	background-color: #729a0b;
}

.completion-info {
	margin-top: 30px;
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 4px;
	text-align: left;
}

.completion-info h3 {
	margin-top: 0;
	margin-bottom: 15px;
	font-size: 18px;
	color: #333;
}

.completion-info p {
	margin-bottom: 10px;
	color: #666;
	line-height: 1.5;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="completion-container">
		<div class="success-icon">✓</div>
		<h1 class="completion-title">${title}</h1>
		<p class="completion-message">${message}</p>

		<div class="completion-info">
			<h3>체험단 신청 안내</h3>
			<p>- 체험단 심사는 3~5일 정도 소요됩니다.</p>
			<p>- 심사 결과는 신청 시 입력하신 연락처로 알려드립니다.</p>
			<p>- 체험단으로 선정 시 추가 안내가 제공됩니다.</p>
			<p>- 자세한 문의사항은 고객센터로 연락주세요.</p>
		</div>

		<a href="${pageContext.request.contextPath}/tester/list"
			class="home-button">체험단 목록으로</a>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>
</body>
</html>