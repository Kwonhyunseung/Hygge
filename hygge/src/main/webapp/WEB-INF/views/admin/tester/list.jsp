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
		            <span class="total-count">
		                총 <span class="font-bold">${empty countMap.TOTAL ? 0 : countMap.TOTAL}</span>개의 신청
		            </span>
		        </div>
		        <div class="header-status">
		            <div class="status-item">
		                <span class="label">대기중</span>
		                <span class="count pending">${empty countMap.PENDING ? 0 : countMap.PENDING}</span>
		            </div>
		            <div class="status-item">
		                <span class="label">승인완료</span>
		                <span class="count approved">${empty countMap.APPROVED ? 0 : countMap.APPROVED}</span>
		            </div>
		            <div class="status-item">
		                <span class="label">거절</span>
		                <span class="count rejected">${empty countMap.REJECTED ? 0 : countMap.REJECTED}</span>
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
							    <c:forEach var="item" items="${member}">
							        <tr>
							            <td><input type="checkbox" name="selectedItems" value="${item.num}"></td>
							            <td>${item.num}</td>
							            <td class="project-info">
							                <div class="project-name">${item.title}</div>
							                <div class="project-period">
							                    <fmt:formatDate value="${item.request_date}" pattern="yyyy.MM.dd"/>
							                    <c:if test="${not empty item.accept_date}">
							                        ~ <fmt:formatDate value="${item.accept_date}" pattern="yyyy.MM.dd"/>
							                    </c:if>
							                </div>
							            </td>
							            <td class="applicant-info">
							                <div class="applicant-name">${item.nickName}</div>
							                <div class="applicant-reviews">
							                    리뷰 ${item.review_num eq null ? 0 : item.review_num}개 작성
							                </div>
							            </td>
							            <td>
							                <fmt:formatDate value="${item.request_date}" pattern="yyyy-MM-dd"/>
							            </td>
										<td>
										    <span class="status-badge 
										        ${item.block == 0 ? 'status-pending' : (item.block == 1 ? 'status-approved' : 'status-rejected')}">
										        ${item.block == 0 ? '대기중' : (item.block == 1 ? '승인' : '거절')}
										    </span>
										</td>							            <td class="action-buttons">
							                <button type="button" class="detail-btn" title="상세보기">
							                    <i class="fas fa-eye"></i>
							                </button>
											<button type="button" class="approve-btn" title="승인" 
											    onclick="approveTester('${item.memberIdx}', '${item.num}');">
											    <i class="fas fa-check"></i>
											</button>
											<button type="button" class="reject-btn" title="거절" 
											    onclick="rejectTester('${item.memberIdx}', '${item.num}');">
											    <i class="fas fa-times"></i>
											</button>
							            </td>
							        </tr>
							    </c:forEach>
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

<script type="text/javascript">
function approveTester(memberIdx, num) {
    if(!confirm("체험단 신청을 승인하시겠습니까?")) {
        return;
    }
    
    const url = "${pageContext.request.contextPath}/admin/tester/approve";
    const query = "memberIdx=" + memberIdx + "&num=" + num;
    
    const fn = function(data) {
        if(data.state === "success") {
            alert("승인되었습니다.");
            location.reload();
        } else {
            alert("승인 처리가 실패했습니다.");
        }
    };
    
    ajaxRequest(url, "post", query, "json", fn);
}

function rejectTester(memberIdx, num) {
	if(! confirm('체험단 신청을 거절하시겠습니까?')) {
		return;
	}
	
	const url = '${pageContext.request.contextPath}/admin/tester/reject';
	const query = 'memberIdx=' + memberIdx + '&num=' + num;
	
	const fn = function(data) {
		if(data.state === 'success') {
			alert('거절되었습니다.');
			location.reload();
		} else {
			alert('거절 처리가 실패했습니다.');
		}
	};
	
	ajaxRequest(url, 'post', query, 'json', fn);
}

</script>
</html>