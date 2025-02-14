<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/notice/list.css">
    <link rel="stylesheet" href="/dist/css/admin/usedBoard/usedList.css">
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
                    <h2>공지사항 관리</h2>
                    <span class="total-count">총 45개의 공지</span>
                </div>
                <button type="button" class="write-btn" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write';">
                    <i class="fas fa-pen"></i> 공지사항 작성
                </button>
            </div>

            <div class="content-body">
	            <div class="filter-section">
				    <form name="searchForm" action="${pageContext.request.contextPath}/admin/notice/list" method="get">
				        <div class="search-wrapper">
				            <select name="schType">
				                <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
				                <option value="title" ${schType=="title"?"selected":""}>제목</option>
				                <option value="content" ${schType=="content"?"selected":""}>내용</option>
				            </select>
				            <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
				            <button type="submit">
				                <i class="fas fa-search"></i>
				            </button>
				        </div>
				    </form>
				</div>

					
					<div class="board-container">
					    <table>
					        <thead>
					            <tr>
					                <th><input type="checkbox" id="checkAll"></th>
					                <th>번호</th>
					                <th>카테고리</th>
					                <th>제목</th>
					                <th>작성자</th>
					                <th>작성일</th>
					                <th>조회수</th>
					                <th>상단고정</th>
					                <th>관리</th>
					            </tr>
					        </thead>
					        <tbody>
					            <c:forEach var="dto" items="${list}" varStatus="status">
					                <tr>
					                    <td><input type="checkbox" name="selectedItems" value="${dto.num}"></td>
					                    <td>${dataCount - (page-1) * size - status.index}</td>
					                    <td><span class="category-badge general">일반</span></td>
					                    <td class="title">
					                        <a href="${articleUrl}&num=${dto.num}">${dto.title}</a>
					                    </td>
					                    <td>${dto.name}</td>
					                    <td>${dto.regDate}</td>
					                    <td>-</td>
					                    <td class="action-buttons">
					                        <button type="button" title="수정" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}';">
					                            <i class="fas fa-edit"></i>
					                        </button>
					                        <button type="button" title="삭제" onclick="deleteNotice(${dto.num});">
					                            <i class="fas fa-trash"></i>
					                        </button>
					                        <button type="button" title="상단고정">
					                            <i class="fas fa-thumbtack"></i>
					                        </button>
					                    </td>
					                </tr>
					            </c:forEach>
					        </tbody>
					    </table>
					</div>
					
					<div class="content-footer">
					    <div class="button-group">
					        <button type="button" class="delete-btn" onclick="deleteList();">선택 삭제</button>
					    </div>
					    <div class="page-navigation">
					        ${paging}
					    </div>
					</div>
            </div>
        </div>
    </div>
</body>
</html>