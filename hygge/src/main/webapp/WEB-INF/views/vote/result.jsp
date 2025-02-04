<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
/* 전체 스타일 */
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #fff;
}

/* 링크 스타일 */
.body-main a {
    color: #333;
    font-size: 16px;
    margin-top: 8px; /* 이미지와 텍스트 사이 간격 */
    text-decoration: none;
}

.body-main a:hover {
	color: #82B10C;
}

/* 제목 스타일 */
.title {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
    border: 1px solid green;
    max-width: 800px;
    margin: 40px auto;
}

/* 본문 컨테이너 */
.body-container {
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 50px;
    padding: 20px;
    max-width: 1200px;
    margin: auto;
    flex-direction: row;
    justify-content: center;
}

.body-main {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
    max-width: 800px;
    margin: auto;
}

.body-content { margin: 0px !important; border-bottom: 1px solid green; }

.img-container {
	margin: auto;
	max-height: 400px;
	max-width: 500px;
}

.img-container img {
	width: 100%;
	height: 100%;
}

.body-content {
	margin: 20px auto;
}

.vote-title {
	margin: 10px;
	text-align: center;
	font-weight: bold;
}

.vote-detail {
	text-align: left;
	margin: 20px auto;
}

.body-footer {
	height: 80px;
    width: 100%; /* 부모 요소 기준 전체 너비 */
    margin-top: 20px;
    padding-left: 20px; /* 왼쪽 여백 추가 */
    padding: 10px;
}

.body-footer .footer-next { padding: 10px; border-bottom: 1px solid gray; width: 100% }
.body-footer .footer-prev { padding: 10px; }

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>


<div class="body-container">
	<div class="title">2024년 12월 투표 발표</div>
	<div class="body-main">
		<div class="body-content">
			<div class="img-container">
				<img src="${pageContext.request.contextPath}/dist/images/main/ad3.png">
			</div>
			<div class="vote-title">
				5점만점 그림N잡 연결 치트키, 누구나 OK! 그림으로 출판하기
			</div>
			<div class="vote-detail">
				2024년 12월 슬픔의 프로젝트에 <b>[5점만점 그림N잡 연결 치트키, 누구나 OK! 그림으로 출판하기]</b> (이)가 선정되었습니다.
				<br>
				휘게와 함께 프로젝트에 도전해주심에 감사하며, 더 좋은 프로젝트로 다시 뵙길 바라겠습니다😊
			</div>
		</div>
		<table class="body-footer">
			<tr style="width: 100%; border-bottom: 1px solid #E1E1E1;">
				<td style="width: 20%">다음 글 </td>
				<td><a href="#">2025년 1월 투표(투표 중)</a></td>
			</tr>
			<tr>
				<td>이전 글 </td>
				<td><a href="#">2024년 11월 투표(투표 완료)</a></td>
			</tr>
		</table>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>