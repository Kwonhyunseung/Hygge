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
                    <div class="category-filter">
                        <select name="category">
                            <option value="">전체 카테고리</option>
                            <option value="general">일반공지</option>
                            <option value="update">투표</option>
                            <option value="event">이벤트</option>
                        </select>
                    </div>
                    <div class="search-wrapper">
                        <select name="searchType">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                            <option value="titleContent">제목+내용</option>
                        </select>
                        <input type="text" placeholder="검색어를 입력하세요">
                        <button type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
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
                            <tr class="notice-fixed">
                                <td><input type="checkbox" name="selectedItems" value="1"></td>
                                <td>공지</td>
                                <td><span class="category-badge maintenance">점검</span></td>
                                <td class="title">[긴급] 2/15 서버 점검 안내</td>
                                <td>관리자</td>
                                <td>2024-02-07</td>
                                <td>1,234</td>
                                <td><span class="fixed-badge">고정</span></td>
                                <td class="action-buttons">
                                    <button type="button" title="수정"><i class="fas fa-edit"></i></button>
                                    <button type="button" title="삭제"><i class="fas fa-trash"></i></button>
                                    <button type="button" title="고정해제"><i class="fas fa-thumbtack"></i></button>
                                </td>
                            </tr>
                            <!-- 일반 공지 -->
                            <tr>
                                <td><input type="checkbox" name="selectedItems" value="2"></td>
                                <td>45</td>
                                <td><span class="category-badge general">일반</span></td>
                                <td class="title">2월 신규 회원 혜택 안내</td>
                                <td>관리자</td>
                                <td>2024-02-06</td>
                                <td>856</td>
                                <td>-</td>
                                <td class="action-buttons">
                                    <button type="button" title="수정"><i class="fas fa-edit"></i></button>
                                    <button type="button" title="삭제"><i class="fas fa-trash"></i></button>
                                    <button type="button" title="상단고정"><i class="fas fa-thumbtack"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
                    <div class="button-group">
                        <button type="button" class="delete-btn">선택 삭제</button>
                        <button type="button" class="hide-btn">선택 숨김</button>
                    </div>
                    <div class="pagination">
                        <a href="#" class="prev">&lt;</a>
                        <a href="#" class="active">1</a>
                        <a href="#">2</a>
                        <a href="#">3</a>
                        <a href="#">4</a>
                        <a href="#">5</a>
                        <a href="#" class="next">&gt;</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>