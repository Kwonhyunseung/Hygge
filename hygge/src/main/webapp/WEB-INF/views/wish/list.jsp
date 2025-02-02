<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 위시리스트</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/wishlist.css" type="text/css">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="wishlist-container">
        <!-- 위시리스트 헤더 -->
        <div class="wishlist-header">
            <i class="bi bi-heart-fill"></i>
            <h3>내 위시리스트</h3>
        </div>

        <!-- 위시리스트 아이템 -->
        <div class="wishlist-items">
            <!-- 상품 1 -->
            <div class="wishlist-item">
                <div class="item-image-container">
                    <img src="/dist/images/choco.png" alt="초콜릿 이미지" class="item-image">
                    <i class="bi bi-heart-fill heart-icon"></i>
                </div>
                <div class="item-info">
                    <h4>[헤테제과] 절대 먹지마세요 | 요에스 맥세이프 보조배터리</h4>
                    <div class="price-info">
                        <span class="percentage">7,594%</span>
                        <span class="price">50,000원</span>
                    </div>
                </div>
                <button class="purchase-btn">구매하기</button>
            </div>

            <!-- 상품 2 -->
            <div class="wishlist-item">
                <div class="item-image-container">
                    <img src="/dist/images/choco.png" alt="초콜릿 이미지" class="item-image">
                    <i class="bi bi-heart-fill heart-icon"></i>
                </div>
                <div class="item-info">
                    <h4>상품명</h4>
                    <div class="funding-status">
                        <span class="percentage">7,594%</span>
                        <span class="price">50,000원</span>
                    </div>
                </div>
                <button class="purchase-btn">구매하기</button>
            </div>

            <!-- 상품 3 (동일한 구조 반복) -->
            <div class="wishlist-item">
                <div class="item-image-container">
                    <img src="/dist/images/choco.png" alt="초콜릿 이미지" class="item-image">
                    <i class="bi bi-heart-fill heart-icon"></i>
                </div>
                <div class="item-info">
                    <h4>상품명</h4>
                    <div class="funding-status">
                        <span class="percentage">7,594%</span>
                        <span class="price">50,000원</span>
                    </div>
                </div>
                <button class="purchase-btn">구매하기</button>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
</body>
</html>