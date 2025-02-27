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
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>

.ccontent-wrapper {
    padding: 20px;
}

.ccontainer {
    max-width: 800px;
    margin: 50px auto;
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

.table thead {
    background-color: #82B10C;
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
</style>
</head>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
<body>

    <div class="ccontent-wrapper">
        <div class="ccontainer">
            <h2>보유 쿠폰</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>쿠폰명</th>
                        <th>할인율</th>
                        <th>발급날짜</th>
                        <th>만기일</th>
                        <th>사용여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="coupon" items="${listCoupon}">
                        <tr>
                            <td>${coupon.coupon_Name}</td>
                            <td>${coupon.discount_Rate.intValue()}%</td> 
                            <td>${coupon.issue_Date}</td>
                            <td style="color: red;">${coupon.exp_date}</td>
                            <td>${coupon.used_Date != null ? coupon.used_Date : '미사용'}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">마이페이지로 돌아가기</a>
            </div>
        </div>
    </div>


</body>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>
