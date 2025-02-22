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

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/buy/complete.css" type="text/css">

<script type="text/javascript">
	function three() {
		alert('결제완료~~~');
	}
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<div class="body-container">
		<h3>구매 완료</h3>
		<hr style="border:0; height:4px; margin-bottom: 30px; background: #537300;">
		<div class="row buyInfo">
			<p class="title"> 구매상품
				<span class="title">[얼리버드 2] 백설 2개</span>				
			</p>
			<p class="name"> 이름
				<span class="name">김선웅</span>				
			</p>
			<p class="stock"> 수량
				<span class="stock">2개</span>				
			</p>
			<p class="home"> 배송지
				<span class="">(01234) 서울 월드컵북로 쌍용 2층</span>				
			</p>
			<p class="price"> 금액
				<span class="price">800,000</span>				
			</p>
		</div>

		<button type="button" class="buyBtn" onclick="three()">메인으로</button>

	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>