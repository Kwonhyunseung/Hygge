<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="/dist/css/project/layout/header.css">
<link rel="stylesheet" href="/dist/css/project/layout/nav-item.css">

<style type="text/css">
        .policy-container {
            width: 1000px;
            margin: 0 auto;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        .section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .section-title::after {
            content: "*";
            color: #FF5733;
            margin-left: 2px;
        }

        .input-box {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            min-height: 120px;
            resize: vertical;
            margin-bottom: 20px;
        }

        .policy-list {
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }

        .policy-list ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .policy-list li {
            margin-bottom: 12px;
            line-height: 1.6;
            color: #666;
            font-size: 14px;
            position: relative;
            padding-left: 10px;
        }

        .policy-list li::before {
            content: "•";
            position: absolute;
            left: -2px;
        }

        .notice-box {
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 20px;
            border-radius: 4px;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #666;
        }
</style>
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>
	
	
	<div class="policy-container">
        <div class="section">
            <div class="section-title">프로젝트 정책</div>
            <textarea class="input-box" placeholder="이 프로젝트만의 정책을 기입해주세요."></textarea>
        </div>

        <div class="section">
            <div class="section-title">기본 환불 정책</div>
            <div class="policy-list">
                <ul>
                    <li>아래의 정책 사조건가 귀한 신용장 수 있어요.</li>
                    <li>프로젝트 종료 후 리워드가 발송되기 전까지 '펀딩 취소' 환불</li>
                    <li>명확한 리워드 발송 예정일까지 리워드가 발송되지 않은 경우 리워드 지연 환불</li>
                    <li>리워드 수령에 문제가 발생했을 경우 '수령후 취 리워드 하자' 환불</li>
                    <li>환불 불가 유형 및 기타 환불 규정에 해당하지 않는 경우 '단순 변심' 환불</li>
                    <li>리워드 배송 전 일어 취소된 환불된 건과 리워드 배송 후로 이루 '단순 변심'으로 환불 된 건은 취을 정산 내역 중개수수료에서 제외되어요.</li>
                    <li>리워드 배송 후 이루어 환불 산정 전은 환불 신청서를 확인하고 승인할 수 있어요.</li>
                </ul>
            </div>
        </div>

        <div class="section">
            <div class="section-title">공통 환불 불가 유형</div>
            <div class="policy-list">
                <ul>
                    <li>서포터의 단순변심으로 인한 발송/명품 유형이 리워드롤 수령일 날로부터 7일이 지난 경우</li>
                    <li>서포터의 귀책 사유로 인하여 상품이 멸실∙훼손된 경우 (파손에 버렸을 당하이 콜어있는 경우, 구성품이 누락, 멸실 상품의 포장을 체손된 경우 등)</li>
                    <li>리워드의 사용 또는 소비로 인해 가치 등이 감소한 경우 (전자기기의 전력 연결 등 사용 흔적이 있는 없는 경우, 화장품 사용을 등을 시용된 경우 등)</li>
                    <li>잡지책, CD, DVD, 소프트웨어 등 복제가 가능한 리워드를 개시 및 열람한 경우</li>
                    <li>기타 법령 및 약관에 의해 리워드 반품이 허용되는 경우</li>
                </ul>
            </div>
        </div>

        <div class="section">
            <div class="section-title">리워드 특성상 환불이 불가한 경우</div>
            <div class="policy-list">
                <ul>
                    <li>저권, 도장, 1:1 맞춤 제작 등 주문에 따라 개별적으로 생산되는 리워드인 경우</li>
                    <li>신선/냉동식품, 식품 등 품질이 빠르게 파먹치 따라 리워너가 곤란할 정도로 가치가 떨어지는 리워드인 경우</li>
                    <li>육류품, 환불성 등 이런 에먹어 환불과 리워드의 사용 기간이 임달하에 게만대가 이력품 우우 단, 사용 기 없식 업대 저롭은 에먹가가 호한 나용을 머들난다.</li>
                    <li>우산 티켓(아트쇼트, 페포토 포함) 등 시상화 보추가 보기눌먹어 메이커에게 충대한 피높가 에산되는 경우</li>
                    <li>제작에서 개별적으로 수집되는 게록으로서 단품 호류내용 용망 및 주인 저먹에 보가 등으로 메이커에게 호대한 피높가 에산되는 경우</li>
                    <li>기부/후원 특성으로 상품글급 모집 및 사용하는 펀딩 프로젝트인 경우</li>
                </ul>
            </div>
            <div class="notice-box">
                <div class="checkbox-label">
                    <input type="checkbox" id="policy-check">
                    <label for="policy-check">□ 메이커님의 리워드가 '리워드 특성상 환불이 불가한 경우'에 해당한다면 체크해 주세요.</label>
                </div>
            </div>
        </div>
    </div>
</body>
</html>