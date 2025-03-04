<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/qna/list.css">
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
                    <h2>1:1 문의 관리</h2>
                </div>
                <div class="status-summary">
                    <div class="status-item pending">
                        <span class="label">답변 대기</span>
                        <span class="count">${pendingCount}</span>
                    </div>
                    <div class="status-item completed">
                        <span class="label">답변 완료</span>
                        <span class="count">${completedCount}</span>
                    </div>
                    <div class="status-item total">
                        <span class="label">전체 문의</span>
                        <span class="count">${totalCount}</span>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <form name="searchForm" action="${pageContext.request.contextPath}/admin/qna/list" method="get">
                    <div class="filter-section">
                        <div class="filter-group">
                            <select name="category">
                                <option value="0">문의 유형</option>
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.category}" ${category.category == category ? "selected" : ""}>${category.name}</option>
                                </c:forEach>
                            </select>
                            <select name="status">
                                <option value="">처리 상태</option>
                                <option value="pending" ${status=="pending" ? "selected" : ""}>답변 대기</option>
                                <option value="completed" ${status=="completed" ? "selected" : ""}>답변 완료</option>
                            </select>
                            <input type="date" name="startDate" value="${startDate}">
                            <span>~</span>
                            <input type="date" name="endDate" value="${endDate}">
                        </div>
                        <div class="search-wrapper">
                            <select name="schType">
                                <option value="all" ${schType=="all" ? "selected" : ""}>전체</option>
                                <option value="content" ${schType=="content" ? "selected" : ""}>문의내용</option>
                                <option value="writer" ${schType=="writer" ? "selected" : ""}>작성자</option>
                                <option value="answer" ${schType=="answer" ? "selected" : ""}>답변내용</option>
                            </select>
                            <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
                            <button type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>

                <div class="board-container">
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>문의유형</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>문의일시</th>
                                <th>처리상태</th>
                                <th>답변일시</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}" varStatus="status">
                                <tr>
                                    <td>${dataCount - (page-1) * size - status.index}</td>
                                    <td>
                                        <span class="type-badge ${fn:toLowerCase(dto.category_name)}">
                                            ${dto.category_name}
                                        </span>
                                    </td>
                                    <td class="title">
                                        <span class="text">${dto.q_title}</span>
                                    </td>
                                    <td>${dto.nickname}</td>
                                    <td>
                                        <fmt:parseDate value="${dto.q_date}" var="q_date" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <fmt:formatDate value="${q_date}" pattern="yyyy-MM-dd HH:mm" />
                                    </td>
                                    <td>
                                        <span class="status-badge ${dto.answer_status == '미답변' ? 'new' : 'completed'}">
                                            ${dto.answer_status}
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${not empty dto.a_date}">
                                            <fmt:parseDate value="${dto.a_date}" var="a_date" pattern="yyyy-MM-dd HH:mm:ss" />
                                            <fmt:formatDate value="${a_date}" pattern="yyyy-MM-dd HH:mm" />
                                        </c:if>
                                        <c:if test="${empty dto.a_date}">-</c:if>
                                    </td>
                                    <td class="action-buttons">
                                        <c:if test="${dto.answer_status == '미답변'}">
                                            <button type="button" onclick="location.href='answer?num=${dto.num}&page=${page}';" class="answer-btn">
                                                답변하기
                                            </button>
                                        </c:if>
                                        <c:if test="${dto.answer_status != '미답변'}">
                                            <button type="button" onclick="location.href='article?num=${dto.num}&page=${page}';" class="view-btn">
                                                조회
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${dataCount == 0}">
                                <tr>
                                    <td colspan="8" class="empty-list">등록된 문의가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
                    <div class="pagination">
                        ${paging}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    $(function(){
        $("form[name=searchForm]").submit(function(){
            const f = $(this);
            
            const schType = f.find("select[name=schType]").val();
            const kwd = f.find("input[name=kwd]").val().trim();
            if(schType && !kwd) {
                alert("검색어를 입력하세요.");
                f.find("input[name=kwd]").focus();
                return false;
            }
            
            const startDate = f.find("input[name=startDate]").val();
            const endDate = f.find("input[name=endDate]").val();
            if((startDate && !endDate) || (!startDate && endDate)) {
                alert("검색 기간을 시작일과 종료일 모두 입력하세요.");
                return false;
            }
            
            if(startDate && endDate && startDate > endDate) {
                alert("종료일은 시작일 이후 날짜를 선택하세요.");
                return false;
            }
            
            return true;
        });
    });
    </script>
</body>
</html>