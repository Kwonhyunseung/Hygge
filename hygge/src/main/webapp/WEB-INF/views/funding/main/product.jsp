<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYGGEProduct</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/funding/main/product.css" type="text/css">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<!-- js 파일 빼기! -->
<script type="text/javascript">
// 프로젝트 후원하기
function supportProject(){
	alert("결제창으로 이동하기");
}

//
$(document).ready(function() {
	loadContent('plan');
});

$(document).ready(function() {
    $(".f-select").removeClass("active");
    $("#plan").addClass("active");

    loadContent('plan');
});

// 프로젝트계획 | 후기 선택시 밑줄 유지
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.f-select').forEach(tab => {
        tab.addEventListener('click', () => {
            // 모든 탭에서 'active' 제거
            document.querySelectorAll('.f-select').forEach(t => t.classList.remove('active'));

            tab.classList.add('active');
        });
    });
});

// AJAX 정의
function ajaxFun(url, method, formData, dataType, fn, file = false) {
    const settings = {
        type: method,
        data: formData,
        dataType: dataType,
        success: function(data) {
            fn(data);
        },
        beforeSend: function(jqXHR) {
        },
        complete: function() {
        },
        error: function(jqXHR) {
            console.log(jqXHR.responseText);
        }
    };

    if(file) {
        settings.processData = false;
        settings.contentType = false;
    }

    $.ajax(url, settings);
}

function loadContent(contentType) {
    let url = "/funding/";
    url += contentType === 'plan' ? 'plan' : 'review';

    ajaxFun(url, "get", null, "html", function(data) {
        $("#content-container").html(data);
    });
}

$(document).on("click", ".f-select", function() {
    const contentType = $(this).attr('id'); // plan 또는 review
    
    $(".f-select").removeClass("active");
    $(this).addClass("active");
    
    loadContent(contentType);
});
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>
	
	<main>
		<div class="main-container">
		
			<div class="product-main">
				<div class="title">
					<p>${funding.category}</p>
					<h3>${funding.title}</h3>
				</div>
				
				<div class="row">
					<div class="col-7 product-img">
						<img src="/dist/images/funding/main/perfume.jpg">
					</div>
					<div class="col-5 product-info">
						<div class="first-info">
							<p class="a" style="font-size: 18px;">모인 금액</p>
							<p class="a" id="price"><strong>17,350,000</strong>원
								<span class="punding-goal">357% 달성</span>
							</p>
							<p class="b" style="font-size: 18px;">남은 시간</p>
							<p class="b" id="period"><strong>5</strong>일</p>
						</div>
						<hr style="margin: 10px 0 40px 0;">
						<div class="row second-info">
								<div class="col-5">
									<p class="d"><strong>목표 금액</strong></p>
									<p class="d"><strong>펀딩 기간</strong></p>
									<p class="d"><strong>결제</strong></p>
									<p class="d" style="margin-top: 49px;"><strong>예상 발송 시작일</strong></p>
								</div>
								<div class="col-7">
									<p class="d">${funding.target}원</p>
									<p class="d">2025.01.19 ~ 2025.02.02</p>
									<p class="d">목표금액 달성시 <br>&nbsp;&nbsp; 2025.02.03에 결제 진행</p>
									<p class="d">${funding.delivery_info}</p>
								</div>
						</div>
						<div class="row third-info" style="margin: 23px 0 10px 0;">
							<div class="col-5">
								<div class="like">
									<i class="bi bi-suit-heart"></i>
									<p>500</p> <!-- 좋아요 수 -->
								</div>
							</div>
							<div class="col-7">
								<div class="projectBuyBtn">
									<button type="button" id="buyBtn" onclick="supportProject()">프로젝트 후원하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<hr style="margin: 80px 0 1px 0;">
			
			<div class="product-content">
				<div class="row select">
				    <div class="col-2 f-select active" id="plan">
				        <p>프로젝트 계획</p>
				    </div>
				    <div class="col-2 f-select" id="review">
				        <p>후기</p>
				    </div>
				</div>
				<hr style="margin-top: 3px;">
				<div class="row">
					<div class="col-7" id="content-container">
				        <!-- AJAX -->
				    </div>
				    
				    <div class="col-5 right-sidebar">
				    	<jsp:include page="/WEB-INF/views/funding/main/rightSide.jsp"/>
				    </div>
				</div>
			</div>
			
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>

</body>
</html>