<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메이커 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/maker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/normal.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<div class="admin-container">
    <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

    <div class="main-content">
        <h2>메이커 신청 관리</h2>
        
        <div class="search-container">
            <form class="search-form">
                <select class="search-input">
                    <option>전체</option>
                    <option>승인대기</option>
                    <option>승인완료</option>
                    <option>승인거절</option>
                </select>
                <input type="text" class="search-input" placeholder="회원 검색...">
                <button type="submit" class="search-button">검색</button>
            </form>
        </div>

        <table class="member-table">
            <thead>
                <tr>
                    <th>회원번호</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>신청일</th>
                    <th>프로젝트</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
<tbody>
    <c:forEach var="maker" items="${makers}">
        <tr data-project-num="${maker.projectNum}">
            <td>${maker.memberIdx}</td>
            <td>${maker.name}</td>
            <td>${maker.email1}@${maker.email2}</td>
            <%-- <td><fmt:formatDate value="${maker.request_date}" pattern="yyyy-MM-dd"/></td>--%>
            <td>${maker.request_date}</td>
            <td>
                <button class="action-button view-button" onclick="viewPortfolio(${maker.memberIdx})">보기</button>
            </td>
            <td>
                <c:choose>
                    <c:when test="${maker.status eq '대기중'}">
                        <span class="status-badge status-pending">대기중</span>
                    </c:when>
                    <c:when test="${maker.status eq '승인완료'}">
                        <span class="status-badge status-approved">승인완료</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-rejected">승인거절</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${maker.status eq '대기중'}">
                    <button class="action-button approve-button" onclick="approveMaker(${maker.memberIdx})">승인</button>
                    <button class="action-button reject-button" onclick="rejectMaker(${maker.memberIdx},${maker.projectNum})">거절</button>
                </c:if>
                <c:if test="${maker.status ne 'MAKER'}">
                    <button class="action-button detail-button" onclick="viewDetails(${maker.memberIdx})">상세보기</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</tbody>
        </table>

        <div class="pagination">
        	${paging}
        </div>
    </div>
</div>

<!-- 포트폴리오 모달 -->
<div class="modal fade" id="portfolioModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">포트폴리오 상세</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 포트폴리오 내용이 여기에 동적으로 로드됩니다 -->
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
function Request(url, method, formData, dataType, fn, file = false) {
	const settings = {
			type: method, 
			data: formData,
			dataType:dataType,
			success:function(data) {
				fn(data);
			},
			beforeSend: function(jqXHR) {
			},
			complete: function () {
			},
			error: function(jqXHR) {
				console.log(jqXHR.responseText);
			}
	};
	
	if(file) {
		settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
	}
	
	$.ajax(url, settings);
}

// 승인
function approveMaker(memberIdx) {
    if(!confirm('이 회원의 메이커 신청을 승인하시겠습니까?')) {
        return;
    }
    
    let url = '${pageContext.request.contextPath}/admin/memberManagement/maker/approve';
    let query = {memberIdx: memberIdx};
    
    ajaxRequest(url, "post", query, "json", function(data) {
        if(data.success) {
            alert('메이커 신청이 승인되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            alert('승인 처리 중 오류가 발생했습니다.');
        }
    });
}

function rejectMaker(memberIdx, projectNum) {
    if(!confirm('이 회원의 메이커 신청을 거절하시겠습니까?')) {
        return;
    }
    
    let url = '${pageContext.request.contextPath}/admin/memberManagement/maker/reject';
    let query = {memberIdx: memberIdx, projectNum:projectNum};
    
    ajaxRequest(url, "post", query, "json", function(data) {
        if(data.success) {
            alert('메이커 신청이 거절되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            alert('거절 처리 중 오류가 발생했습니다.');
        }
    });
}


</script>



</body>
</html>