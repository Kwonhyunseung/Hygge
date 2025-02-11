<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반유저</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/normal.css" type="text/css">
</head>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

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
                    <tr>
                        <td>번호가 오자</td>
                        <td>홍길동</td>
                        <td>hong@example.com</td>
                        <td>2024-02-01</td>
                        <td>0</td>
                        <td><span class="status-badge status-active">정상</span></td>
                        <td>
                            <button class="action-button block-button">차단</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1002</td>
                        <td>김철수</td>
                        <td>kim@example.com</td>
                        <td>2024-02-03</td>
                        <td>3</td>
                        <td><span class="status-badge status-blocked">차단</span></td>
                        <td>
                            <button class="action-button approve-button">차단해제</button>
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
		 alert('가입 승인 대기 버튼');
	});
});

$(function() {
	$('#reportMember').click(function(e){
		 alert('신고 누적');
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

// 유저관리 ajax

// 승인대기 ajax

</script>

</body>
</html>