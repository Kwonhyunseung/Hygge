<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/dist/css/project/layout/header.css">
<link rel="stylesheet" href="/dist/css/project/submit1.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<meta charset="UTF-8">
<style>

</style>
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>



    <main class="main-content">

        <form method="post" enctype="multipart/form-data">
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

                <input type="text" name="target" class="input-field" placeholder="500만원 미만의 금액을 입력하세요">
                
                <div class="amount-info">
                    <div class="amount-row">
                        <span>목표 금액</span>
                        <span class="amount-value">500,000원</span>
                    </div>
                    <div class="amount-row">
                        <span>최소 목표 금액</span>
                        <span class="amount-value">456,000원</span>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">펀딩 일정<span class="required">*</span></h2>
                <p class="info-text">시작 일자는 승인 일자로부터 일주일 뒤 시작입니다.</p>
                
                <div class="date-section">
                    <label>펀딩기간</label>
                    <input type="text" name="term" class="input-field">
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">예상된 결제 예정</h2>
                <input type="text" class="input-field" value="펀딩 승인 시 자동 입력됩니다" disabled>
            </div>

            <div class="form-section">
                <h2 class="section-title">대표 사진<span class="required">*</span></h2>
                <input type="file" name="thumbnail" class="input-field" accept="image/*">
            </div>

            <div class="form-section">
                <h2 class="section-title">사업자 등록증</h2>
                <p class="info-text">사업자가 등록되어 있을 경우 사업자 등록증을 첨부해주세요.</p>
                <input type="file" name="business" class="input-field">
                <div class="button-container">
                    <button type="button" class="submit-button" onclick="sendNext();">다음</button>
                </div>
            </div>
        </form>
    </main>
<script type="text/javascript">
function sendNext() {
	let value = $('input[name="target"]').val();
	console.log(value);
	if (!value) {
		$('input[name="target"]').focus();
	}
	value = $('input[name="term"]').val();
	if (!value) {
		$('input[name="term"]').focus();
	}
	value = $('input[name="thumbnail"]').val();
	if (!value) {
		$('input[name="thumbnail"]').focus();
	}
}
</script>
</body>
</html>