<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/event/list.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>

<div class="body-main">
<div class="body-title">
    <div class="title">이벤트</div>
    <c:if test="${sessionScope.member.authority == 'ADMIN'}">
        <div class="admin-buttons">
            <button type="button" class="btn-add" onclick="location.href='${pageContext.request.contextPath}/admin/event/write';">
                <i class="fas fa-plus"></i> 이벤트 등록
            </button>
        </div>
    </c:if>
</div>
	<div class="body-container">
	<c:forEach var="dto" items="${list}">
		<div class="event">
				<div class="event-img-div">
					<a href="${pageContext.request.contextPath}/event/article/${dto.num}" class="event-img">
						<img src="${pageContext.request.contextPath}/uploads/event/${dto.photo}">
					</a>
				</div>
				<div class="event-content-div">
				    <p class="event-title"><a href="${pageContext.request.contextPath}/event/article/${dto.num}">${dto.title}</a></p>
				    <p class="event-content">${dto.content}</p>
				        <p class="event-period">
				        <span class="event-date-label">이벤트 기간:</span> 
				        <fmt:formatDate value="${dto.evt_date}" pattern="yyyy.MM.dd"/> ~ 
				        <fmt:formatDate value="${dto.exp_date}" pattern="yyyy.MM.dd"/>
				    </p>
				</div>
		</div>
	</c:forEach>
	</div>
</div>

<div class="paging">
    ${paging}
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>