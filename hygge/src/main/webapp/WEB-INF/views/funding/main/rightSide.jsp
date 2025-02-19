<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/funding/main/rightSide.css" type="text/css">

<!-- js 파일 빼기! -->
<script type="text/javascript">
	function makerInquiry() {
		alert("메이커 문의로 이동하기");
	}
	
	function makerFollow() {
		alert("메이커 팔로우로 이동하기");
	}
	
	function complaint() {
		alert("메이커 신고하기로 이동하기");
	}
	
	function productBuy() {
		alert("결제창으로 이동하기");
	}
</script>
</head>

<body>
	<div class="right-container">
		<div class="maker-info">
			<h5>메이커 소개</h5>
			<div class="row">
				<div class="col-2 maker-profile">
					<img src="${pageContext.request.contextPath}/dist/images/funding/right/profile.png">
				</div>
				<div class="col maker-name">
					<p style="margin-top: 10px; font-size: 19px;"><strong>가나다람쥐</strong></p>
					<p style="font-size: 17px;">521명이 팔로우 중</p>
				</div>
			</div>
			<div class="maker-btn">
				<button type="button" class="inquiryBtn" onclick="makerInquiry()"><i class="bi bi-chat-right-dots"></i> 메이커 문의</button>
				<button type="button" class="followBtn" onclick="makerFollow()"><i class="bi bi-suit-heart"></i> 메이커 팔로우</button>
			</div>
		</div>
		
		<div class="maker-complaint">
			<p>⚠️ 프로젝트에 문제가 있나요?
			    <span class="complaint-text" onclick="complaint()">신고하기</span>
			</p>
		</div>
		
		<div class="product-buy">
        <h4>리워드 선택</h4>
	        <div class="product-select">
	            <button type="button" class="buyBtn" onclick="productBuy();">
	                <p><strong>1,000원</strong></p>
	                <p>리워드 선택 없이 후원하기</p>
	            </button>
	        </div>
	
	        <c:forEach var="product" items="${product}">
	            <div class="product-select">
	                <button type="button" class="buyBtn" onclick="productBuy();">
	                    <p><strong>
	                        <fmt:formatNumber value="${product.price}" pattern="#,###" />원
	                    </strong></p>
	                    <p class="composition">${product.title}</p>
	                    <div class="option">
	                        <c:forEach var="detailLine" items="${fn:split(product.detail, '💚')}">
	                            <c:if test="${!empty detailLine}">
	                                <p>💚${detailLine}</p>
	                            </c:if>
	                        </c:forEach>
	                    </div>
	                </button>
	            </div>
	        </c:forEach>
    	</div>
	</div>
</body>