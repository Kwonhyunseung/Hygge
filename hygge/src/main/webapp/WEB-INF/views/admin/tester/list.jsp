<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>체험단 신청 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/tester/testerList.css">
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
                <div class="header-title">
                    <h2>체험단 신청 관리</h2>
                    <span class="total-count">총 126개의 신청</span>
                </div>
                <div class="header-status">
                    <div class="status-item">
                        <span class="label">대기중</span>
                        <span class="count pending">45</span>
                    </div>
                    <div class="status-item">
                        <span class="label">승인완료</span>
                        <span class="count approved">62</span>
                    </div>
                    <div class="status-item">
                        <span class="label">거절</span>
                        <span class="count rejected">19</span>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <div class="filter-section">
                    <div class="project-filter">
                        <select name="projectStatus">
                            <option value="">프로젝트 상태</option>
                            <option value="recruiting">모집중</option>
                            <option value="ongoing">진행중</option>
                            <option value="completed">완료</option>
                        </select>
                        <select name="applicationStatus">
                            <option value="">신청 상태</option>
                            <option value="pending">대기중</option>
                            <option value="approved">승인</option>
                            <option value="rejected">거절</option>
                        </select>
                    </div>
                    <div class="search-wrapper">
                        <input type="text" placeholder="프로젝트명 또는 신청자 검색">
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
                                <th>신청번호</th>
                                <th>프로젝트명</th>
                                <th>신청자</th>
                                <th>신청일</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="selectedItems" value="1"></td>
                                <td>125</td>
                                <td class="project-info">
                                    <div class="project-name">신상 프리미엄 무선 이어폰 체험</div>
                                    <div class="project-period">2024.02.20 ~ 2024.03.20</div>
                                </td>
                                <td class="applicant-info">
                                    <div class="applicant-name">리뷰킹</div>
                                    <div class="applicant-reviews">리뷰 32개 작성</div>
                                </td>
                                <td>2024-02-07</td>
                                <td><span class="status-badge status-pending">대기중</span></td>
                                <td class="action-buttons">
                                    <button type="button" class="detail-btn" title="상세보기">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button type="button" class="approve-btn" title="승인">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <button type="button" class="reject-btn" title="거절">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </td>
                            </tr>
                            <!-- 추가 데이터 행들... -->
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
                    <div class="button-group">
                        <button type="button" class="bulk-approve">선택 승인</button>
                        <button type="button" class="bulk-reject">선택 거절</button>
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