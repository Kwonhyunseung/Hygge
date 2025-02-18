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
<title>구매 내역</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
.content-wrapper {
    padding: 20px;
}

.container {
    max-width: 800px;
    margin: 50px auto 100px auto;
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
}

h2 {
    text-align: center;
    margin-bottom: 1.7rem;
}

.table th {
    background-color: #82B10C !important;
    color: white !important;
    text-align: center;
    vertical-align: middle;
}
.table td {
    text-align: center;
    vertical-align: middle;
}

.btn-details {
    background-color: #82B10C;
    color: white;
    border-radius: 5px;
    padding: 5px 10px;
    text-decoration: none;
}
.btn-details:hover {
    background-color: darkgreen;
    color: white;
}
</style>
</head>

<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="content-wrapper">
        <div class="container">
            <h2 style="margin-bottom: 1rem;">구매 내역</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>날짜</th>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>상태</th>
                        <th>상세 보기</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="payment" items="${paymentList}">
                        <tr>
                            <td><fmt:formatDate value="${payment.payment_date}" pattern="yyyy-MM-dd" /></td>
                            <td>${payment.title}</td>
                            <td><fmt:formatNumber value="${payment.pay_amount}" pattern="#,###원" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${payment.shipping_state == 1}">상품준비</c:when>
                                    <c:when test="${payment.shipping_state == 2}">배송준비</c:when>
                                    <c:when test="${payment.shipping_state == 3}">배송시작</c:when>
                                    <c:when test="${payment.shipping_state == 4}">배송중</c:when>
                                    <c:when test="${payment.shipping_state == 5}">배송완료</c:when>
                                    <c:otherwise>알 수 없음</c:otherwise>
                                </c:choose>
                            </td>
                            <td><a href="#" class="btn btn-details">보기</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">마이페이지로 돌아가기</a>
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
