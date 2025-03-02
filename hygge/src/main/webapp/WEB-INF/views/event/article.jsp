<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
/* 기존 CSS를 확장한 article 페이지 스타일 */
.article-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
}

.article-header {
    border-bottom: 1px solid #ddd;
    margin-bottom: 20px;
    padding-bottom: 15px;
}

.article-title {
    font-size: 28px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
}

.article-info {
    display: flex;
    justify-content: space-between;
    font-size: 14px;
    color: #666;
}

.article-date {
    display: flex;
    align-items: center;
}

.article-date i {
    margin-right: 5px;
    color: #82B10C;
}

.article-content {
    margin: 30px 0;
    line-height: 1.6;
}

.article-image {
    text-align: center;
    margin: 30px 0;
    width: 100%;
}

.article-image img {
    width: 100%;
    max-height: 600px; /* 이미지 최대 높이 설정 */
    object-fit: contain; /* 이미지 비율 유지 */
    border-radius: 4px;
}

.button-container {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #ddd;
}

.btn {
    padding: 8px 15px;
    background-color: #fff;
    border: 1px solid #82B10C;
    color: #82B10C;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn:hover {
    background-color: #82B10C;
    color: #fff;
}

.btn-list {
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    color: #555;
}

.btn-list:hover {
    background-color: #eee;
    color: #333;
    border-color: #ccc;
}


.article-status {
    display: flex;
    align-items: center;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: bold;
}

.status-active {
    background-color: #82B10C;
    color: white;
}

.status-expired {
    background-color: #888;
    color: white;
}
</style>
</head>
<body>
<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>
<div class="body-main">
    <div class="article-container">
        <div class="article-header">
            <div class="article-title">${dto.title}</div>
            <div class="article-info">
                <div class="article-date">
                    <i class="far fa-calendar-alt"></i>
                    이벤트 기간: <fmt:formatDate value="${dto.evt_date}" pattern="yyyy-MM-dd"/> ~ 
                    <fmt:formatDate value="${dto.exp_date}" pattern="yyyy-MM-dd"/>
                </div>
                <!-- 상태 표시가 필요한 경우 아래 주석을 해제하고 사용하세요 -->
                <!-- <div class="article-status">
                    <span class="status-badge status-active">진행중</span>
                </div> -->
            </div>
        </div>
        
        
        <div class="article-image">
            <img src="${pageContext.request.contextPath}/uploads/event/${dto.photo}" alt="이벤트 이미지">
        </div>
        
        <div class="article-content">
            ${dto.content}
        </div>
        
                <c:if test="${dto.exp_date >= now}">
            <button type="button" class="btn btn-apply" onclick="applyEvent(${dto.num});">
                <i class="fas fa-check-circle"></i> 이벤트 신청하기
            </button>
        </c:if>
        
        <div class="button-container">
            <button type="button" class="btn btn-list" onclick="location.href='${pageContext.request.contextPath}/event/list';">목록</button>
            
            <!-- 관리자만 보이는 버튼, 필요시 권한 체크 후 표시 -->
            <c:if test="${sessionScope.member.authority == 'ADMIN'}">
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/admin/event/update?num=${dto.num}';">수정</button>
                <button type="button" class="btn" onclick="deleteEvent(${dto.num});">삭제</button>
            </c:if>
        </div>
    </div>
</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
<script>
const memberidx = "${sessionScope.member.memberidx}";

// 이벤트 삭제 함수
function deleteEvent(num) {
    if(confirm("이벤트를 삭제하시겠습니까?")) {
        location.href="${pageContext.request.contextPath}/admin/event/delete?num="+num;
    }
}

function applyEvent(num) {
    // 로그인 확인
    if(!memberidx) {
        if(confirm("로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?")) {
            location.href = "${pageContext.request.contextPath}/member/login";
        }
        return;
    }
    
    if(!confirm("이벤트를 신청하시겠습니까?")) {
        return;
    }
    
    const url = "${pageContext.request.contextPath}/event/apply";
    const requestParams = {
        num: num,
        memberidx: memberidx
    };
    
    // 버튼 상태 변경
    const applyButton = document.querySelector('.btn-apply');
    if(applyButton) {
        applyButton.disabled = true;
        applyButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 처리 중...';
    }
    
    const fn = function(data) {
        if(data.status === "success") {
            alert("이벤트 신청이 완료되었습니다.");
            // 성공 시 버튼 상태 업데이트
            if(applyButton) {
                applyButton.innerHTML = '<i class="fas fa-check"></i> 신청 완료';
                applyButton.classList.add('applied');
            }
        } else if(data.status === "duplicated") {
            alert("이미 신청한 이벤트입니다.");
            // 중복 신청 시 버튼 상태 업데이트
            if(applyButton) {
                applyButton.innerHTML = '<i class="fas fa-check"></i> 이미 신청 완료';
                applyButton.classList.add('applied');
            }
        } else {
            alert("신청 처리 중 오류가 발생했습니다.");
            // 실패 시 버튼 상태 복원
            if(applyButton) {
                applyButton.disabled = false;
                applyButton.innerHTML = '<i class="fas fa-check-circle"></i> 이벤트 신청하기';
            }
        }
    };
    
    // ajaxRequest 호출 (이미 정의된 함수 사용)
    ajaxRequest(url, 'post', requestParams, 'json', fn);
}

</script>
</body>
</html>