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
<title>보유 쿠폰</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>

.content-wrapper {
    padding: 20px;
}

.container {
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


    <div class="content-wrapper">
        <div class="container">
            <h2>보유 쿠폰</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>쿠폰명</th>
                        <th>할인율</th>
                        <th>유효 기간</th>
                        <th>사용 가능 여부</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>웰컴 할인</td>
                        <td>10%</td>
                        <td>2025-12-31</td>
                        <td>사용 가능</td>
                    </tr>
                    <tr>
                        <td>특별 프로모션</td>
                        <td>15%</td>
                        <td>2025-06-30</td>
                        <td>사용 가능</td>
                    </tr>
                </tbody>
            </table>
            
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/member/myPage" class="btn btn-secondary">마이페이지로 돌아가기</a>
            </div>
        </div>
    </div>



</body>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>
