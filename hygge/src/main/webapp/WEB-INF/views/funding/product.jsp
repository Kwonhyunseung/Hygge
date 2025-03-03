<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/funding/product.css"
	type="text/css">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">
/* 버튼 비활성화 스타일 */
button:disabled {
	opacity: 0.6;
	cursor: not-allowed;
}
</style>

<!-- js 파일 빼기! -->
<script type="text/javascript">
//프로젝트 후원하기
function supportProject() {
    <c:if test="${empty sessionScope.member}">
        alert("로그인이 필요한 서비스입니다.");
        location.href = "${pageContext.request.contextPath}/member/login";
        return;
    </c:if>
    
    location.href = "${pageContext.request.contextPath}/buy/productList/${project.num}";
}

// AJAX 유틸 함수
function ajaxFun(url, method, formData, dataType, fn, file = false) {
    const settings = {
        type: method,
        data: formData,
        dataType: dataType,
        success: function(data) {
            fn(data);
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

// 탭 내용 로드
function loadContent(contentType) {
    let url = '${pageContext.request.contextPath}/funding/';
    let num = '${project.num}';
    let params = {num: num};
    
    url += contentType === 'plan' ? 'plan' : 'review';
    
    ajaxFun(url, "get", params, "html", function(data) {
        $("#content-container").html(data);
    });
}

// 페이지 로드 시 실행
$(function() {
    // Plan 탭 초기 선택
    $(".f-select").removeClass("active");
    $("#plan").addClass("active");
    loadContent('plan');
    
    
    // 공개예정이 아닌 경우에만 좋아요 버튼 활성화
    $('.like-btn').click(function(){
        const $btn = $(this);
        const $i = $btn.find('i');
        const num = $btn.data('num');

        let url = '${pageContext.request.contextPath}/funding/userFundingLiked';
        let params = {
            num: num,
            userLiked: $btn.hasClass('active')
        };

        $.ajax({
            type: 'post',
            url: url,
            data: params,
            dataType: 'json',
            success: function(data) {
                if(data.message) {
                    alert(data.message);
                    if(data.message === '로그인이 필요한 서비스입니다.') {
                        location.href = '${pageContext.request.contextPath}/member/login';
                    }
                    return;
                }

                if(data.state === "true") {
                    if(data.isLiked) {
                        $i.removeClass('bi-suit-heart').addClass('bi-suit-heart-fill');
                        $btn.addClass('active');
                    } else {
                        $i.removeClass('bi-suit-heart-fill').addClass('bi-suit-heart');
                        $btn.removeClass('active');
                    }
                    $('.like-count').text(data.likeCount);
                } else {
                    alert('서버 오류가 발생했습니다.');
                }
            },
            error: function(jqXHR) {
                if(jqXHR.status === 401) {
                    alert('로그인이 필요한 서비스입니다.');
                    location.href = '${pageContext.request.contextPath}/member/login';
                } else {
                    console.error('Error:', jqXHR);
                    alert('서버 오류가 발생했습니다.');
                }
            }
        });
    });
    
    // 탭 클릭 이벤트
    $(document).on("click", ".f-select", function() {
        const contentType = $(this).attr('id');
        
        $(".f-select").removeClass("active");
        $(this).addClass("active");
        
        loadContent(contentType);
    });
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
					<p>${project.name}</p>
					<!-- 카테고리명 -->
					<h3>${project.title}</h3>
				</div>

				<div class="row">
					<div class="col-7 product-img">
						<img src="${pageContext.request.contextPath}${thumbnail}">
					</div>
					<div class="col-5 product-info">
						<div class="first-info">
							<p class="a" style="font-size: 18px;">모인 금액</p>
							<p class="a" id="price">
								<strong><fmt:formatNumber value="${project.total_amount}" pattern="#,###" /></strong>원
								<span class="punding-goal"><fmt:formatNumber value="${project.funding_goal}" pattern="#,###" />% 달성</span>
							</p>
							<p class="b" style="font-size: 18px;">남은 시간</p>
							<p class="b" id="period">
								<strong>${project.remained_date}</strong>일
							</p>
						</div>
						<hr style="margin: 10px 0 40px 0;">
						<div class="row second-info">
							<div class="col-5">
								<p class="d">
									<strong>목표 금액</strong>
								</p>
								<p class="d">
									<strong>펀딩 기간</strong>
								</p>
								<p class="d">
									<strong>결제</strong>
								</p>
								<p class="d" style="margin-top: 50px;">
									<strong>예상 발송 시작일</strong>
								</p>
							</div>
							<div class="col-7">
								<p class="d">
									<fmt:formatNumber value="${project.target}" pattern="#,###" />
									원
								</p>
								<p class="d">
									<fmt:parseDate value="${project.start_date}"
										pattern="yyyy-MM-dd" var="startDate" />
									<fmt:parseDate value="${project.end_date}" pattern="yyyy-MM-dd"
										var="endDate" />
									<fmt:formatDate value="${startDate}" pattern="yyyy.MM.dd" />
									~
									<fmt:formatDate value="${endDate}" pattern="yyyy.MM.dd" />
								</p>
								<p class="d">
									목표금액 달성시 <br> <span style="margin-left: 113px;">${project.payment_date}</span>
								</p>
								<p class="d">
									${project.delivery_info}
									<fmt:formatDate value="${deliveryDate}" pattern="yyyy.MM.dd" />
								</p>
							</div>
						</div>
						<div class="row third-info" style="margin: 23px 0 10px 0;">
							<!-- 좋아요 버튼 부분 -->
							<div class="col-5">
                                <div class="like">
                                    <button type="button" class="like-btn ${isUserLiked ? 'active' : ''}" 
                                            data-num="${project.num}">
                                        <i class="bi ${isUserLiked ? 'bi-suit-heart-fill' : 'bi-suit-heart'}"></i>
                                        <span class="like-count">${likeCount}</span>
                                    </button>
                                </div>
                            </div>

                            <!-- 후원 버튼 부분 -->
                            <div class="col-7">
                                <div class="projectBuyBtn">
                                    <button type="button" id="buyBtn" onclick="supportProject()">
                                        프로젝트 후원하기
                                    </button>
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
						<jsp:include page="/WEB-INF/views/funding/rightSide.jsp" />
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