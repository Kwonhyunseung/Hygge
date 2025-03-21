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

<script type="text/javascript">
//공개예정 프로젝트 여부 확인
const isComingSoon = function() {
    const today = new Date();
    
    const startDateStr = "${project.start_date}";
    const startDate = new Date(startDateStr.replace(/-/g, '/'));
    
    // 날짜만 비교하기 위해 시간 정보 제거
    const startDateOnly = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());
    const todayOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    
    return startDateOnly > todayOnly;
};

// 프로젝트 후원하기
function supportProject() {
    <c:if test="${empty sessionScope.member}">
        alert("로그인이 필요한 서비스입니다.");
        location.href = "${pageContext.request.contextPath}/member/login";
        return;
    </c:if>
    
    if (isComingSoon()) {
        alert("공개예정인 프로젝트는 후원할 수 없습니다.");
        return;
    }
    
    location.href = "${pageContext.request.contextPath}/buy/productList/${project.num}";
}

// AJAX 함수
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

// 콘텐츠 로드 함수
function loadContent(contentType) {
    let url = '${pageContext.request.contextPath}/funding/';
    let num = '${project.num}';
    let params = {num: num};
    
    url += contentType === 'plan' ? 'plan' : 'review';
    
    ajaxFun(url, "get", params, "html", function(data) {
        $("#content-container").html(data);
    });
}

// 프로젝트 상태 체크 및 UI 업데이트
function checkProjectStatus() {
    const startDateStr = "${project.start_date}";
    const startDate = new Date(startDateStr.replace(/-/g, '/'));
    const now = new Date();
    
    // 날짜만 비교하기 위해 시간 정보 제거
    const startDateOnly = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());
    const todayOnly = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    
    if (startDateOnly > todayOnly) {
        // 공개예정 프로젝트인 경우
        $("#normal-project-info").hide();
        $("#coming-soon-project-info").show();
        $("#normal-buttons-container").hide();
        $("#coming-soon-notice").show();
        $("#normal-title").hide();
        $(".product-img").css("margin-top", "130px");
        
        // 남은 시간 계산 및 표시
        const diffTime = startDateOnly.getTime() - todayOnly.getTime();
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        // 다음 자정까지의 시간 계산 (밀리초)
        const nextMidnight = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
        nextMidnight.setHours(0, 0, 0, 0);
        const timeToMidnight = nextMidnight.getTime() - now.getTime();
        
        // 자정이 지나면 페이지 자동 새로고침
        if (diffDays <= 1) {
            console.log("다음 자정에 새로고침 예약됨: " + (timeToMidnight / 1000) + "초 후");
            setTimeout(function() {
                location.reload();
            }, timeToMidnight + 1000); // 자정 직후 1초 후 새로고침
        }
    } else {
        // 일반 프로젝트인 경우
        $("#normal-project-info").show();
        $("#coming-soon-project-info").hide();
        $("#normal-buttons-container").show();
        $("#coming-soon-notice").hide();
        $("#normal-title").show();
        $(".product-img").css("margin-top", "0");
        
        // 일반 프로젝트일 때는 남은 시간 업데이트
        updateRemainingTime();
    }
}

// 남은 시간 업데이트 함수
function updateRemainingTime() {
    const endDateStr = "${project.end_date}";
    const now = new Date();
    
    // 일반 프로젝트는 종료일까지 남은 시간 계산
    const targetDate = new Date(endDateStr.replace(/-/g, '/'));
    
    // 날짜만 비교하기 위해 시간 정보 제거
    const targetDateOnly = new Date(targetDate.getFullYear(), targetDate.getMonth(), targetDate.getDate());
    const todayOnly = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    
    // 남은 일수 계산
    const diffTime = targetDateOnly.getTime() - todayOnly.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    
    // 남은 일수 표시 업데이트
    const displayElement = $("#period strong");
    if (diffDays > 0) {
        displayElement.text(diffDays);
    } else {
        displayElement.text('0');
    }
}

// 페이지 로드 시 초기화
$(function() {
    $(".f-select").removeClass("active");
    $("#plan").addClass("active");
    loadContent('plan');
    
    // 초기 상태 설정
    checkProjectStatus();
    
    // 1분마다 상태 체크 (자정이 지났는지 확인)
    setInterval(checkProjectStatus, 60000);
    
    // 좋아요 버튼 클릭 이벤트
    $('.like-btn').click(function(){
        if (isComingSoon()) {
            alert("공개예정인 프로젝트는 좋아요를 누를 수 없습니다.");
            return;
        }
        
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
    
    // 프로젝트 계획/후기 탭 클릭 이벤트
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
				<!-- 일반 프로젝트 -->
				<div id="normal-title" class="title">
					<p>${project.name}</p> <!-- 카테고리명 -->
					<h3>${project.title}</h3>
					<!-- 공개예정 프로젝트 -->
                    <c:if test="${startDate.time > currentDate.time}">
                        <div class="coming-soon-badge" style="display: inline-block; background-color: #ff6b6b; color: white; padding: 5px 10px; border-radius: 4px; margin-top: 10px; font-weight: bold;">공개예정</div>
                    </c:if>
				</div>

				<div class="row">
					<div class="col-7 product-img">
						<img src="${pageContext.request.contextPath}${thumbnail}">
					</div>
					<div class="col-5 product-info">
						<!-- 일반 프로젝트 정보 영역 -->
						<div id="normal-project-info" class="first-info">
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
						
						<!-- 공개예정 프로젝트 정보 영역 -->
						<div id="coming-soon-project-info" class="first-info" style="display: none; margin-top: 150px;">
						    <div style="width: 100%; display: flex; align-items: center; margin-bottom: 20px;">
						        <div class="coming-soon-badge" style="margin-right: 10px; margin-bottom: 0;">공개예정</div>
						        <p class="coming-soon-category" style="margin-bottom: 0;">${project.name}</p>
						    </div>
						    <h2 class="coming-soon-title">${project.title}</h2>
						</div>
						
						<hr style="margin: 10px 0 35px 0;">
						<div class="row second-info">
							<div class="col-5">
								<p class="d" id="qainfo">
									<strong>목표 금액</strong>
								</p>
								<p class="d" id="qainfo">
									<strong>펀딩 기간</strong>
								</p>
								<!-- <p class="d">
									<strong>결제</strong>
								</p> -->
								<p class="d" id="qainfo">
									<strong>예상 발송 시작일</strong>
								</p>
							</div>
							<div class="col-7">
								<p class="d" id="qainfo">
									<fmt:formatNumber value="${project.target}" pattern="#,###" />원
								</p>
								<p class="d" id="qainfo">
									<fmt:parseDate value="${project.start_date}"
										pattern="yyyy-MM-dd" var="startDate" />
									<fmt:parseDate value="${project.end_date}" pattern="yyyy-MM-dd"
										var="endDate" />
									<fmt:formatDate value="${startDate}" pattern="yyyy.MM.dd" />
									~
									<fmt:formatDate value="${endDate}" pattern="yyyy.MM.dd" />
								</p>
								<%-- <p class="d">
									목표금액 달성시 <br> <span style="margin-left: 113px;">${project.payment_date}</span>
								</p> --%>
								<p class="d" id="qainfo">
									${project.delivery_info}
									<fmt:formatDate value="${deliveryDate}" pattern="yyyy.MM.dd" />
								</p>
							</div>
						</div>
						<div class="row third-info" style="margin: 23px 0 10px 0;">
							<!-- 공개예정일 -->
							<div id="coming-soon-notice" class="col-12" style="display: none;">
								<div class="coming-soon-notice">
									<p class="coming-soon-text">
										<strong>공개예정일은 <fmt:formatDate value="${startDate}" pattern="yyyy.MM.dd" /> 입니다.</strong>
									</p>
								</div>
							</div>
							
							<!-- 일반 프로젝트 버튼 영역 -->
							<div id="normal-buttons-container" style="display: flex; width: 100%;">
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