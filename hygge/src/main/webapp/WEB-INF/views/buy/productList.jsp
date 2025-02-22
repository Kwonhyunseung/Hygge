<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYGGE결제창</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/buy/productList.css" type="text/css">

<script type="text/javascript">
	function one() {
		alert('결제예약으로!');
	}
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<div class="body-container">

		<div class="row tow-circle">
			<div class="col-2 circle">
				<p>리워드<br>선택</p>
			</div>
			<div class="connecting-line" style="width: 63px;"></div>
			<div class="col-2 circle">
				<p>결제<br>예약</p>
			</div>
		</div>

		<h3>
			리워드 선택
			<img src="${pageContext.request.contextPath}/dist/images/buy/1.png" alt="온라인 상점 아이콘">
		</h3>
		
		<div class="listProduct">
			<div class="select-product">
				<p class="price">89,000원</p>
				<p class="title">
					[얼리버드 2] 백설 2개
					<span class="stock">10개 남음</span>
				</p>
				<p class="content">💚 백설 50ml(x1) <br> 💚 백설 50ml(x1)</p>
				<p class="origin">원산지: 한국</p>
				<p class="deliveryDay">배송 일정 : 2025.03.20 ~</p>
				<p class="deliveryFee"><i class="bi bi-truck"></i> 배송비 3,000원</p>
			</div>
			<hr>
			<div class="select-product">
				<p class="price">89,000원</p>
				<p class="title">
					[얼리버드 2] 백설 2개
					<span class="stock">10개 남음</span>
				</p>
				<p class="content">💚 백설 50ml(x1)</p>
				<p class="origin">원산지: 한국</p>
				<p class="deliveryDay">배송 일정 : 2025.03.20 ~</p>
				<p class="deliveryFee"><i class="bi bi-truck"></i> 배송비 3,000원</p>
			</div>
			<hr>
			<div class="select-product">
				<p class="price">89,000원</p>
				<p class="title">
					[얼리버드 2] 백설 2개
					<span class="stock">10개 남음</span>
				</p>
				<p class="content">💚 백설 50ml(x1)</p>
				<p class="origin">원산지: 한국</p>
				<p class="deliveryDay">배송 일정 : 2025.03.20 ~</p>
				<p class="deliveryFee"><i class="bi bi-truck"></i> 배송비 3,000원</p>
			</div>
			<hr>
			
			<!-- !! 상품 선택시, AJAX 처리로 수량 선택하도록 -->
			
		</div>

		<button type="button" class="buyBtn" onclick="one()">다음 단계</button>

	</div>

</body>
</html>