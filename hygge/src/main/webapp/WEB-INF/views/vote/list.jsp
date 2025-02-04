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

.body-main {
	display: flex;
	flex-direction: column;
}

.body-title {
	width: 1000px;
	margin: 20px auto;
}

/* 제목 스타일 */
.title {
    text-align: left;
    font-size: 30px;
    font-weight: bold;
    padding: 20px;
    background-color: #fff;
    border-bottom: 2px solid green;
    max-width: 1000px;
}

/* 본문 컨테이너 */
.body-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 50px;
    padding: 20px 20px 70px;
    max-width: 1200px;
    margin: auto;
}

/* 개별 사진 크기 조절 */
.event img {
    width: 100%;
    height: 100%;
    display: block;
    object-fit: cover; /* div 크기에 맞게 채우고 초과 부분 자르기 */
	transition: all 0.4s linear;
}

/* 개별 이벤트 카드 */
.event {
/*
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
*/
	border-radius: 8px;
	text-align: center;
	padding-bottom: 10px; /* 이미지 아래 여백 추가 */
	background-color: #fff;
	padding: 15px;
	position: relative;
	width: 300px; /* 원하는 크기로 설정 */
	height: 250px; /* 원하는 크기로 설정 */
}

.event-img-div {
	width: 250px;
	height: 200px;
	padding: 0px;
	overflow: hidden; /* 초과 부분 숨기기 */
	display: flex;
    align-content: center;
    justify-content: center;
}

/* 기간 표시 스타일 */
.period {
    display: block;
    font-size: 12px;
    color: #666;
    margin-bottom: 5px; /* 기간과 이미지 사이 간격 */
}

.body-main a:hover {
	color: #82B10C;
}

/* 링크 스타일 */
.event a {
    display: block;
    font-size: 14px;
    color: #333;
    font-weight: bold;
    margin-top: 8px; /* 이미지와 텍스트 사이 간격 */
    text-decoration: none;
}

.event-img:hover {
    transform: scale(1.1);
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .body-container {
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    }
}

@media (max-width: 480px) {
    .title {
        font-size: 20px;
    }

    .body-container {
        grid-template-columns: 1fr;
    }
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>

<div class="body-main">
	<div class="body-title">
		<div class="title">투표</div>
	</div>
	<div class="body-container">
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/article" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="${pageContext.request.contextPath}/vote/article" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/result" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="${pageContext.request.contextPath}/vote/result" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="#" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="#" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="#" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="#" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="#" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="#" class="">이달의 투표(2025.01)</a>
		</div>
	</div>
</div>

<div style="text-align: center; border: 1px solid black;">페이징처리</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>