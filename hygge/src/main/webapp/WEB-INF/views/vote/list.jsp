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
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/article" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="${pageContext.request.contextPath}/vote/article" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/result" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="${pageContext.request.contextPath}/vote/result" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="#" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="#" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="#" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="#" class="">이달의 투표(2025.01)</a>
		</div>
		<div class="event">
		<span class="period" style="text-align: left;">25.01.23 - 25.01.31</span>
			<div class="event-img-div">
				<a href="#" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<a href="#" class="">이달의 투표(2025.01)</a>
		</div>
	</div>
</div>

<div style="text-align: center; border: 1px solid black;">페이징처리</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>