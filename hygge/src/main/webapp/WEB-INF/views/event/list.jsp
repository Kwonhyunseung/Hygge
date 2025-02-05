<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/list.css" type="text/css">
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
	</div>
	<div class="body-container">
	
		<div class="event">
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/article" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<div class="event-content-div">
				<p class="event-title"><a href="#">프라우허 [컵라면 도자기]</a></p>
				<p class="event-content">프라우허 x 에라토, 오직 휘게에서만 만나보세요.</p>
			</div>
		</div>
		<div class="event">
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/article" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<div class="event-content-div">
				<p class="event-title"><a href="#">프라우허 [컵라면 도자기]</a></p>
				<p class="event-content">프라우허 x 에라토, 오직 휘게에서만 만나보세요.</p>
			</div>
		</div>
		<div class="event">
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/article" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<div class="event-content-div">
				<p class="event-title"><a href="#">프라우허 [컵라면 도자기]</a></p>
				<p class="event-content">프라우허 x 에라토, 오직 휘게에서만 만나보세요.</p>
			</div>
		</div>
		<div class="event">
			<div class="event-img-div">
				<a href="${pageContext.request.contextPath}/vote/article" class="event-img">
					<img src="${pageContext.request.contextPath}/dist/images/eventsamplelj.jpg">
				</a>
			</div>
			<div class="event-content-div">
				<p class="event-title"><a href="#">프라우허 [컵라면 도자기]</a></p>
				<p class="event-content">프라우허 x 에라토, 오직 휘게에서만 만나보세요.</p>
			</div>
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