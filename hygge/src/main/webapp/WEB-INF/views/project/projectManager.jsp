<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.main-container {
	font-family: Arial, sans-serif;
	background: white;
	padding: 20px;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 100px auto 40px;
	padding: 40px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.tabs {
	display: flex;
	border-bottom: 2px solid #FF7F50;
	margin-bottom: 30px;
}

.tab {
	padding: 14px 28px;
	font-size: 20px;
	cursor: pointer;
	border: 1px solid #FF7F50;
	border-bottom: none;
	transition: background 0.3s, color 0.3s;
}

.tab.active {
	background: #FF7F50;
	color: white;
}

.tab:hover {
	background: #FF5733;
	color: white;
}

.filter-buttons {
	display: flex;
	gap: 15px;
	margin-bottom: 30px;
	justify-content: center;
}

.filter-buttons button {
	padding: 12px 18px;
	border: 1px solid #ccc;
	background: white;
	cursor: pointer;
	border-radius: 5px;
	font-size: 16px;
	transition: background 0.3s, color 0.3s;
}

.filter-buttons button.active {
	background: #FF7F50;
	color: white;
}

.filter-buttons button:hover {
	background: #FF5733;
	color: white;
}

.project-list {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 30px;
	width: 100%;
	padding: 20px;
}

.project-card {
	border: 1px solid #ddd;
	border-radius: 10px;
	background: #f9f9f9;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.project-card .top-section {
	position: relative;
	background: #ddd;
	text-align: center;
	height: 250px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.project-card .top-section span {
	color: white;
	background: #FF7F50;
	padding: 5px 10px;
	position: absolute;
	top: 5px;
	left: 5px;
	border-radius: 3px;
	font-size: 12px;
}

.project-card .top-section button {
	position: absolute;
	top: 5px;
	right: 5px;
	background: white;
	border: 1px solid #000;
	padding: 3px 8px;
	cursor: pointer;
	font-size: 12px;
	transition: background 0.3s, color 0.3s;
}

.project-card .top-section button:hover {
	background: #FF5733;
	color: white;
}

.project-card .middle-section {
	text-align: center;
	padding: 20px;
	font-size: 16px;
	font-weight: bold;
}

.project-card .status {
	color: #FF7F50;
	font-size: 14px;
	margin-bottom: 10px;
}

.project-card .bottom-section {
	background: white;
	text-align: center;
	padding: 10px;
	border-top: 1px solid #ddd;
}

.project-card .bottom-section button {
	padding: 8px 15px;
	border: none;
	background: linear-gradient(135deg, #FF7F50, #FF5733);
	color: white;
	font-size: 12px;
	border-radius: 15px;
	cursor: pointer;
	font-weight: bold;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	transition: background 0.3s, transform 0.2s;
}

.project-card .bottom-section button:hover {
	background: linear-gradient(135deg, #FF5733, #FF2E00);
	transform: scale(1.05);
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.pagination button {
	padding: 10px 15px;
	border: 1px solid #ccc;
	background: white;
	cursor: pointer;
	margin: 0 8px;
	border-radius: 5px;
	font-size: 16px;
	transition: background 0.3s, color 0.3s;
}

.pagination button.active {
	background: #FF7F50;
	color: white;
}

.pagination button:hover {
	background: #FF5733;
	color: white;
}
</style>
</head>
<body class="main-container">

<header>
	<div class="header-container">
		<jsp:include page="/WEB-INF/views/project/layout/header.jsp"/>
	</div>
</header>

<div class="container">
	<h2>현승님, 반가워요</h2>

	<div class="tabs">
		<div class="tab active">프로젝트 관리</div>
		<div class="tab">상품 관리</div>
		<div class="tab">게시판</div>
		<div class="tab">1:1 문의</div>
	</div>

	<div class="filter-buttons">
		<button class="active">전체</button>
		<button>심사중</button>
		<button>승인완료</button>
		<button>거절</button>
		<button>진행중</button>
		<button>종료</button>
	</div>

	<div class="project-list">
		<c:forEach var="i" begin="1" end="4">
			<div class="project-card">
				<div class="top-section">
					<span>프로젝트</span>
					<button>삭제</button>
					<p>대표 이미지 등록 필요</p>
				</div>
				<div class="middle-section">
					<p>제목을 입력해주세요.</p>
					<p class="status">작성중</p>
				</div>
				<div class="bottom-section">
					<button>프로젝트 바로가기</button>
				</div>
			</div>
		</c:forEach>
	</div>

	<div class="pagination">
		<button>&lt;</button>
		<button class="active">1</button>
		<button>2</button>
		<button>3</button>
		<button>&gt;</button>
	</div>
</div>
</body>

<footer>
	<div class="footer-container">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</div>
</footer>
</html>
