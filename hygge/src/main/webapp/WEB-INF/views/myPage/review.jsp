<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<title>상품 후기</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
.container {
    max-width: 800px;
    margin-top: 50px;
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
    margin-bottom: 50px;
}
h2 {
    text-align: center;
    margin-bottom: 20px;
}
.review-box {
    border: 1px solid #ddd;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 15px;
    background-color: #f8f9fa;
}
.review-box h5 {
    margin-bottom: 5px;
    font-weight: bold;
}
.review-box p {
    margin-bottom: 10px;
}
.review-box .review-date {
    font-size: 0.9em;
    color: gray;
}
.stars {
    color: #82B10C;
    font-size: 1.2em;
    margin-bottom: 5px;
}
</style>
</head>
<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<body>
    <div class="container">
        <h2 style="margin-bottom: 1.5rem;">상품 후기</h2>
        
        <div class="review-box">
            <h5>무선 이어폰</h5>
            <div class="stars">★★★★★</div>
            <p>음질도 좋고 배터리도 오래 가요! 추천합니다.</p>
            <p class="review-date">작성일: 2025-02-01</p>
        </div>
        
        <div class="review-box">
            <h5>블루투스 스피커</h5>
            <div class="stars">★★★★☆</div>
            <p>디자인도 예쁘고 음질도 만족스러워요!</p>
            <p class="review-date">작성일: 2025-01-20</p>
        </div>
        
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/member/myPage" class="btn btn-secondary">마이페이지로 돌아가기</a>
        </div>
    </div>
</body>
    <footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>
