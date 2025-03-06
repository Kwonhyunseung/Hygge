<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 - HYGGE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<style type="text/css">
@charset "UTF-8";

.page-title {
    font-weight: 700;
    position: relative;
    display: inline-block;
    margin-bottom: 35px;;
}

.page-title:after {
    content: "";
    position: absolute;
    bottom: -8px;
    left: 0;
    width: 1175px;
    height: 4px;
    background-color: #5E8400;
    border-radius: 2px;
}

.notice-item {
    border-bottom: 1px solid #e9ecef;
    padding: 1.25rem 0.75rem;
    transition: all 0.2s ease;
}

.notice-item:hover {
    background-color: #f8f9fa;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
}

.notice-item-content {
    position: relative;
}

.notice-title {
    font-size: 1.1rem;
    font-weight: bold;
    color: #343a40;
    margin-bottom: 4rem;
    display: block;
}

.notice-title:hover {
    color: #5E8400;
    text-decoration: none;
}

.notice-date {
    color: #868e96;
    font-size: 0.85rem;
    display: flex;
    align-items: center;
}

.notice-date i {
    margin-right: 6px;
    font-size: 0.9rem;
}

.notice-image {
    border-radius: 6px;
    overflow: hidden;
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    height: 120px;
    width: 100%;
    max-width: 200px;
    margin-left: auto;
}

.notice-image:hover {
    transform: scale(1.03);
    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
}

.notice-image img {
    object-fit: cover;
    height: 100%;
    width: 100%;
}

.important-notice {
    position: relative;
    background-color: #dc3545;
    color: white;
    font-size: 0.8rem;
    font-weight: 600;
    padding: 4px 12px;
    border-radius: 20px;
    display: inline-flex;
    align-items: center;
    margin-right: 8px;
    box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
    animation: pulse 1.5s infinite;
}

.search-container {
    background-color: #f8f9fa;
    padding: 1.25rem;
    border-radius: 8px;
    margin-bottom: 2rem;
    box-shadow: 0 2px 10px rgba(0,0,0,0.03);
    border: 1px solid #e9ecef;
}

.search-input {
    border: 1px solid #ced4da;
    border-radius: 0 4px 4px 0 !important;
    transition: border-color 0.2s;
    height: 46px;
}

.search-select {
    border: 1px solid #ced4da;
    border-radius: 4px 0 0 4px !important;
    background-color: white;
    height: 46px;
}

.search-button {
    background-color: #5E8400;
    color: white;
    border: none;
    transition: all 0.2s;
    height: 46px;
    font-weight: 500;
}

.search-button:hover {
    background-color: #4c6c00;
    transform: translateY(-1px);
}


.pagination .active .page-link {
    background-color: #5E8400;
    border-color: #5E8400;
}

.notice-empty {
    text-align: center;
    padding: 3rem;
    color: #868e96;
    background-color: #f8f9fa;
    border-radius: 8px;
    margin: 2rem 0;
}

.notice-count {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
}

.notice-count span {
    font-weight: 600;
    color: #5E8400;
    margin: 0 5px;
}

.notice-card {
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 12px rgba(0,0,0,0.06);
    border: 1px solid #e9ecef;
}

.notice-separator {
    height: 1px;
    background-color: #e9ecef;
    margin: 0;
}

@keyframes pulse {
    0% {
        opacity: 0.8;
    }
    50% {
        opacity: 1;
    }
    100% {
        opacity: 0.8;
    }
}

a {
	text-decoration: none;
}

.container {
    max-width: 1300px !important; /* 기본 컨테이너 너비를 줄임 */
}

</style>
</head>
<body>

<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<div class="container py-5">
    <h1 class="page-title">공지사항</h1>
    
    <!-- 검색 폼 -->
    <div class="search-container">
        <form action="/notice/list" method="GET">
            <div class="row g-2">
                <div class="col-md-10">
                    <div class="input-group">
                        <select name="schType" class="form-select search-select" style="max-width: 150px;">
                            <option value="all" ${schType == 'all' ? 'selected' : ''}>제목+내용</option>
                            <option value="title" ${schType == 'title' ? 'selected' : ''}>제목</option>
                            <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
                        </select>
                        <input type="text" name="kwd" class="form-control search-input" 
                            placeholder="검색어를 입력해 주세요." 
                            value="${kwd}">
                    </div>
                </div>
                <div class="col-md-2">
                    <button class="btn search-button w-100" type="submit">
                        <i class="bi bi-search me-1"></i> 검색
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    
    
    <!-- 리스트 상단 정보 -->
    <div class="notice-count mb-3">
        <i class="bi bi-info-circle me-1"></i>
        전체 <span>${dataCount}</span>건의 공지사항이 있습니다.
    </div>

    <!-- 공지사항 목록 -->
    <div class="notice-card">
        <div class="list-group list-group-flush">
            <c:if test="${empty list}">
                <div class="notice-empty">
                    <i class="bi bi-info-circle me-2"></i> 등록된 공지사항이 없습니다.
                </div>
            </c:if>
            
            <c:forEach var="notice" items="${list}" varStatus="status">
                <div class="notice-item">
                    <c:choose>
                        <%-- 사진이 있는 경우 --%>
                        <c:when test="${not empty notice.s_FileName}">
                            <div class="row g-3 align-items-center">
                                <div class="col-md-9">
                                    <div class="notice-item-content">
                                        <a href="/notice/article/${notice.num}?${query}" class="notice-title">
                                            ${notice.title}
                                            <%--
                                            <c:if test="${notice.regDate.time >= java.lang.System.currentTimeMillis() - (1000*60*60*24*3)}">
                                                <span class="important-notice">NEW</span>
                                            </c:if>
                                             --%>
                                        </a>
                                        <div class="notice-date">
                                            <i class="bi bi-calendar3"></i>
                                            <fmt:formatDate value="${notice.regDate}" pattern="yyyy.MM.dd"/>
                                            <span class="ms-3 text-muted">작성자: ${notice.name}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="notice-image">
                                    
                                        <img src="/uploads/notice/${notice.s_FileName}" alt="${notice.title}" class="img-fluid">
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        
                        <%-- 사진이 없는 경우 --%>
                        <c:otherwise>
                            <div class="notice-item-content">
                                <a href="/notice/article/${notice.num}?${query}" class="notice-title">
                                    ${notice.title}
                                    <%-- 
                                    <c:if test="${notice.regDate.time >= java.lang.System.currentTimeMillis() - (1000*60*60*24*3)}">
                                        <span class="important-notice">NEW</span>
                                    </c:if>
                                    --%>
                                </a>
                                <div class="notice-date">
                                    <i class="bi bi-calendar3"></i>
                                    <fmt:formatDate value="${notice.regDate}" pattern="yyyy.MM.dd"/>
                                    <span class="ms-3 text-muted">작성자: ${notice.name}</span>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${!status.last}">
                    <hr class="notice-separator m-0">
                </c:if>
            </c:forEach>
        </div>
    </div>
    
    <!-- 페이징 -->
    <nav class="mt-4 d-flex justify-content-center">
    <ul class="pagination">
        ${paging}
    </ul>
</nav>
        
</div>

<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

</body>
</html>