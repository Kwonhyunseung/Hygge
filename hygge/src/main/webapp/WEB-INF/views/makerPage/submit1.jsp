<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/dist/css/project/layout/header.css">
<link rel="stylesheet" href="/dist/css/project/submit1.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<meta charset="UTF-8">
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>



    <main class="main-content">

        <form name="submit1" method="post" enctype="multipart/form-data">
            <div class="goal-amount-section">
                <h2 class="section-title">목표 금액<span class="required">*</span></h2>
                <p class="amount-description">프로젝트를 완수하기 위해 필요한 금액을 설정해주세요.</p>
                
                <div class="warning-box">
                    <strong>목표 금액 설정시 꼭 알아두세요!</strong>
                    <ul>
                        <li>후원액까지만 목표금액을 달성하지 못하면 후원자 결제가 진행되지 않습니다.</li>
                        <li>후원 취소 및 결제 누락을 대비해 10% 이상 초과 달성을 목표로 해주세요.</li>
                        <li>저작권료, 선물 배송비, 인건비, 예비 비용 등을 꼼꼼히 고려해 주세요.</li>
                    </ul>
                </div>

                <input type="text" name="target" class="input-field" placeholder="500만원 미만의 금액을 입력하세요" value="${funding.target}">
                <!-- <div class="amount-info">
                    <div class="amount-row">
                        <span>목표 금액</span>
                        <span class="amount-value">500,000원</span>
                    </div>
                    <div class="amount-row">
                        <span>최소 목표 금액</span>
                        <span class="amount-value">456,000원</span>
                    </div>
                </div> -->
            </div>

            <div class="form-section">
                <h2 class="section-title">펀딩 일정<span class="required">*</span></h2>
                <p class="info-text">시작 일자는 승인 일자로부터 일주일 뒤 시작입니다.</p>
                
                <div class="date-section">
                    <label>펀딩기간</label>
                    <input type="text" name="term" class="input-field" value="${funding.term}">
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">예상된 결제 예정</h2>
                <input type="text" class="input-field" value="펀딩 승인 시 자동 입력됩니다" disabled>
            </div>

            <div class="form-section">
                <h2 class="section-title">썸네일 등록<span class="required">*</span></h2>
                <div class="thumbnail-container">
                <c:choose>
                	<c:when test="${not empty funding.thumbnail}">
                		<div class="thumbnail-img-container" style="width: 100px; height: 76px; border: 1px solid #E6E6E6; cursor: pointer;">
                			<img src="${pageContext.request.contextPath}/uploads/project/${funding.thumbnail}" style="width: 100%; height: 100%;">
                		</div>
                	</c:when>
                	<c:otherwise>
		                <input type="file" name="thumbnail_File" class="input-field" accept="image/*">
                	</c:otherwise>
                </c:choose>
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">사업자 등록증</h2>
                <p class="info-text">사업자가 등록되어 있을 경우 사업자 등록증을 첨부해주세요.</p>
                <div style="padding: 5px 0px; display: flex; flex-direction: row;">
	                <input type="checkbox" name="isBusiness" id="isBusiness" style="padding: 5px;" ${funding.business == 1 ? 'checked' : ''}><label for="isBusiness"><span style="margin-left: 5px; margin-bottom: 0px;" class="section-title">사업자 등록이 되어있으신가요?</span></label>
                </div>
	            <input type="file" name="business_File" class="input-field" value="${funding.business_File}" style="display: none;">
                <div class="button-container">
                    <button type="button" class="submit-button" onclick="sendNext();">다음</button>
                </div>
            </div>
            <input type="hidden" value="${funding.business}" name="business">
            <input type="hidden" value="${funding.thumbnail}">
        </form>
    </main>
<script type="text/javascript">
function sendNext() {
	const f = document.submit1;
	/*
	let value = f.target.value;
	if (!value) {
		f.target.focus();
		return false;
	}
	value = $('input[name="term"]').val();
	if (!value) {
		$('input[name="term"]').focus();
		return false;
	}
	value = $('input[name="thumbnail_File"]').val();
	if (!value) {
		$('input[name="thumbnail_File"]').focus();
		return false;
	}
	*/
	if ($('input[name="isBusiness"]').is(':checked')) {
		f.business.value = 1;
	} else {
		f.business.value = 0;
	}
	f.action = '${pageContext.request.contextPath}/makerPage/projectSubmit1';
	f.submit();
}

$(function() {
	if ($('input[name="isBusiness"]').is(':checked')) {
		$('input[name="business_File"]').css('display', 'block');
	}
	
	$('input[name="isBusiness"]').change(function() {
		if ($(this).is(':checked')) {
			$('input[name="business_File"]').slideDown(300);
		} else {
			$('input[name="business_File"]').slideUp(300);
		}
	});

	$('.thumbnail-img-container').click(function() {
		if (!confirm('기존에 올리신 썸네일 이미지를 삭제하시겠습니까?')) {
			return false;
		}
		let url = '${pageContext.request.contextPath}/makerPage/deleteThumbnail';
		let fileName = '${funding.thumbnail}';
		let params = {fileName: fileName};
		let thumbnail = $('.thumbnail-container');
		const fn = function(data) {
			thumbnail.html('<input type="file" name="thumbnail_File" class="input-field" accept="image/*" value="${funding.thumbnail}">');
		}

		ajaxRequest(url, 'post', params, 'json', fn);
	});
});
</script>
</body>
</html>