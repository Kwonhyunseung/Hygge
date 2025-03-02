<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>체험단</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/tester/test.css" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="experience-container">
        <h1 class="page-title">체험단</h1>
        
        <!-- 체험단 그리드 -->
        <div class="experience-grid">
            <!-- 첫 번째 줄 -->
            <div class="experience-item">
                <div class="date-range">2025.01.21 ~ 2025.02.03</div>
                <div class="image-container">
                    <img src="/dist/images/logo.jpg" alt="컬러펀 도자기">
                    <div class="image-text">컬러펀 도자기</div>
                </div>
                <h3 class="item-title">22기 체험단 모집합니다!</h3>
            </div>


        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <a href="#" class="page-link">&lt;</a>
            <a href="#" class="page-link active">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link">3</a>
            <a href="#" class="page-link">4</a>
            <a href="#" class="page-link">&gt;</a>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
</body>
</html>