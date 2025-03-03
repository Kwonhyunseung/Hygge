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
    
	<style type="text/css">
	.filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.filter-wrapper {
    display: flex;
    gap: 10px;
    align-items: center;
}

.btn-write {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 14px;
    transition: background-color 0.3s;
}

.btn-write:hover {
    background-color: #2980b9;
}

.btn-write i {
    font-size: 14px;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  min-width: 220px;
  outline: none;
  transition: border-color 0.3s;
}

.search-input:focus {
  border-color: #3498db;
  box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.1);
}

.btn-search {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.3s;
  display: flex;
  align-items: center;
  gap: 5px;
}

.btn-search:hover {
  background-color: #2980b9;
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
                    <h2>이달의 펀딩 프로젝트 투표</h2>
                    <span class="total-count">총 12개의 프로젝트</span>
                </div>
            </div>

			<div class="filter-section">
			    <div class="filter-wrapper">
			        <form method="get" action="${pageContext.request.contextPath}/admin/vote/list">
			            <select name="schType">
			                <option value="title">제목</option>
			                <option value="content">내용</option>
			            </select>
			            <select name="status">
			                <option value="all">전체 상태</option>
			                <option value="active">진행중</option>
			                <option value="ended">종료</option>
			            </select>
			            <input class="search-input" type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
			            <button type="submit" class="btn-search">
			                <i class="fas fa-search"></i> 검색
			            </button>
			        </form>
			        
			        <button type="button" class="btn-write" onclick="location.href='${pageContext.request.contextPath}/admin/vote/write';">
			            <i class="fas fa-pen"></i> 글등록
			        </button>
			    </div>
			</div>

			<div class="vote-grid">
			  <c:forEach var="vote" items="${vote}">
			    <div class="vote-card">
			      <span class="vote-category">최악의 프로젝트</span>
			      <img src="${pageContext.request.contextPath}/uploads/project/${vote.thumbnail}" alt="프로젝트 이미지" class="vote-image">
			      <div class="vote-info">
			        <div class="vote-num">${vote.vote_num}</div>
			        <a href="${pageContext.request.contextPath}/vote/article/${vote.vote_num}?page=${page}">${vote.title}</a>
			        <div class="vote-period">
			          <i class="far fa-calendar-alt"></i>
			          <fmt:formatDate value="${vote.start_date}" pattern="yyyy.MM.dd"/>
			        </div>
			        <div class="vote-stats">
			          <div class="vote-count">
			            <i class="fas fa-vote-yea"></i>
			            total: ${vote.vote_count}
			          </div>
			          <span class="vote-status status-active">
			            진행중
			          </span>
			        </div>
			      </div>
			    </div>
			  </c:forEach>
			</div>
            
            <div class="pagination">
            	${paging}
            </div>
        </div>
    </div>
</body>
</html>