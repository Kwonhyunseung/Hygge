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
function paymentComplete() {
    location.href = "${pageContext.request.contextPath}/";
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
    <c:if test="${not empty product}">
    <p class="title"> 구매상품
        <span class="title">${product.title}</span>
    </p>
    <p class="name"> 이름
        <span class="name">${member.name}</span>
    </p>
    <p class="stock"> 수량
        <span class="stock">${product.amount}개</span>
    </p>

    <p class="home"> 배송지
	    <span class="">
	    ${deliveryInfo.receiver} <!-- 받는 사람 --> <br>
	    (${deliveryInfo.postCode}) ${deliveryInfo.addr1} ${deliveryInfo.addr2}
	    </span>
	</p>
    <p class="price"> 금액
        <span class="price"><fmt:formatNumber value="${product.sum}" pattern="#,###"/>원</span>
    </p>
    <p class="price"> 최종 결제 금액
        <span class="price"><fmt:formatNumber value="${payment.pay_amount}" pattern="#,###"/>원</span>
    </p>
    </c:if>
</div>

		<button type="button" class="buyBtn" onclick="paymentComplete()">메인으로</button>

	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>