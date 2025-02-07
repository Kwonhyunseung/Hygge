<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/main.css"
	type="text/css">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">
.main-container{
	max-width: 1200px;
	margin: 0 auto;
}



</style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="main-container">
		
			<div class="product-main">
			
				<div class="title">
					<p>향수</p>
					<h3>스노우볼 속에 담긴 고요한 폭설의 향</h3>
				</div>
				
				<div class="row">
					<div class="col-7 product-img">
						<img src="">
					</div>
					<div class="col-5 product-info">
						<div class="first-info">
							<p class="a">모인 금액</p>
							<p class="b"><strong>17,350,000</strong>원</p>
							<div class="punding-goal">357% 달성</div>
							<p class="a">남은 시간</p>
							<p class="b"><strong>5</strong>일</p>
							<p class="a">후원자</p>
							<p class="b"><strong>257</strong>명</p>
						</div>
						<hr>
						<div class="row second-info">
								<div class="col-5">
									<p>목표 금액</p>
									<p>펀딩 기간</p>
									<p>결제</p>
									<p>예상 발송 시작일</p>
								</div>
								<div class="col-7">
									<p>5,000,000원</p>
									<p>2025.01.19 ~ 2025.02.02</p>
									<p>목표금액 달성시 2025.02.03에 결제 진행</p>
									<p>2025.03.31</p>
								</div>
						</div>
						<div class="row third-info">
							<div class="col-5">
								<div class="like">
									<i class="bi bi-suit-heart"></i>
									<p>500</p> <!-- 좋아요 수 -->
								</div>
							</div>
							<div class="col-7">
								<div class="pBtn">
									<button type="button" onclick="">프로젝트 후원하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<hr>
				
				<div class=""
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>

</body>
</html>