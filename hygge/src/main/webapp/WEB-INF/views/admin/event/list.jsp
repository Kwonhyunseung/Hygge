<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/event/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style type="text/css">
    
.write-btn {
    text-decoration: none;
}

.button-group {
  display: flex;
  gap: 10px;
}

.coupon-btn {
  background: #2ecc71;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  text-decoration: none;
}

.coupon-btn:hover {
  background: #27ae60;
}

/* 모달 스타일 */
.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.5);
}

.modal-content {
  background-color: white;
  margin: 10% auto;
  padding: 20px;
  width: 50%;
  border-radius: 10px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.close-btn {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close-btn:hover {
  color: black;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

.form-group input, .form-group select {
  width: 100%;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.modal-footer {
  text-align: right;
  margin-top: 20px;
}

.submit-btn {
  background: #3498db;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
}

.submit-btn:hover {
  background: #2980b9;
}
</style>

</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        
        <div class="main-content">
            <div class="content-header">
                <div class="content-title">
                    <h2>이벤트 관리</h2>
                    <span class="total-count">총 ${dataCount}개의 이벤트</span>
                </div>
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/admin/event/write" class="write-btn">
                        <i class="fas fa-plus"></i> 이벤트 등록
                    </a>
                    <a href="#" class="coupon-btn" id="couponBtn">
                        <i class="fas fa-ticket-alt"></i> 쿠폰 등록
                    </a>
                </div>
            </div>

            <div class="filter-section">
                <form name="searchForm" action="" method="get">
                    <div class="search-wrapper">
                        <select name="schType">
                            <option value="all">전체</option>
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" name="kwd" placeholder="검색어를 입력하세요">
                        <button type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

            <div class="event-grid">
                <c:forEach var="dto" items="${list}">
                    <div class="event-card">
                        <img src="${pageContext.request.contextPath}/uploads/event/${dto.photo}" alt="이벤트 이미지" class="event-image">
                        <div class="event-info">
                            <div class="event-title">
                                <a href="${pageContext.request.contextPath}/event/article/${dto.num}">${dto.title}</a>
                            </div>
                            <div class="event-date">
                                <i class="far fa-calendar-alt"></i>
                                <div class="event-date">
                                <fmt:formatDate value="${dto.evt_date}" pattern="yyyy-MM-dd"/> - 
                                <fmt:formatDate value="${dto.exp_date}" pattern="yyyy-MM-dd"/>
                            </div>
                            </div>
  <div class="event-status">
    <span class="status-badge status-active">진행중</span>
    <div class="action-buttons">
        <button type="button" title="수정" onclick="updateEvent(${dto.num})">
            <i class="fas fa-edit"></i>
        </button>
        <button type="button" title="삭제" onclick="deleteEvent(${dto.num})">
            <i class="fas fa-trash"></i>
        </button>
    </div>
</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <div class="page-navigation">
                <a class="pagination">${paging}</a>
            </div>                
        </div>
    </div>
        
<!-- 쿠폰 등록 모달 -->
<div id="couponModal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <h2>쿠폰 등록</h2>
        <form id="couponForm">
            <div class="form-group">
                <label for="eventId">이벤트 제목</label>
                <select id="eventId" name="eventId">
                    <option value="">이벤트를 선택하세요</option>
                    <c:forEach var="dto" items="${list}">
                        <option value="${dto.num}">${dto.title}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="memberName">회원 이름</label>
                <select id="memberName" name="memberName">
                    <option value="">회원을 선택하세요</option>
                    <!-- AJAX로 채워질 부분 -->
                </select>
            </div>
            <div class="form-group">
                <label for="issueDate">발급 날짜</label>
                <input type="date" id="issueDate" name="issueDate" required>
            </div>
            <div class="form-group">
                <label for="discountRate">할인율 (%)</label>
                <input type="number" id="discountRate" name="discountRate" min="0" max="100" required>
            </div>
            <div class="form-group">
                <label for="maxDiscount">할인 최대 금액 (원)</label>
                <input type="number" id="maxDiscount" name="maxDiscount" min="0" required>
            </div>
            <div class="modal-footer">
                <button type="button" class="submit-btn" id="submitCoupon">등록</button>
            </div>
        </form>
    </div>
</div>

    <script>
    // 모달 관련 스크립트
    const modal = document.getElementById("couponModal");
    const btn = document.getElementById("couponBtn");
    const closeBtn = document.getElementsByClassName("close-btn")[0];
    const submitBtn = document.getElementById("submitCoupon");
    const eventIdSelect = document.getElementById("eventId");
    const memberNameSelect = document.getElementById("memberName");

    // 모달 열기
    btn.onclick = function() {
        modal.style.display = "block";
    }

    // 모달 닫기
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

 // 이벤트 선택 시 해당 이벤트에 참여한 회원 목록 가져오기
    eventIdSelect.addEventListener('change', function() {
        const eventId = this.value;
        console.log("선택된 이벤트 ID:", eventId);
        
        if(eventId) {
            const url = "${pageContext.request.contextPath}/admin/event/" + eventId + "/members";
            console.log("요청 URL:", url);
            
            // AJAX 요청 전 상태 표시 (선택사항)
            memberNameSelect.innerHTML = '<option value="">로딩 중...</option>';
            
            const fn = function(data) {
                console.log("응답 데이터:", data);
                
                // 멤버 선택 옵션 초기화
                memberNameSelect.innerHTML = '<option value="">회원을 선택하세요</option>';
                
                // 응답 데이터로 멤버 옵션 추가
                if (data && data.length > 0) {
                    data.forEach(function(member) {
                        console.log("회원 데이터:", member);
                        const option = document.createElement("option");
                        option.value = member.memberIdx;
                        option.textContent = member.name;
                        memberNameSelect.appendChild(option);
                    });
                } else {
                    console.log("회원 데이터가 없거나 비어있습니다.");
                    memberNameSelect.innerHTML = '<option value="">참여한 회원이 없습니다</option>';
                }
            };
            
            // ajaxRequest 호출
            ajaxRequest(url, 'GET', null, 'json', fn);
        } else {
            // 이벤트 선택 해제 시 멤버 선택 초기화
            memberNameSelect.innerHTML = '<option value="">회원을 선택하세요</option>';
        }
    });

    // 디버깅을 위한 즉시 실행 코드 (테스트 후 제거)
    console.log("이벤트 핸들러가 설정되었습니다. eventIdSelect =", eventIdSelect);

    
 // 쿠폰 등록 제출 처리
    submitBtn.onclick = function() {
        // 필수 입력값 확인
        if (!eventIdSelect.value) {
            alert("이벤트를 선택해주세요.");
            eventIdSelect.focus();
            return;
        }
        
        if (!memberNameSelect.value) {
            alert("회원을 선택해주세요.");
            memberNameSelect.focus();
            return;
        }
        
        const issueDate = document.getElementById("issueDate").value;
        if (!issueDate) {
            alert("발급 날짜를 입력해주세요.");
            document.getElementById("issueDate").focus();
            return;
        }
        
        const discountRate = document.getElementById("discountRate").value;
        if (!discountRate) {
            alert("할인율을 입력해주세요.");
            document.getElementById("discountRate").focus();
            return;
        }
        
        const maxDiscount = document.getElementById("maxDiscount").value;
        if (!maxDiscount) {
            alert("할인 최대 금액을 입력해주세요.");
            document.getElementById("maxDiscount").focus();
            return;
        }
        
        const formData = {
            num: parseInt(eventIdSelect.value),
            memberIdx: parseInt(memberNameSelect.value),
            issue_date: issueDate,
            discount_rate: parseInt(discountRate),
            discount: parseInt(maxDiscount)
        };
        
        console.log("쿠폰 등록 데이터:", formData);
        
        // 제출 버튼 비활성화
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 처리 중...';
        
        // ajaxRequest 함수 사용
        // 중요: contentType 매개변수에 'json'만 전달해야 함 (application/json이 아님)
        ajaxRequest(
            "${pageContext.request.contextPath}/admin/coupon/insert", 
            "POST", 
            JSON.stringify(formData), 
            "json", 
            function(response) {
                console.log("쿠폰 등록 응답:", response);
                
                if (response.status === "success") {
                    alert(response.message || "쿠폰이 성공적으로 등록되었습니다.");
                    modal.style.display = "none";
                    document.getElementById("couponForm").reset();
                } else {
                    alert(response.message || "쿠폰 등록 중 오류가 발생했습니다.");
                }
                
                // 제출 버튼 상태 복원
                submitBtn.disabled = false;
                submitBtn.innerHTML = '등록';
            }, 
            false, 
            'json' 
        );
    }
 
 // 이벤트 수정 함수
function updateEvent(num) {
    location.href = "${pageContext.request.contextPath}/admin/event/update?num=" + num;
}

// 이벤트 삭제 함수
function deleteEvent(num) {
    if(confirm("이벤트를 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/admin/event/delete?num=" + num;
    }
}
    </script>
</body>
</html>