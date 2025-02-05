<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

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
				2024년 12월 Abandon 프로젝트에 <b>[5점만점 그림N잡 연결 치트키, 누구나 OK! 그림으로 출판하기]</b> (이)가 선정되었습니다.
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