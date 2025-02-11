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
            <h2>일반회원 관리</h2>
	            <div class="tab-buttons">
	                <button class="tab-button active" id="accountWait">유저관리</button>
	                <button class="tab-button" id="reportMember">신고누적</button>
	        	</div>
        	</div>
        	
            <div class="search-container">
                <form class="search-form">
                    <select class="search-input">
                        <option>전체</option>
                        <option>정상회원</option>
                        <option>차단회원</option>
                        <option>승인대기</option>
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
                        <th>가입일</th>
                        <th>신고횟수</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <%--이 부분을 forEach로 돌리기 --%>
                <c:forEach var="item" items="${member}">
                	<tr data-birth="${fn:substring(item.birth, 0, 10)}"  
                		data-tel1="${item.tel1}" 
                		data-tel2="${item.tel2}" 
                		data-nickname="${item.nickName}"
                		data-addr1="${item.addr1}" 
                		data-addr2="${item.addr2}" 
                		data-regdate="${fn:substring(item.reg_date, 0, 10)}"
                		data-mod_date="${fn:substring(item.mod_date, 0, 10)}"
                		data-last_login="${fn:substring(item.last_login, 0 ,10)}">
                		
	                    <td>${item.memberIdx}</td>
	                    <td>${item.name}</td>
	                    <td>${item.email1}@${item.email2}</td>
	                    <td>${fn:substring(item.reg_date, 0, 10)}</td>
	                    <td>신고횟수</td>
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

<script type="text/javascript">
// ajaxFun
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

// 회원 이름 클릭시 회원 정보가 모달창으로 띄우기

// ajax로 가입 신청 목록 확인하는 버튼
$(function() {
	$('#accountWait').click(function(e){
		 alert('유저관리');
	});
});

// Ajax
$(function() {
	$('#reportMember').click(function(e){
		 alert('신고누적');
	});
});

// 회원 정보 모달
$(function(){
	const $modal = $('#memberModal');
	const $close = $('.close');
	
	$('.member-table tbody tr').click(function(e){
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
		// const gender = $(this).data('gender');
		
		const addr1 = $(this).data('addr1');
		const addr2 = $(this).data('addr2');
		const lastLogin = $(this).data('last_login');
		const modDate = $(this).data('mod_date');
		
		
		
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

// 차단
$(function(){
    $('.block-button').click(function(){
    	e.stopPropagation();
        alert('차단하시겠습니까?');
    });

    $('.approve-button').click(function(){
        alert('차단해제 하시겠습니까?');
    });
});

</script>

</body>
</html>