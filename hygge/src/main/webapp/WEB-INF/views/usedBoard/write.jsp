<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/usedBoard/write.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/forms.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>

<div class="body-main">
	<div class="body-title">
		<div class="title">중고게시판 글 등록</div>
	</div>
	<div class="body-container">
		<form action="" name="usedBoardForm" method="post">
			<table class="table table-form">
				<tbody>
					<tr>
						<td width="200">제목</td>
						<td><input type="text" name="title" class="form-control"></td>
					</tr>
					<tr>
						<td>제품명</td>
						<td><input type="text" name="product" class="form-control"></td>
					</tr>
					<tr>
						<td>가격</td>
						<td><input type="text" name="price" class="form-control"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control"></textarea></td>
					</tr>
					<tr>
						<td>파일첨부</td>
						<td><input type="file" name="title" class="form-control"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>