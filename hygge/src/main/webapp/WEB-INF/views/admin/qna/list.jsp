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
                    <div class="status-item new">
                        <span class="label">신규 문의</span>
                        <span class="count">12</span>
                    </div>
                    <div class="status-item pending">
                        <span class="label">답변 대기</span>
                        <span class="count">25</span>
                    </div>
                    <div class="status-item completed">
                        <span class="label">답변 완료</span>
                        <span class="count">158</span>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <div class="filter-section">
                    <div class="filter-group">
                        <select name="inquiryType">
                            <option value="">문의 유형</option>
                            <option value="account">계정 문의</option>
                            <option value="payment">결제 문의</option>
                            <option value="product">상품 문의</option>
                            <option value="delivery">배송 문의</option>
                            <option value="refund">환불 문의</option>
                            <option value="other">기타 문의</option>
                        </select>
                        <select name="status">
                            <option value="">처리 상태</option>
                            <option value="new">신규</option>
                            <option value="pending">답변 대기</option>
                            <option value="completed">답변 완료</option>
                        </select>
                        <input type="date" name="startDate">
                        <span>~</span>
                        <input type="date" name="endDate">
                    </div>
                    <div class="search-wrapper">
                        <select name="searchType">
                            <option value="content">문의내용</option>
                            <option value="writer">작성자</option>
                            <option value="answer">답변내용</option>
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
                            <tr class="urgent">
                                <td>125</td>
                                <td><span class="type-badge payment">결제</span></td>
                                <td class="title">
                                    <span class="urgent-badge">긴급</span>
                                    <span class="text">결제 오류 발생했습니다.</span>
                                </td>
                                <td>user123</td>
                                <td>2024-02-07 14:23</td>
                                <td><span class="status-badge new">신규</span></td>
                                <td>-</td>
                                <td class="action-buttons">
                                    <button type="button" onclick="location.href='answer?id=125';" class="answer-btn">
                                        답변하기
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>124</td>
                                <td><span class="type-badge delivery">배송</span></td>
                                <td class="title">
                                    <span class="text">배송 주소 변경 문의</span>
                                </td>
                                <td>user456</td>
                                <td>2024-02-07 11:15</td>
                                <td><span class="status-badge completed">답변완료</span></td>
                                <td>2024-02-07 13:20</td>
                                <td class="action-buttons">
                                    <button type="button" onclick="location.href='view?id=124';" class="view-btn">
                                        조회
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
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