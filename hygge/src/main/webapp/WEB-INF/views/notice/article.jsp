<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/notice/article.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
</head>

<body>

<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

    <div class="notice-container">
        <div class="notice-header">
            <h1 class="notice-title">HYGGE, 해외카 창구 열리다! 부문 서비스 '해인보우' 출시</h1>
            <div class="notice-date">2023.02.02</div>
        </div>
        
        <div class="notice-content">
            <p>
                - 2023년5월부터 한국 수출 주요 제품 선택적 적용, 한국의 해외유통 서비스 '해인카'<br>
                - 다양한 해외 유통라인의 활용 가능, 납품할 중고 차바이어와의 적극적 교류 동행<br>
                - 중개하는 유통라인을 자유롭게 선택하여 납품바이어와 직접 거래 적극적 납품 강화
            </p>
            <p>
                해인보우는 해외시장의 최적화된 납품처를 제안하고 안정적인 납품협력을 중개하며 품질을 인정하는 우수한 기업을 대상으로 해외 납품 시장의 가치를 상승시킨다. 
                해당 기업의 해외 외자기업의 진입을 용이하게 하기 위해 출시했습니다.
            </p>
        </div>
        
        <div class="image-section">
            <div class="image-container">
                <img src="/dist/images/notice/거인.jpg" alt="">
            </div>
        </div>
        
        <div class="navigation">
            <div class="nav-item">
                <span class="nav-label">이전 글:</span>
                나와 밥 먹을 사람
            </div>
            <div class="nav-item">
                <span class="nav-label">다음 글:</span>
                결제시스25 입니다.
            </div>
        </div>
    </div>
</body>

<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
</body>
</html>