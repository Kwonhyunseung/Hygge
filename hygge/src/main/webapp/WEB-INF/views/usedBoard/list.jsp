<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/usedBoard/list.css" type="text/css">
<script src="${pageContext.request.contextPath}/dist/js/event-list-css/btn-borderstyle-none.js"></script>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style type="text/css">
.table {
	text-align: center;
	width: 1000px !important;
	border-style: none !important;
	font-size: 14px;
}

.search-container {
	width: 800px;
	border: 1px solid #EAEAEA;
	padding: 10px;
}

.schType-container {
	margin: 0px 10px;
}

.schType-select {
	height: 30px;
	padding: 3px;
	border: 1px solid #EAEAEA;
	border-radius: 3px;
}

.kwd-text {
	padding: 3px;
	border: 1px solid #EAEAEA;
	border-radius: 3px;
}

.refresh-btn {
	display: flex;
	justify-content: center;
    align-items: center;
	width: 30px;
	height: 30px;
	border-radius: 15px;
	background-color: #DCEFAD;
}
.refresh-btn:hover {
	background-color: #CCE58C;
}

.write-btn {
	display: flex;
	justify-content: right;
}
</style>

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
		<div class="schType-container">
			<select name="schType" class="schType-select">
				<option value="all">제목+내용</option>
				<option value="userName">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
		</div>
		<div class="kwd-container">
			<input type="text" name="kwd" placeholder="검색어를 입력하세요." style="width: 300px;" class="kwd-text">
		</div>
		<div class="search-btn">
			<button type="button" class="btn" title="검색"><i class="bi bi-search"></i></button>
		</div>
		<div class="refresh-btn">
			<button type="button" class="btn" title="새로고침" onclick="location.href='${pageContext.request.contextPath}/usedBoard/list'"><i class="bi bi-arrow-clockwise"></i></button>
		</div>
	</div>
	<div class="body-container">
		<table class="table">
			<thead>
				<tr>
					<th width="60">번호</th>
					<th>제목</th>
					<th width="100">작성자</th>
					<th width="100">작성일</th>
					<th width="70">조회수</th>
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
				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="#">최신 갤럭시 S4 판매합니다.</a></td>
					<td>멋쟁이선웅</td>
					<td>2025-01-24</td>
					<td>11</td>
				</tr>

			</tbody>
		</table>
		<div class="write-btn">
			<button type="button" class="btn">글 등록하기</button>
		</div>
		<div style="text-align: center; border: 1px solid black;">페이징처리</div>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>