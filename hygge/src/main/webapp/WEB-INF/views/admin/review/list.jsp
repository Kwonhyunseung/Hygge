<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/review/reviewList.css">
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
                <h2>후기 관리</h2>
                <span class="total-count">총 1230개의 후기</span>
            </div>

            <div class="content-body">
                <div class="filter-section">
                    <div class="category-filter">
                        <select name="mainCategory">
                            <option value="">대분류 선택</option>
                            <option value="electronics">가전</option>
                            <option value="fashion">패션</option>
                            <option value="furniture">가구</option>
                        </select>
                        <select name="subCategory">
                            <option value="">소분류 선택</option>
                            <option value="refrigerator">냉장고</option>
                            <option value="shoes">신발</option>
                            <option value="desk">책상</option>
                        </select>
                    </div>
                    <div class="status-filter">
                        <select name="status">
                            <option value="">상태 전체</option>
                            <option value="active">정상</option>
                            <option value="blocked">차단</option>
                            <option value="tempBlocked">임시차단</option>
                            <option value="rejected">거절</option>
                        </select>
                    </div>
                    <div class="search-wrapper">
                        <input type="text" placeholder="닉네임 검색">
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
                                <th>상품명</th>
                                <th>닉네임</th>
                                <th>후기내용</th>
                                <th>등록일</th>
                                <th>신고수</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="selectedItems" value="1"></td>
                                <td>15</td>
                                <td>가전 > 냉장고</td>
                                <td>삼성 비스포크 냉장고</td>
                                <td>쿨러마스터</td>
                                <td class="review-content">배송도 빠르고 품질도 좋아요...</td>
                                <td>2024-02-07</td>
                                <td class="report-count">0</td>
                                <td><span class="status-badge status-active">정상</span></td>
                                <td class="action-buttons">
                                    <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
                                    <button type="button" title="임시차단"><i class="fas fa-clock"></i></button>
                                    <button type="button" title="영구차단"><i class="fas fa-ban"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><input type="checkbox" name="selectedItems" value="2"></td>
                                <td>14</td>
                                <td>패션 > 신발</td>
                                <td>나이키 에어맥스</td>
                                <td>신발왕</td>
                                <td class="review-content">가품인 것 같습니다. 품질이...</td>
                                <td>2024-02-07</td>
                                <td class="report-count warning">5</td>
                                <td><span class="status-badge status-blocked">차단</span></td>
                                <td class="action-buttons">
                                    <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
                                    <button type="button" title="차단해제"><i class="fas fa-unlock"></i></button>
                                </td>
                            </tr>
                            <!-- 추가 더미 데이터 -->
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
                    <div class="button-group">
                        <button type="button">선택 삭제</button>
                        <button type="button">선택 차단</button>
                        <button type="button">선택 임시차단</button>
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