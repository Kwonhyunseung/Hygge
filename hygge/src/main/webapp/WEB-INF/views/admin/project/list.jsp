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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/project/list.css">

</head>
<body>

<header>
   <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<div class="admin-container">
   <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
   <div class="main-content">
       <div class="content-header">
           <h2>셀러 프로젝트 관리</h2>
           <div class="tab-buttons">
               <button class="tab-button active" data-tab="pending">승인 대기</button>
               <button class="tab-button" data-tab="reported">신고 누적</button>
           </div>
       </div>

       <div class="tab-container">
           <!-- 승인 대기 프로젝트 -->
           <div id="pendingProjects" class="tab-content active">
               <form name="searchForm" action="${pageContext.request.contextPath}/admin/projectManagement/list" method="get">
                   <div class="row mb-3">
                       <div class="col-auto">
                           <select name="schType" class="form-select">
                               <option value="all" ${schType=="all"?"selected":""}>전체</option>
                               <option value="title" ${schType=="title"?"selected":""}>제목</option>
                               <option value="request_date" ${schType=="request_date"?"selected":""}>요청일</option>
                           </select>
                       </div>
                       <div class="col-auto">
                           <input type="text" name="kwd" value="${kwd}" class="form-control">
                       </div>
                       <div class="col-auto">
                           <button type="submit" class="btn btn-primary">검색</button>
                       </div>
                   </div>
               </form>

               <table class="table table-hover">
                   <thead>
                       <tr>
                           <th>번호</th>
                           <th>제목</th>
                           <th>요청일</th>
                           <th>승인일</th>
                           <th>상태</th>
                           <th>목표금액</th>
                           <th>기간</th>
                           <th></th>
                           <th></th>
                       </tr>
                   </thead>
                   <tbody>
                       <c:forEach var="dto" items="${list}" varStatus="status">
                           <tr>
                               <td>${dataCount - (page-1) * size - status.index}</td>
                               <td>
                                   <a href="${pageContext.request.contextPath}/admin/projectManagement/detail/${dto.num}">
                                       ${dto.title}
                                   </a>
                               </td>
                               <td>
                                   <fmt:formatDate value="${dto.request_date}" pattern="yyyy-MM-dd"/>
                               </td>
                               <td>
                                   <fmt:formatDate value="${dto.accept_date}" pattern="yyyy-MM-dd"/>
                               </td>
                               <td>
                                   <c:choose>
                                       <c:when test="${empty dto.accept_return}">
                                           <span class="badge bg-warning">대기중</span>
                                       </c:when>
                                       <c:when test="${dto.accept_return == 1}">
                                           <span class="badge bg-success">승인</span>
                                       </c:when>
                                       <c:when test="${dto.accept_return == 0}">
                                           <span class="badge bg-danger">반려</span>
                                       </c:when>
                                   </c:choose>
                               </td>
                               <td>
                                   <fmt:formatNumber value="${dto.target}" type="number"/>원
                               </td>
                               <td>${dto.term}일</td>
                               <td>
                               <td>
							    <c:choose>
							        <c:when test="${empty dto.accept_return}">
							            <button type="button" class="btn btn-sm btn-success me-1" 
							                    onclick="approveProject(${dto.num}, ${dto.term})">
							                수락
							            </button>
							            <button type="button" class="btn btn-sm btn-danger" 
							                    onclick="rejectProject(${dto.num})">
							                반려
							            </button>
							        </c:when>
							        <c:otherwise>
							            <button type="button" class="btn btn-sm btn-primary" 
							                    onclick="location.href='${pageContext.request.contextPath}/admin/projectManagement/update/${dto.num}'">
							                관리
							            </button>
							        </c:otherwise>
							    </c:choose>
							</td>
                               </td>
                           </tr>
                       </c:forEach>
                   </tbody>
               </table>
               
               <div class="page-navigation">
                   ${paging}
               </div>
           </div>

           <!-- 신고 누적 프로젝트 -->
           <div id="reportedProjects" class="tab-content">
               <div class="search-container">
                   <form class="search-form">
                       <select class="search-input">
                           <option>신고 횟수</option>
                           <option>5회 이상</option>
                           <option>10회 이상</option>
                           <option>20회 이상</option>
                       </select>
                       <input type="text" class="search-input" placeholder="프로젝트 검색...">
                       <button type="submit" class="search-button">검색</button>
                   </form>
               </div>

               <table class="project-table">
                   <thead>
                       <tr>
                           <th>번호</th>
                           <th>셀러명</th>
                           <th>프로젝트명</th>
                           <th>신고 횟수</th>
                           <th>최근 신고일</th>
                           <th>상태</th>
                           <th>관리</th>
                       </tr>
                   </thead>
                   <tbody>
                       <tr>
                           <td>1002</td>
                           <td>전자마트</td>
                           <td><a href="#" class="project-link">무선이어폰</a></td>
                           <td class="report-count">8</td>
                           <td>2024-02-05</td>
                           <td><span class="status-badge status-warning">경고</span></td>
                           <td>
                               <button class="action-button detail-button" onclick="showReportDetails(1002)">신고내역</button>
                               <button class="action-button block-button" onclick="blockProject(1002)">프로젝트 중단</button>
                           </td>
                       </tr>
                   </tbody>
               </table>
           </div>
       </div>
   </div>
</div>

<script>
// 탭 전환
document.querySelectorAll('.tab-button').forEach(button => {
   button.addEventListener('click', () => {
       // 탭 버튼 활성화 상태 변경
       document.querySelectorAll('.tab-button').forEach(btn => 
           btn.classList.remove('active'));
       button.classList.add('active');
       
       // 탭 컨텐츠 전환
       const tabId = button.dataset.tab + 'Projects';
       document.querySelectorAll('.tab-content').forEach(content => 
           content.classList.remove('active'));
       document.getElementById(tabId).classList.add('active');
   });
});

function showReportDetails(projectId) {
   // 신고 내역 표시 로직
}

function blockProject(projectId) {
   // 프로젝트 중단 로직
}

function approveProject(num, term) {
	
	if(!confirm("프로젝트를 승인하시겠습니까?")) {
		return;
	}
	
	const url = "${pageContext.request.contextPath}/admin/projectManagement/approve";
	const query = "num=" + num + "&term=" + term;
	
	const fn = function(data) {
		if(data.state === "success"){
			alert('프로젝트가 승인되었습니다.');
		} else {
			alert('프로젝트 승인 처리가 실패했습니다.');
		}
	};
	
	ajaxRequest(url, 'post', query, 'json', fn)
}

function rejectProject(num) {
	
	const reason = prompt("반려 사유를 입력해주세요.");
	if(! reason) {
		return;
	}
	
	if(! confirm('프로젝트를 반려하시겠습니까?')) {
		return;
	}
	
	const url = "${pageContext.request.contextPath}/admin/projectManagement/reject";
	const query = "num=" + num + "&reason=" + encodeURIComponent(reason);
	
	const fn = function(data) {
		if(data.state === "success") {
			alert('프로젝트가 반려되었습니다.');
			location.reload();
		} else {
			alert("프로젝트 반려 처리가 실패했습니다.");
		}
	};
	
	ajaxRequest(url, 'post', query, 'json', fn);
}



</script>
</body>
</html>