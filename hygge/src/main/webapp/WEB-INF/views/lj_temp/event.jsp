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
    background-color: #f9f9f9;
}

/* 제목 스타일 */
.title {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    margin: 20px auto;
}

/* 본문 컨테이너 */
.body-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    padding: 20px;
    max-width: 1200px;
    margin: auto;
}

/* 개별 사진 크기 조절 */
.event img {
    width: 100%; 
    height: 100%;
    object-fit: cover; /* div 크기에 맞게 채우고 초과 부분 자르기 */
}

/* 개별 이벤트 카드 */
.event {
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    padding: 15px;
    text-align: center;
    transition: transform 0.2s ease-in-out;
    position: relative;
    width: 300px; /* 원하는 크기로 설정 */
    height: 200px; /* 원하는 크기로 설정 */
    overflow: hidden; /* 초과 부분 숨기기 */
    border-radius: 10px; /* 둥근 모서리 효과 */
}

.event:hover {
    transform: translateY(-5px);
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

<div class="title">투표선정</div>

<div class="body-container">
	<div class="event">
		<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
	</div>
	<div class="event">
	</div>
	<div class="event">
	</div>
	<div class="event">
	</div>
	<div class="event">
	</div>
	<div class="event">
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>