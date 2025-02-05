<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/usedBoard/list.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>

<div class="body-main">
	<div class="body-title">
		<div class="title">중고게시판</div>
	</div>
	<div class="search-container">
		<select>
			<option value="all">제목+내용</option>
			<option></option>
			<option></option>
			<option></option>
			<option></option>
		</select>
		<input type="text">
		<button type="button">검색</button>
	</div>
	<div class="body-container">
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>

			</tbody>
		</table>
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