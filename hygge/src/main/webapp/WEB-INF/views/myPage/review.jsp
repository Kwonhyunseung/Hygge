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
.rcontainer {
    max-width: 800px;
    margin-top: 50px;
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
    margin-bottom: 50px;
    margin-left: 263px;
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
    <div class="rcontainer">
        <h2 style="margin-bottom: 1.5rem;">상품 후기</h2>

        <c:forEach var="review" items="${reviewList}">
            <div class="review-box">
                <h5>${Review.title}</h5>
                <div class="stars">
                    <c:forEach begin="1" end="${review.grade}" varStatus="status">
                        ★
                    </c:forEach>
                    <c:forEach begin="${review.grade+1}" end="5" varStatus="status">
                        ☆
                    </c:forEach>
                </div>
                <p>${review.content}</p>
                <p class="review-date"><fmt:formatDate value="${review.payment_date}" pattern="yyyy-MM-dd" /></p>
            </div>
        </c:forEach>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">마이페이지로 돌아가기</a>
        </div>
    </div>
</body>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>
