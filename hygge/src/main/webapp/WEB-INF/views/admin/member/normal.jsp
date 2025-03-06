<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반유저</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/normal.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/normalModal.css" type="text/css">
<style type="text/css">
.pagination {
    display: flex;
    justify-content: center;
    margin: 20px 0;
}

.pagination a {
    color: black;
    padding: 8px 16px;
    text-decoration: none;
    border: 1px solid #ddd;
    margin: 0 4px;
}

.pagination a.active {
    background-color: #4CAF50;
    color: white;
    border: 1px solid #4CAF50;
}

.pagination a:hover:not(.active) {
    background-color: #ddd;
}

.page-info {
    text-align: center;
    margin: 10px 0;
    color: #666;
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>
<%-- 모달 --%>
 <jsp:include page="/WEB-INF/views/admin/member/normalModal.jsp"/>
 
    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
		
       <div class="main-content">
			<div class="content-header">
			    <div class="tab-buttons">
			        <a href="${pageContext.request.contextPath}/admin/memberManagement/normal" 
			           class="tab-button ${empty reportOnly ? 'active' : ''}" id="accountWait">
			            전체
			        </a>
			        <a href="${pageContext.request.contextPath}/admin/memberManagement/reportOver" 
			           class="tab-button ${not empty reportOnly ? 'active' : ''}" id="reportMember">
			            신고누적
			        </a>
			    </div>
			</div>
        	
			<div class="search-container">
			    <form class="search-form" method="get" action="${pageContext.request.contextPath}/admin/memberManagement/normal">
			        <select name="schType" class="search-input">
			            <option value="all" ${schType=="all"?"selected":""}>전체</option>
			            <option value="name" ${schType=="name"?"selected":""}>이름</option>
			            <option value="email" ${schType=="email"?"selected":""}>이메일</option>
			            <option value="reg_date" ${schType=="reg_date"?"selected":""}>가입일</option>
			        </select>
			        <input type="text" name="kwd" class="search-input" placeholder="회원 검색..." value="${kwd}">
			        <button type="submit" class="search-button">검색</button>
			    </form>
			</div>

            <table class="member-table">
                <thead>
                    <tr>
                        <th>회원번호</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>가입일</th>
                        <th>신고횟수</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${member}">
                	<tr data-birth="${fn:substring(item.birth, 0, 10)}"  
                		data-tel1="${item.tel1}" 
                		data-tel2="${item.tel2}" 
                		data-nickname="${item.nickName}"
                		data-addr1="${item.addr1}" 
                		data-addr2="${item.addr2}" 
                		data-regdate="${fn:substring(item.reg_date, 0, 10)}"
                		data-mod_date="${fn:substring(item.mod_date, 0, 10)}"
                		data-last_login="${fn:substring(item.last_login, 0 ,10)}"
                		data-gender="${item.gender== 1 ? '남자' : '여자'}">
                		
	                    <td>${item.memberIdx}</td>
	                    <td>${item.name}</td>
	                    <td>${item.email1}@${item.email2}</td>
	                    <td>${fn:substring(item.reg_date, 0, 10)}</td>
	                    <td>${item.report_count}</td>
	                    <td>
	                    	<c:choose>
	                    		<c:when test="${item.block == 0}">
	                    			<span class="status-badge status-active">정상</span>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<span class="status-badge status-blocked">차단</span>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </td>
	                    <td>
	                    	<c:choose>
	                    		<c:when test="${item.block == 0}">
	                    			<button class="action-button block-button">차단</button>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<button class="action-button approve-button">차단해제</button>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </td>
	                </tr>
	            </c:forEach>
                    
                </tbody>
            </table>



			<div class="pagination">
			    ${paging}
			</div>
			


<c:if test="${dataCount != 0}">
    <div class="page-info">
        ${dataCount}개(${page}/${total_page} 페이지)
    </div>
</c:if>

<script type="text/javascript">
// 회원 이름 클릭시 회원 정보가 모달창으로 띄우기

// 신고
$(function() {
	$('#reportMember').click(function(e){
		$('.tab-button').removeClass('active');
		$(this).addClass('active');
		
	});
});

// 회원 정보 모달
$(function(){
	const $modal = $('#memberModal');
	const $close = $('.close');
	

	$('.member-table tbody tr').click(function(e){
		
	    if($(e.target).hasClass('block-button') || $(e.target).hasClass('approve-button')) {
	        return;
	    }
	    
		const memberIdx = $(this).find('td:eq(0)').text();
		const name = $(this).find('td:eq(1)').text();
		const email = $(this).find('td:eq(2)').text();
		const regDate = $(this).find('td:eq(3)').text();
		const reportCount = $(this).find('td:eq(4)').text();
		const status = $(this).find('td:eq(5)').text();
		
		const birth = $(this).data('birth');
		
		const tel1 = $(this).data('tel1');
		const tel2 = $(this).data('tel2');
		const fullTel = tel1 + '-' + tel2;
		
		const nickName = $(this).data('nickname');
		const gender = $(this).data('gender');
		
		const addr1 = $(this).data('addr1');
		const addr2 = $(this).data('addr2');
		const lastLogin = $(this).data('last_login');
		const modDate = $(this).data('mod_date');
		
		
		
		$('#modalGender').text(gender);
		$('#modalMemberIdx').text(memberIdx);
		$('#modalBirth').text(birth);
		$('#modalName').text(name);
		$('#modalEmail').text(email);
		$('#modalRegDate').text(regDate);
		$('#modalReportCount').text(reportCount);
		$('#modalStatus').text(status);
		
		$('#modalNickName').text(nickName);
		
		$('#modalTel').text(fullTel);
		$('#modalAddr').text(addr1);
		
		$('#modalLastLogin').text(lastLogin);
		$('#modalModDate').text(modDate);
		
		
		$modal.show();
	});
	
	$close.click(function(){
		$modal.hide();
	});
	
	// 모달 외부 클릭
	$(window).click(function(event) {
		if($(event.target).is($modal)) {
			$modal.hide();
		}
	});
	
});


// 탭 전환
document.querySelectorAll('.tab-button').forEach(button => {
    button.addEventListener('click', () => {
    	
        document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        
        const tabId = button.dataset.tab + 'Projects';
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');
        
        loadTabData(button.dataset.tab);
    });
});

//차단
$(function(){
    $(document).on('click', '.block-button, .approve-button', function(e){
        e.preventDefault(); 
        e.stopPropagation();
        
        const $btn = $(this);
        const $row = $btn.closest('tr');
        const memberIdx = $row.find('td:first').text();
        
        // 차단 버튼인 경우
        if($btn.hasClass('block-button')) {
            let url = '${pageContext.request.contextPath}/admin/memberManagement/block'; 
            let data = {memberIdx: memberIdx};
            
            if(confirm('차단하시겠습니까?')) {
                ajaxRequest(url, 'post', data, 'json', function(data) {
                    if(data.state === "success") {  
                        $row.find('.status-badge')
                            .removeClass('status-active')
                            .addClass('status-blocked')
                            .text('차단');
                        
                        $btn.removeClass('block-button')
                            .addClass('approve-button')
                            .text('차단해제');
                    } else { 
                        alert('처리 중 문제가 발생했습니다.');
                    }
                });
            }
        } 
        // 차단해제 버튼인 경우
        else if($btn.hasClass('approve-button')) {
            let url = '${pageContext.request.contextPath}/admin/memberManagement/unblock'; 
            let data = {memberIdx: memberIdx};
            
            if(confirm('차단을 해제하시겠습니까?')) {
                ajaxRequest(url, 'post', data, 'json', function(data) {
                    if(data.state === "success") {  
                        $row.find('.status-badge')
                            .removeClass('status-blocked')
                            .addClass('status-active')
                            .text('정상');
                        
                        $btn.removeClass('approve-button')
                            .addClass('block-button')
                            .text('차단');
                    } else { 
                        alert('처리 중 문제가 발생했습니다.');
                    }
                });
            }
        }
        
        return false;
    });
});

// 펀딩 기간 변경 시 펀딩 일수 자동 계산
function updateFundingDays() {
  const startDate = new Date(document.getElementById('fundingStartDate').value);
  const endDate = new Date(document.getElementById('fundingEndDate').value);
  
  if (!isNaN(startDate.getTime()) && !isNaN(endDate.getTime())) {
    const diffTime = Math.abs(endDate - startDate);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; // +1 to include both start and end days
    document.getElementById('fundingDays').value = diffDays;
  }
}

// 날짜 입력 필드에 이벤트 리스너 추가
document.getElementById('fundingStartDate').addEventListener('change', updateFundingDays);
document.getElementById('fundingEndDate').addEventListener('change', updateFundingDays);

// 저장 버튼 클릭 시 처리
document.getElementById('saveChanges').addEventListener('click', function() {
  alert('프로젝트 정보가 성공적으로 저장되었습니다.');
  // 실제로는 여기에 AJAX 요청으로 서버에 데이터를 전송하는 코드가 들어갑니다.
});
</script>

</body>
</html>