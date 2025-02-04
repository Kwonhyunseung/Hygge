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

a {
	text-decoration: none;
}

/* 제목 스타일 */
.title {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
    border: 1px solid green;
    max-width: 400px;
    margin: 40px auto;
}

/* 본문 컨테이너 */
.body-container {
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 50px;
    padding: 20px 20px 70px;
    max-width: 1200px;
    margin: auto;
    flex-direction: row;
    justify-content: center;
}

.body-main {
	display: flex;
	align-items: center;
	justify-content: center;
}

.img-container {
	max-height: 400px;
	max-width: 500px;
}

.img-container img {
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>


<div class="body-container">
	<div class="title">투표발표</div>
	<div class="body-main">
		<div class="img-container">
			<img src="${pageContext.request.contextPath}/dist/images/main/ad3.png">
		</div>
	</div>
	<div>
		<div>
			다음글:
			<a href="#">2025년 1월 투표 발표</a>
		</div>
		<div>
			이전글:
			<a href="#">2024년 11월 투표 발표</a>
		</div>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>