<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>펀딩 프로젝트 투표</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/vote/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        
        <div class="main-content">
            <div class="content-header">
                <div class="content-title">
                    <h2>이달의 펀딩 프로젝트 투표</h2>
                    <span class="total-count">총 12개의 프로젝트</span>
                </div>
            </div>

            <div class="filter-section">
                <div class="filter-wrapper">
                    <select name="voteType">
                        <option value="best">이달의 최고 프로젝트</option>
                        <option value="worst">이달의 최악 프로젝트</option>
                    </select>
                    <select name="status">
                        <option value="all">전체 상태</option>
                        <option value="active">진행중</option>
                        <option value="ended">종료</option>
                    </select>
                </div>
            </div>

            <div class="vote-grid">
                <c:forEach var="i" begin="1" end="6">
                    <div class="vote-card">
                        <span class="vote-category">최고의 프로젝트</span>
                        <img src="/dist/images/choco.png" alt="프로젝트 이미지" class="vote-image">
                        <div class="vote-info">
                            <div class="vote-title">친환경 텀블러 제작 프로젝트</div>
                            <div class="vote-period">
                                <i class="far fa-calendar-alt"></i>
                                2024.02.01 - 2024.02.29
                            </div>
                            <div class="vote-stats">
                                <div class="vote-count">
                                    <i class="fas fa-vote-yea"></i>
                                    현재 투표수: 128
                                </div>
                                <span class="vote-status status-active">진행중</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="pagination">
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
            </div>
        </div>
    </div>
</body>
</html>