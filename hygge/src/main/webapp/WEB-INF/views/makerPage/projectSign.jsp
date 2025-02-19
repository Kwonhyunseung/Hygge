<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
<style>
body {
	font-family: Arial, sans-serif;
}

.body-container {
	max-width: 800px;
	margin: auto;
	text-align: center;
	height: 574px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

h2 {
	font-size: 24px;
	font-weight: bold;
}

.button-container {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-top: 20px;
}

.btn-custom {
	background-color: #82B10C;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	transition: background-color 0.3s;
}

.btn-custom:hover {
	color: black !important;
}
</style>
</head>
<body>
<header style="all: unset;">
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

	<main class="body-container">
		<h2>쉽고 빠르게 프로젝트를 신청하실 수 있습니다.</h2>
		<p style="font-size: 18px; color: red; font-weight: bold;">지금 바로
			HYGGE를 통해 프로젝트를 신청해보세요!</p>

		<div class="button-container">
			<a href="${pageContext.request.contextPath}/makerPage/preProjectSubmit" class="btn-custom">프로젝트 시작하기</a> <a href="#"
				class="btn-custom">메이커 가이드</a>
		</div>
	</main>

	<footer style="all: unset;">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>
