<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<title>문의 작성</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<style>
.content-wrapper {
	padding: 20px;
	background-color: #f9f9f9;
}

.container {
	max-width: 700px;
	margin: 50px auto;
	background: white;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border: 1px solid black;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
}

.btn-primary {
	background-color: #82B10C !important;
	border-color: #82B10C !important;
	color: white !important;
}

.btn-primary:hover {
	background-color: #6a9009 !important;
	border-color: #6a9009 !important;
}

.btn-custom {
	width: 100px;
}

label {
	margin-bottom: 20px;
}

.select-wrapper {
	position: relative;
}

.select-wrapper select {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	background-color: white;
	background-image:
		url("data:image/svg+xml;charset=UTF-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2382B10C'%3E%3Cpath d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 10px center;
	background-size: 32px;
	padding-right: 10px;
}
</style>
</head>
<body>



	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="content-wrapper">
		<div class="container">
			<h2>문의 작성</h2>
			<form action="${pageContext.request.contextPath}/inquiry/write"
				method="post">
				<div class="form-group">
					<label for="category">카테고리</label>
					<div class="select-wrapper">
						<select class="form-control" id="category" name="category"
							required>
							<option value="배송">배송</option>
							<option value="상품">상품</option>
							<option value="결제">결제</option>
							<option value="회원">회원</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</div>


				<div class="form-group">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" name="title" required>
				</div>

				<div class="form-group">
					<label for="content">내용</label>
					<textarea class="form-control" id="content" name="content" rows="5"
						required></textarea>
				</div>

				<div class="text-center mt-4">
					<button type="submit" class="btn btn-primary btn-custom"
						style="height: 40px; border-radius: 7px;">등록</button>
					<a href="${pageContext.request.contextPath}/inquiry/list"
						class="btn btn-secondary btn-custom">취소</a>
				</div>
			</form>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>

</body>
</html>

