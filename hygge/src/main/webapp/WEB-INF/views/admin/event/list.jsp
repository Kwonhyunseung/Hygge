<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/event/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style type="text/css">
    
.write-btn {
    text-decoration: none;
}
    </style>
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
                    <h2>이벤트 관리</h2>
                    <span class="total-count">총 ${dataCount}개의 이벤트</span>
                </div>
				<a href="${pageContext.request.contextPath}/admin/event/write" class="write-btn">
				    <i class="fas fa-plus"></i> 이벤트 등록
				</a>
            </div>

            <div class="filter-section">
                <form name="searchForm" action="" method="get">
                    <div class="search-wrapper">
                        <select name="schType">
                            <option value="all">전체</option>
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" name="kwd" placeholder="검색어를 입력하세요">
                        <button type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

				<div class="event-grid">
				    <c:forEach var="dto" items="${list}">
				        <div class="event-card">
				            <img src="${pageContext.request.contextPath}/uploads/event/${dto.photo}" alt="이벤트 이미지" class="event-image">
				            <div class="event-info">
				                <div class="event-title">
				                	<a href="${pageContext.request.contextPath}/event/article/${dto.num}">${dto.title}</a>
				                </div>
				                <div class="event-date">
				                    <i class="far fa-calendar-alt"></i>
				                    <div class="event-date">
								    <fmt:formatDate value="${dto.evt_date}" pattern="yyyy-MM-dd"/> - 
								    <fmt:formatDate value="${dto.exp_date}" pattern="yyyy-MM-dd"/>
								</div>
				                </div>
				                <div class="event-status">
				                    <span class="status-badge status-active">진행중</span>
				                    <div class="action-buttons">
				                        <button type="button" title="수정">
				                            <i class="fas fa-edit"></i>
				                        </button>
				                        <button type="button" title="삭제">
				                            <i class="fas fa-trash"></i>
				                        </button>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </c:forEach>
				</div>
                
			    <div class="page-navigation">
			        <a class="pagination">1</a>
			    </div>                
            </div>
        </div>
    </div>
</body>
</html>