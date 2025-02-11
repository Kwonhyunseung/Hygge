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
				<option value="userName">제품명</option>
				<option value="sell">판매글</option>
				<option value="buy">구매글</option>
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
		<div class="filter-container all-products">
			<button type="button" class="btn">거래가능한 제품만</button>
			<!-- 중고거래게시판 테이블에 deal 이라는 거래여부 컬럼이 있습니다.
			미거래(0, default), 거래중(1, 거래신청 완료 관리자 승인 대기 중), 거래완료(-1) 각각 괄호 안의 값을 가지도록 참고해주세요
			거래가능한 제품은 미거래, 거래중 상품 필터링으로 하면 좋을것 같습니다.

			전체 제품 서칭할 때엔 'filter-container' 클래스를 갖는 버튼의 상위 div에 'all-products' 클래스가 있도록,
			필터링을 걸면 'filter-products' 클래스가 들어가도록 해주세요 css 반영을 해당 클래스명들에 대해 반영해놓았습니다.
			>> 기본상태 all-products, 버튼 클릭으로 거래가능 제품만 볼 때엔 all-products 클래스가 빠지면서 filter-products 클래스 추가.
			거래가능 제품만 보는 상태를 해제하고 모든 제품을 볼때는 filter-products 클래스가 빠지고 all-products 클래스 추가.
			-->
		</div>
		<table class="table">
			<thead>
				<tr>
					<th width="60">번호</th>
					<th width="60">분류</th>
					<th>제목</th>
					<th width="100">작성자</th>
					<th width="100">작성일</th>
					<th width="70">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list}" varStatus="status">
					<tr>
						<td>${dataCount - (page - 1) * size - status.index}</td>
						<td>
							<c:if test="${dto.category == 0}">판매</c:if>
							<c:if test="${dto.category == 1}">구매</c:if>
						</td>
						<td><a href="${articleUrl}&num=${dto.num}">${dto.title}</a></td>
						<td>${dto.nickName}</td>
						<td>${dto.reg_date}</td>
						<td>${dto.hitCount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="write-btn">
			<button type="button" class="btn" onclick="writeForm();">글 등록하기</button>
		</div>
		<div class="page-navigation">
			${dataCount == 0 ? '등록된 게시글이 없습니다' : paging}
		</div>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>

<script type="text/javascript">
function writeForm() {
	let member = '${sessionScope.member}';
	if (!member || member.trim === '') {
		location.href = '${pageContext.request.contextPath}/member/login';
	}
	location.href = '${pageContext.request.contextPath}/usedBoard/write';
}
</script>
</html>