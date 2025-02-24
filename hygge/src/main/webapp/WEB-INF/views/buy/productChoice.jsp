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

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/buy/productChoice.css" type="text/css">

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
			<img src="${pageContext.request.contextPath}/dist/images/buy/2.png" alt="온라인 상점 아이콘">
		</h3>
		
		<div class="choicedProduct">
			
			<div class="row mainInfo">
				<div class="col-5 thumbnail">
					<img src="${pageContext.request.contextPath}/uploads/project/perfume_1.jpg">
				</div>
				<div class="col-7 productInfo">
					<h4>상품 정보</h4>
					<br>
					<p class="title">[얼리버드 2] 백설 2개</p>
					<p class="detail" style="margin-left: 30px;">💚 백설 50ml(x1)</p>
					<p class="stock">
						구매 수량
						<span class="stock">2개</span>
					</p>
					<p class="productPrice">
						결제 금액
						<span class="productPrice">1,000,000원</span><!-- 가격*수량 -->
					</p>
				</div>
			</div>
			
			<div class="supporterInfo">
			<h4>서포터 정보</h4>
				<p class="name">
					이름
					<span class="name">김선웅</span>
				</p>
				<p class="email">
					이메일
					<span class="email">abcd@naver.com</span>
				</p>
				<p class="phone">
					핸드폰 번호
					<span class="phone">010-5555-5555</span>
				</p>
			</div>
				
			<div class="deliveryInfo">
			<h4>배송 정보</h4>
				<!-- 디폴트는 자동으로 정보 기입 -->
				<!-- 신규배송지 누를경우, readonly풀리면서 받는사람, 주소 새로 입력하도록 -->
				<input type="button" id="addr" value="신규 배송지 입력" onclick="newAddr();">
				<input type="text" id="receiver" placeholder="받는 사람" readonly>
				<div>
					<input type="text" id="addr1" placeholder="주소" readonly>
					<input type="text" id="postCode" placeholder="우편번호" readonly>
				</div>
				<input type="text" id="addr2" placeholder="상세주소" readonly>
				<input type="text" id="aInfo" placeholder="주문 요청 사항을 입력해주세요(선택)">
			</div>
			
			<div class="coupon">
				<h4>쿠폰</h4>
				<select class="couponSelect">  
				    <option value="c1">쿠폰을 선택해주세요</option>  
				    <option value="c2">첫 구매 배송비 할인</option>  
				    <option value="c3">50,000원 할인</option>
				    <option value="c4">쿠폰 선택 안함</option>
				</select>
			</div>
			
			<div class="col paymentMethod">
				<h4>결제 수단</h4>
				<div>
				    <input id="card" name="payMethod" type="radio" id="card" value="1">
				    <label for="card">카드</label>
				</div>
				<!-- <div>
				    <input id="cash" name="payMethod" type="radio" value="cash">
				    <label for="cash">계좌이체</label>
				</div> -->
			</div>
			
			<div class="finalPayment">
			<h4>결제 금액</h4>
				<p class="productPrice">
					리워드 금액
					<span class="productPrice">1,000,000원</span>
				</p>
				<p class="couponPrice">
					쿠폰 금액
					<span class="couponPrice">50,000원</span>
				</p> 
				<p class="deliveryFee">
					배송비
					<span class="deliveryFee">2,500원</span>	
				</p>
				<hr>
				<p class="totalPrice">
					총 결제 금액
					<span class="totalPrice">949,000원</span>
				</p>
			</div>
			
			<div class="payNote">
				<h4>결제 유의사항</h4>
				<p>예약 결제의 경우 결제 실행일에 결제자 귀책사유(한도초과, 이용정지 등)로 인하여 결제가 실패할 수 있으니, 결제수단이 유효한지 확인해주세요.</p>
				<p>예약 결제 이후, 결제 정보를 변경하려면 마이페이지 > 참여 내역 상세에서 결제 정보를 변경해주세요.</p>
				<p>지금 결제를 한 경우에도 프로젝트가 종료되기 전까지 언제든 결제를 취소할 수 있어요.</p>
			</div>
			
			<div class="payAgree">
			    <h4>약관 동의</h4>
			    <div class="agreeAll">
			        <input type="checkbox" id="agreeAll" required>
			        <label for="agreeAll">결제 진행 필수 동의</label>
			    </div>
			    <hr>
			    <div class="agree">
			        <input type="checkbox" id="agree1" required>
			        <label for="agree1">구매조건, 결제 진행 및 결제 대행 서비스 동의</label>
			    </div>
			    <div class="agree">
			        <input type="checkbox" id="agree2" required>
			        <label for="agree2">개인정보 제3자 제공 동의</label>
			    </div>
			</div>
			
		</div>
		
		<button type="button" class="buyBtn" onclick="two()">결제하기</button>

	</div>

</body>
</html>