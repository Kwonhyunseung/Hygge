<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<div class="container">
	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

	<div class="main-content">
	        <!-- 메인 컨텐츠가 들어갈 자리 -->
	        <%-- <jsp:include page="/WEB-INF/views/admin/${page}.jsp"/> --%> 
	</div>
</div>

<footer>
<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

</body>
</html>