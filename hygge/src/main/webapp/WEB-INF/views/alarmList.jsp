<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>알림</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/alarm.css" type="text/css">
</head>

<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="notification-container">
        <!-- 알림 헤더 -->
        <div class="notification-header">
            <i class="bi bi-bell-fill"></i>
            <h3>알림</h3>
        </div>

        <!-- 댓글 알림 예시 -->
        <div class="new-notification comment-notification">
            <div class="notification-item">
                <div class="notification-title">
                    <i class="bi bi-chat-dots-fill notification-icon"></i>
                    <span>댓글 알림</span>
                </div>
                <span class="notification-date">방금 전</span>
            </div>
            <div class="notification-content">
                <p class="notification-message">홍길동님이 회원님의 "아이폰 14 Pro 판매합니다" 게시글에 댓글을 달았습니다.</p>
            </div>
        </div>

        <!-- 팔로잉 알림 예시 -->
        <div class="new-notification following-notification">
            <div class="notification-item">
                <div class="notification-title">
                    <i class="bi bi-person-plus-fill notification-icon"></i>
                    <span>메이커 알림</span>
                </div>
                <span class="notification-date">1시간 전</span>
            </div>
            <div class="notification-content">
                <p class="notification-message">김철수님이 새 펀딩 프로젝트를 시작하셨습니다. "각질 제거 이젠 안녕~"</p>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>