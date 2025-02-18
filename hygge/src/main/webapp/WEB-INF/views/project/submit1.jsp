<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/dist/css/project/layout/header.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<meta charset="UTF-8">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

body {
    background-color: white;
}

.header {
    display: flex;
    align-items: center;
    padding: 15px 20px;
    border-bottom: 1px solid #eee;
}

.logo {
    height: 24px;
}



.main-content {
    max-width: 1000px;
    margin: 0 auto;
    padding: 40px 20px;
}

.project-header {
    display: flex;
    align-items: flex-start;
    margin-bottom: 30px;
    gap: 20px;
}

.project-image {
    width: 100px;
    height: 100px;
    background-color: #f5f5f5;
}

.project-title-container {
    flex-grow: 1;
}

.badge {
    display: inline-block;
    padding: 2px 8px;
    border: 1px solid #FF5733;
    color: #FF5733;
    border-radius: 4px;
    font-size: 12px;
    margin-bottom: 8px;
}

.project-title {
    font-size: 18px;
    font-weight: 500;
}

.section-title {
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
}

.required {
    color: #FF5733;
    margin-left: 4px;
}

.warning-box {
    background-color: #fff2f0;
    border: 1px solid #ffccc7;
    padding: 15px;
    margin-bottom: 20px;
    font-size: 13px;
    color: #333;
}

.warning-box strong {
    display: block;
    margin-bottom: 8px;
    color: #333;
}

.warning-box ul {
    margin-left: 20px;
    margin-top: 8px;
}

.warning-box ul li {
    position: relative;
    padding-left: 12px;
    margin-bottom: 5px;
    color: #666;
}

.warning-box ul li:before {
    content: "•";
    position: absolute;
    left: 0;
    color: #FF5733;
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
    margin-bottom: 30px;
}

.form-section {
    margin-bottom: 30px;
}

.input-field {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.input-field:disabled {
    background-color: #f5f5f5;
    color: #999;
}

.date-section {
    margin-bottom: 15px;
}

.date-section label {
    display: block;
    font-size: 14px;
    margin-bottom: 5px;
    color: #666;
}

.info-text {
    font-size: 13px;
    color: #666;
    margin-bottom: 10px;
}

.amount-info {
    margin-top: 16px;
}

.amount-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
    color: #666;
    font-size: 14px;
    padding: 8px 0;
    border-bottom: 1px solid #eee;
}

.amount-value {
    font-weight: bold;
}

.goal-amount-section {
    margin-bottom: 30px;
}

.amount-description {
    font-size: 13px;
    color: #666;
    margin-bottom: 15px;
}

.expense-example {
    margin-top: 15px;
    margin-bottom: 15px;
    background-color: #fafafa;
    padding: 15px;
    border-radius: 4px;
}

.expense-list {
    list-style-type: none;
    padding-left: 15px;
    margin-top: 10px;
}

.expense-list li {
    color: #666;
    font-size: 13px;
    margin-bottom: 5px;
    position: relative;
    padding-left: 12px;
}

.expense-list li:before {
    content: "•";
    position: absolute;
    left: 0;
    color: #FF5733;
}

textarea.input-field {
    resize: vertical;
    min-height: 150px;
    line-height: 1.5;
    margin-top: 15px;
}

.button-container {
    margin-top: 20px;
    text-align: right;
}

.submit-button {
    background-color: #FF5733;
    color: white;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.2s ease;
}

.submit-button:hover {
    background-color: #ff4019;
}

.submit-button:active {
    background-color: #e64a2e;
}
</style>
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>



    <main class="main-content">

        <form action="/project/save" method="POST" enctype="multipart/form-data">
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

                <input type="text" name="targetAmount" class="input-field" placeholder="500만원 미만의 금액을 입력하세요">
                
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
                <p class="info-text">설정된 일정은 이후 검토와 심의를 거쳐 확정됩니다.</p>
                
                <div class="date-section">
                    <label>시작일</label>
                    <input type="date" name="startDate" class="input-field">
                </div>
                
                <div class="date-section">
                    <label>시작 시간</label>
                    <input type="time" name="startTime" class="input-field">
                </div>
                
                <div class="date-section">
                    <label>종료일</label>
                    <input type="date" name="endDate" class="input-field">
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">예상된 결제 예정</h2>
                <input type="text" class="input-field" value="판매 기간 설정 시 자동 입력됩니다" disabled>
            </div>

            <div class="form-section">
                <h2 class="section-title">대표 사진<span class="required">*</span></h2>
                <input type="file" name="mainImage" class="input-field" accept="image/*">
            </div>

            <div class="form-section">
                <h2 class="section-title">목표 금액을 어떻게 사용할 예정인지 구체적인 지출 항목으로 적어 주세요.</h2>
                <div class="warning-box">
                    <ul>
                        <li>예산은 '제작비'가 아닌 구체적인 '항목'으로 적어 주세요.</li>
                        <li>이번 프로젝트의 실행에 필요한 비용으로만 작성해 주세요.</li>
                        <li>기부, 다음 프로젝트에 사용하기 등은 이번 프로젝트의 예산으로 볼 수 없어요.</li>
                        <li>만일 전체 제작 비용 중 일부만 모금하시는 경우라면, 나머지 제작 비용은 어떻게 마련 예정인지 추가로 작성해 주세요.</li>
                    </ul>
                </div>
                
                <div class="expense-example">
                    <p class="info-text">(예시)</p>
                    <p class="info-text">목표 금액은 아래의 지출 항목으로 사용할 예정입니다.</p>
                    <ul class="expense-list">
                        <li>인건비</li>
                        <li>배송비</li>
                        <li>필수비</li>
                        <li>디자인 의뢰비</li>
                        <li>수수료</li>
                    </ul>
                </div>

                <textarea name="expenseDetails" class="input-field"></textarea>
                
                <div class="button-container">
                    <button type="submit" class="submit-button">저장</button>
                </div>
            </div>
        </form>
    </main>
</body>
</html>