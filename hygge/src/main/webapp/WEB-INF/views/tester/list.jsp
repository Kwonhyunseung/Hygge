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

        <div class="experience-grid">
            <c:forEach var="item" items="${list}">
                <div class="experience-item">
                    <div class="date-range">
                        <!-- 날짜 형식 변경 -->
                        <fmt:formatDate value="${item.start_date}" pattern="yyyy-MM-dd" /> ~
                        <fmt:formatDate value="${item.end_date}" pattern="yyyy-MM-dd" />
                    </div>
                    <a href="${pageContext.request.contextPath}/tester/testForm/${item.num}">
                        <div class="image-container">
                            <c:choose>
                                <c:when test="${item.thumbnail.endsWith('.jpg') || item.thumbnail.endsWith('.png') || item.thumbnail.endsWith('.jpeg')}">
                                    <img src="/uploads/project/${item.thumbnail}" alt="${item.title}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/uploads/project/${item.thumbnail}.jpg" alt="${item.title}">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <h3 class="item-title">${item.title}</h3>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination">
        ${paging}
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
</body>
</html>