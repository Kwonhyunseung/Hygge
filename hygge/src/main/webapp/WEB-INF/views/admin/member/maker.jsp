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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
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

        <!-- 승인 대기 프로젝트 테이블 -->
        <div id="pendingProjects" class="tab-content active">
            <div class="search-container">
                <form class="search-form">
                    <select class="search-input">
                        <option>전체 카테고리</option>
                        <option>의류</option>
                        <option>전자기기</option>
                        <option>식품</option>
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
                        <th>카테고리</th>
                        <th>신청일</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1001</td>
                        <td>굿즈샵</td>
                        <td><a href="#" class="project-link">2024 봄 신상 의류</a></td>
                        <td>의류</td>
                        <td>2024-02-06</td>
                        <td><span class="status-badge status-pending">대기중</span></td>
                        <td>
                            <button class="action-button approve-button" onclick="approveProject(1001)">승인</button>
                            <button class="action-button reject-button" onclick="rejectProject(1001)">거부</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 신고 누적 프로젝트 테이블 -->
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

        <div class="pagination">
            <a href="#">&laquo;</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">&raquo;</a>
        </div>
    </div>
</div>

<script>
function ajaxFun(url, method, formData, dataType, fn, file = false) {
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


// 탭 전환
document.querySelectorAll('.tab-button').forEach(button => {
    button.addEventListener('click', () => {
        // 탭 버튼 활성화 상태 변경
        document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        
        // 탭 컨텐츠 전환
        const tabId = button.dataset.tab + 'Projects';
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');
        
        // 데이터 로드
        loadTabData(button.dataset.tab);
    });
});

/*
// Ajax 데이터 로드 함수
function loadTabData(tab) {
     const url = tab === 'pending' ? '${pageContext.request.contextPath}/admin/projects/pending' : '${pageContext.request.contextPath}/admin/projects/reported';
    
     ajaxFun(url, "get", null, "json", function(data) {
        // 테이블 데이터 업데이트
        updateTable(tab, data);
    });
}
*/
// 테이블 업데이트 함수
function updateTable(tab, data) {
    const tbody = document.querySelector('#' + tab + 'Projects table tbody');
    let html = '';
    
    if(tab === 'pending') {
        data.forEach(item => {
            html += `
                <tr>
                    <td>${item.projectId}</td>
                    <td>${item.sellerName}</td>
                    <td><a href="#" class="project-link">${item.projectName}</a></td>
                    <td>${item.category}</td>
                    <td>${item.applyDate}</td>
                    <td><span class="status-badge status-pending">대기중</span></td>
                    <td>
                        <button class="action-button approve-button" onclick="approveProject(${item.projectId})">승인</button>
                        <button class="action-button reject-button" onclick="rejectProject(${item.projectId})">거부</button>
                    </td>
                </tr>
            `;
        });
    } else {
        data.forEach(item => {
            html += `
                <tr>
                    <td>${item.projectId}</td>
                    <td>${item.sellerName}</td>
                    <td><a href="#" class="project-link">${item.projectName}</a></td>
                    <td class="report-count">${item.reportCount}</td>
                    <td>${item.lastReportDate}</td>
                    <td><span class="status-badge status-warning">경고</span></td>
                    <td>
                        <button class="action-button detail-button" onclick="showReportDetails(${item.projectId})">신고내역</button>
                        <button class="action-button block-button" onclick="blockProject(${item.projectId})">프로젝트 중단</button>
                    </td>
                </tr>
            `;
        });
    }
    
    tbody.innerHTML = html;
}

// 프로젝트 승인
function approveProject(projectId) {
    if(confirm('이 프로젝트를 승인하시겠습니까?')) {
        let url = '${pageContext.request.contextPath}/admin/projects/approve';
        let query = {projectId: projectId};
        
        ajaxFun(url, "post", query, "json", function(data) {
            if(data.success) {
                alert('프로젝트가 승인되었습니다.');
                loadTabData('pending');
            } else {
                alert('프로젝트 승인 중 오류가 발생했습니다.');
            }
        });
    }
}

// 프로젝트 거부
function rejectProject(projectId) {
    if(confirm('이 프로젝트를 거부하시겠습니까?')) {
        let url = '${pageContext.request.contextPath}/admin/projects/reject';
        let query = {projectId: projectId};
        
        ajaxFun(url, "post", query, "json", function(data) {
            if(data.success) {
                alert('프로젝트가 거부되었습니다.');
                loadTabData('pending');
            } else {
                alert('프로젝트 거부 중 오류가 발생했습니다.');
            }
        });
    }
}

// 프로젝트 중단
function blockProject(projectId) {
    if(confirm('이 프로젝트를 중단하시겠습니까?')) {
        let url = '${pageContext.request.contextPath}/admin/projects/block';
        let query = {projectId: projectId};
        
        ajaxFun(url, "post", query, "json", function(data) {
            if(data.success) {
                alert('프로젝트가 중단되었습니다.');
                loadTabData('reported');
            } else {
                alert('프로젝트 중단 중 오류가 발생했습니다.');
            }
        });
    }
}

// 신고 상세내역 표시
function showReportDetails(projectId) {
    let url = '${pageContext.request.contextPath}/admin/projects/reports/' + projectId;
    
    ajaxFun(url, "get", null, "json", function(data) {
        // 모달에 신고 내역 표시
        showReportModal(data);
    });
}

// 신고 내역 모달 표시
function showReportModal(data) {
    // 모달 구현
    // 예: Bootstrap modal 또는 커스텀 모달
}

// 페이지 로드 시 초기 데이터 로드
document.addEventListener('DOMContentLoaded', function() {
    loadTabData('pending');
});
</script>
</body>
</html>