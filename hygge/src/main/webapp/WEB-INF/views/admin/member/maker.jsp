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
                <tr>
                    <td>1001</td>
                    <td>홍길동</td>
                    <td>hong@example.com</td>
                    <td>2024-02-06</td>
                    <td>
                        <button class="action-button view-button" onclick="viewPortfolio(1001)">보기</button>
                    </td>
                    <td><span class="status-badge status-pending">대기중</span></td>
                    <td>
                        <button class="action-button approve-button" onclick="approveMaker(1001)">승인</button>
                        <button class="action-button reject-button" onclick="rejectMaker(1001)">거절</button>
                    </td>
                </tr>
                <tr>
                    <td>1002</td>
                    <td>김철수</td>
                    <td>kim@example.com</td>
                    <td>2024-02-05</td>
                    <td>
                        <button class="action-button view-button" onclick="viewPortfolio(1002)">보기</button>
                    </td>
                    <td><span class="status-badge status-approved">승인완료</span></td>
                    <td>
                        <button class="action-button detail-button" onclick="viewDetails(1002)">상세보기</button>
                    </td>
                </tr>
            </tbody>
        </table>

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

// 메이커 목록 로드
function loadMakers(page = 1) {
    let url = `${pageContext.request.contextPath}/admin/makers/list`;
    let query = {
        page: page,
        condition: document.querySelector('select.search-input').value,
        keyword: document.querySelector('input.search-input').value
    };
    
    ajaxFun(url, "get", query, "json", function(data) {
        updateMakerTable(data);
    });
}
<%--
// 테이블 업데이트
function updateMakerTable(data) {
    const tbody = document.querySelector('.member-table tbody');
    let html = '';
    
    data.makers.forEach(maker => {
        html += `
            <tr>
                <td>${maker.memberNo}</td>
                <td>${maker.name}</td>
                <td>${maker.email}</td>
                <td>${maker.applyDate}</td>
                <td>
                    <button class="action-button view-button" onclick="viewPortfolio(${maker.memberNo})">보기</button>
                </td>
                <td>
                    <span class="status-badge ${getStatusClass(maker.status)}">${maker.status}</span>
                </td>
                <td>
                    ${getActionButtons(maker)}
                </td>
            </tr>
        `;
    });
    
    tbody.innerHTML = html;
    updatePagination(data.pagination);
}
--%>

// 상태에 따른 클래스 반환
function getStatusClass(status) {
    const classMap = {
        '대기중': 'status-pending',
        '승인완료': 'status-approved',
        '승인거절': 'status-rejected'
    };
    return classMap[status] || 'status-pending';
}

// 상태에 따른 액션 버튼 반환
function getActionButtons(maker) {
    if (maker.status === '대기중') {
        return `
            <button class="action-button approve-button" onclick="approveMaker(${maker.memberNo})">승인</button>
            <button class="action-button reject-button" onclick="rejectMaker(${maker.memberNo})">거절</button>
        `;
    }
    return `<button class="action-button detail-button" onclick="viewDetails(${maker.memberNo})">상세보기</button>`;
}

// 메이커 승인
function approveMaker(memberNo) {
    if(!confirm('이 회원의 메이커 신청을 승인하시겠습니까?')) {
        return;
    }
    
    let url = `${pageContext.request.contextPath}/admin/makers/approve`;
    let query = {memberNo: memberNo};
    
    ajaxFun(url, "post", query, "json", function(data) {
        if(data.success) {
            alert('메이커 신청이 승인되었습니다.');
            loadMakers();
        } else {
            alert('승인 처리 중 오류가 발생했습니다.');
        }
    });
}

// 메이커 거절
function rejectMaker(memberNo) {
    if(!confirm('이 회원의 메이커 신청을 거절하시겠습니까?')) {
        return;
    }
    
    let url = `${pageContext.request.contextPath}/admin/makers/reject`;
    let query = {memberNo: memberNo};
    
    ajaxFun(url, "post", query, "json", function(data) {
        if(data.success) {
            alert('메이커 신청이 거절되었습니다.');
            loadMakers();
        } else {
            alert('거절 처리 중 오류가 발생했습니다.');
        }
    });
}

// 포트폴리오 보기
function viewPortfolio(memberNo) {
    let url = `${pageContext.request.contextPath}/admin/makers/portfolio/${memberNo}`;
    
    ajaxFun(url, "get", null, "json", function(data) {
        const modalBody = document.querySelector('#portfolioModal .modal-body');
        modalBody.innerHTML = `
            <div class="portfolio-content">
                <h4>포트폴리오 정보</h4>
                <p><strong>경력:</strong> ${data.career}년</p>
                <p><strong>전문분야:</strong> ${data.specialization}</p>
                <div class="portfolio-files">
                    <h5>첨부파일</h5>
                    data.files.map(function(file) {
					    return '<div class="file-item">' +
					           '<a href="' + file.url + '" target="_blank">' + file.name + '</a>' +
					           '</div>';
					}).join('')
                </div>
                <div class="portfolio-description">
                    <h5>자기소개</h5>
                    <p>${data.description}</p>
                </div>
            </div>
        `;
        
        const modal = new bootstrap.Modal(document.getElementById('portfolioModal'));
        modal.show();
    });
}

// 검색 이벤트 처리
document.querySelector('.search-form').addEventListener('submit', function(e) {
    e.preventDefault();
    loadMakers(1);
});

// 페이지 로드 시 초기 데이터 로드
document.addEventListener('DOMContentLoaded', function() {
    loadMakers();
});

</script>



</body>
</html>