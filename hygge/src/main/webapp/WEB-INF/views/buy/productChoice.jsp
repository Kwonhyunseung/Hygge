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

.choicedProduct {
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
  background-color: #363636;
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
	background-color: #F1F1F1;
	border-color: #363636;
}

.circle:last-child {
	background-color: #709B04;
	color: white;
	border-color: #fff;
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

/* choicedProduct */
.thumbnail > img {
	width: 350px;
	height: 350px;
}

.mInfo {
	padding: 70px 0;
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
	function two() {
		alert('결제완료로 이동!!');
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
			리워드 결제
			<img src="${pageContext.request.contextPath}/dist/images/buy/1.png" alt="온라인 상점 아이콘">
		</h3>
		
		<div class="choicedProduct">
			
			<div class="row mainInfo">
				<div class="col-4 thumbnail">
					<img src="${pageContext.request.contextPath}/uploads/project/perfume_1.jpg">
				</div>
				<div class="col-8 mInfo">
					<p class="title">[얼리버드 2] 백설 2개</p>
					<p class="detail" style="margin-left: 30px;">💚 백설 50ml(x1)</p>
					<div class="row m_Info2">
						<div class="col-4 mq_Info">
							<p class="stock">구매 수량</p>
							<p class="coupon">쿠폰</p>
						</div>
						<div class="col-8 ma_Info">
							<p class="stock">2개</p>
							<select name="coupon">
								<option selected> 쿠폰을 선택해주세요.</option>
								<option selected>아무개</option>
								<option selected>아무개2</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row subInfo">
					<h4>결제 금액</h4>
					<div class="col-5 sInfo">
						<div class="col 4 sq_Info">
							<p class="rewardPrice">리워드 금액</p>
							<p class="couponPrice">쿠폰 금액</p> 
							<p class="deliveryFee">배송비</p>
							<p class="totalPrice">총 결제 금액</p>
						</div>
					</div>
					<div class="col 7 sa_Info">
						<p class="rewardPrice">1,000,000원</p> <!-- 가격*수량 -->
						<p class="couponPrice">50,000원</p> 
						<p class="deliveryFee">1,000원</p>
						<p class="totalPrice">953,000원</p>
					</div>
				</div>
			</div>
			
			<div class="userInfo">
				
				
					
			</div>

		</div>

		<button type="button" class="buyBtn" onclick="two()">결제하기</button>

	</div>

</body>
</html>