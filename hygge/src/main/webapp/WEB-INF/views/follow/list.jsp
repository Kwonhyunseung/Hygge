<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>팔로잉 메이커</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/following-maker.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="maker-container">
        <!-- 메이커 목록 헤더 -->
        <div class="maker-header">
            <i class="bi bi-heart-fill"></i>
            <h3>팔로잉 메이커</h3>
        </div>

        <!-- 메이커 목록 -->
        <div class="maker-list">
            <!-- 메이커 아이템 1 -->
            <div class="maker-item">
                <div class="maker-banner">
                    <img src="/dist/images/logo.jpg" alt="메이커 배너" class="banner-image">
                    <i class="bi bi-heart-fill heart-icon"></i>
                </div>
                <div class="maker-info">
                    <h4 class="maker-name">카페 바우</h4>
                    <p class="maker-description">신선한 원두로 만드는 프리미엄 커피</p>
                    <div class="maker-stats">
                        <span class="stat-item">
                            <i class="bi bi-box-seam"></i>
                            진행 프로젝트: 3개
                        </span>
                        <span class="stat-item">
                            <i class="bi bi-people"></i>
                            팔로워: 1.2K
                        </span>
                    </div>
                </div>
            </div>

            <!-- 메이커 아이템 2 -->
            <div class="maker-item">
                <div class="maker-banner">
                    <img src="/dist/images/logo.jpg" alt="메이커 배너" class="banner-image">
                    <i class="bi bi-heart-fill heart-icon"></i>
                </div>
                <div class="maker-info">
                    <h4 class="maker-name">그린테크</h4>
                    <p class="maker-description">환경을 생각하는 친환경 제품</p>
                    <div class="maker-stats">
                        <span class="stat-item">
                            <i class="bi bi-box-seam"></i>
                            진행 프로젝트: 5개
                        </span>
                        <span class="stat-item">
                            <i class="bi bi-people"></i>
                            팔로워: 3.4K
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
</body>
</html>