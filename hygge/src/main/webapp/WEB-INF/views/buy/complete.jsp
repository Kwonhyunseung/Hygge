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






		<button type="button" class="buyBtn" onclick="three()">메인으로</button>

	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>