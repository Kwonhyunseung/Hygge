<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vote/list.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

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
            <c:forEach var="item" items="${vote}">
                <div class="event">
                    <span class="period" style="text-align: left;">
                        <fmt:formatDate value="${item.start_date}" pattern="yy.MM.dd"/>
                    </span>
                    <div class="event-img-div">
                        <a href="${pageContext.request.contextPath}/vote/article/${item.vote_num}?page=${page}" class="event-img">
                            <img src="${pageContext.request.contextPath}/uploads/project/${item.thumbnail}">
                        </a>
                    </div>
                    <a href="${pageContext.request.contextPath}/vote/article/${item.vote_num}?page=${page}">${item.title}</a>
                </div>
            </c:forEach>
        </div></div>

<div style="text-align: center; border: 1px solid black;">${paging}</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>