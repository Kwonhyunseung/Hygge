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

<style type="text/css">
.body-container {
	max-width: 1200px; /* 중앙 정렬 및 여백 조절 */
	margin: 0 auto; /* 좌우 여백 균등 */
}

.listProduct {
	max-width: 1150px;
	margin: 0 auto;
}

.tow-circle {
	display: flex;
	justify-content: center;
	margin: 100px 0;
	
	/* 선을 위한 css */
  	align-items: center;
  	position: relative;
  	padding: 30px;
}

.connecting-line {
  position: absolute;
  height: 1px;
  background-color: #333;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100px;
  z-index: 1;
}

.circle {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	background-color: #f8f8f8;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 30px;
	border: 2px solid #eee;
}

.circle p {
	text-align: center;
	font-weight: bold;
	line-height: 1.6;
	font-size: 20px;
	margin-top: 15px;
}

.circle:first-child {
	background-color: #709B04;
	color: white;
	border-color: #fff;
}

.circle:last-child {
	background-color: #F1F1F1;
	border-color: #363636;
}

/* 선물 선택 섹션 */
h3 {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 2px solid #333;
}

h3>img {
	width: 50px;
	height: 50px;
}

/* 1개의 상품 구성 요소 */
.select-product {
	padding: 20px;
	margin-bottom: 15px;
	border-radius: 5px;
}

.select-product .price {
	font-size: 21px;
	font-weight: bold;
	margin: 10px 0;
}

.select-product .title {
	font-size: 21px;
	font-weight: bold;
	margin: 10px 0;
}

.select-product .stock {
	font-size: 16px;
	color: #ED2323;
	border: 1px solid #fff;
	background-color: #FFEEEE;
	border-radius: 3px;
	padding: 4px 7px ;
}

.select-product .origin {
	font-size: 16px;
	color: #2F2F2F;
	border: 1px solid #888888;
	border-radius: 3px;
	padding: 2px 6px ;
}

.select-product .content {
	font-size: 18px;
}

.select-product .deliveryInfo {
	font-size: 18px;
}

hr {
	margin: 25px 0;
	border: 0;
	border-top: 1px solid #666;
}

.buyBtn {
	display: block;
	width: 300px;
	height: 70px;
	margin: 60px auto;
	background-color: #709B04;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 25px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s;
}

.buyBtn:hover {
	background-color: #5B7D05;
}
</style>

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
			<!-- 상품 선택하면 아이콘 바뀌도록. AJAX-JSON 처리시 같이  -->
			<img src="${pageContext.request.contextPath}/dist/images/buy/2.png" alt="온라인 상점 아이콘">
		</h3>
		
		<div class="listProduct">
			<div class="select-product">
				<p class="price">89,000원</p>
				<p class="title">
					[얼리버드 2] 백설 2개
					<span class="stock">10개 남음</span>
					<span class="origin">한국</span>
				</p>
				<p class="content">💚 백설 50ml(x1)</p>
				<p class="deliveryDay">배송 일정 : 2025.03.20 ~</p>
				<p class="deliveryFee"><i class="bi bi-truck"></i> 배송비 3,000원</p>
				<hr>
				<p class="price">89,000원</p>
				<p class="title">
					[얼리버드 2] 백설 2개
					<span class="stock">10개 남음</span>
					<span class="origin">한국</span>
				</p>
				<p class="content">💚 백설 50ml(x1)</p>
				<p class="deliveryDay">배송 일정 : 2025.03.20 ~</p>
				<p class="deliveryFee"><i class="bi bi-truck"></i> 배송비 3,000원</p>
				<hr>
				<p class="price">89,000원</p>
				<p class="title">
					[얼리버드 2] 백설 2개
					<span class="stock">10개 남음</span>
					<span class="origin">한국</span>
				</p>
				<p class="content">💚 백설 50ml(x1)</p>
				<p class="deliveryDay">배송 일정 : 2025.03.20 ~</p>
				<p class="deliveryFee"><i class="bi bi-truck"></i> 배송비 3,000원</p>
				<hr>
			</div>
			
			<!-- !! 상품 선택시, AJAX 처리로 수량 선택하도록 -->
			
		</div>

		<button type="button" class="buyBtn" onclick="one()">다음 단계</button>

	</div>

</body>
</html>