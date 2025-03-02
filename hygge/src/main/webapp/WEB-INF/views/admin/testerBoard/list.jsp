<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>체험단</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/experience/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style type="text/css">
    
.write-btn {
    text-decoration: none;
}

.button-group {
  display: flex;
  gap: 10px;
}

.applicant-btn {
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

.applicant-btn:hover {
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
                    <h2>체험단 관리</h2>
                    <span class="total-count">총 ${dataCount}개의 체험단</span>
                </div>
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/admin/experience/write" class="write-btn">
                        <i class="fas fa-plus"></i> 체험단 등록
                    </a>
                    <a href="#" class="applicant-btn" id="applicantBtn">
                        <i class="fas fa-users"></i> 신청자 관리
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

            <div class="experience-grid">
                <c:forEach var="dto" items="${list}">
                    <div class="experience-card">
                        <img src="${pageContext.request.contextPath}/uploads/experience/${dto.imageFilename}" alt="체험단 이미지" class="experience-image">
                        <div class="experience-info">
                            <div class="experience-title">
                                <a href="${pageContext.request.contextPath}/experience/article/${dto.num}">${dto.title}</a>
                            </div>
                            <div class="experience-date">
                                <i class="far fa-calendar-alt"></i>
                                <div class="experience-date">
                                <fmt:formatDate value="${dto.startDate}" pattern="yyyy-MM-dd"/> - 
                                <fmt:formatDate value="${dto.endDate}" pattern="yyyy-MM-dd"/>
                            </div>
                            </div>
                            <div class="experience-status">
                                <span class="status-badge ${dto.status == 1 ? 'status-active' : 'status-inactive'}">${dto.status == 1 ? '진행중' : '마감'}</span>
                                <div class="action-buttons">
                                    <button type="button" title="수정" onclick="location.href='${pageContext.request.contextPath}/admin/experience/update/${dto.num}'">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button type="button" title="삭제" onclick="deleteExperience(${dto.num})">
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
        
<!-- 신청자 관리 모달 -->
<div id="applicantModal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <h2>신청자 관리</h2>
        <form id="applicantForm">
            <div class="form-group">
                <label for="experienceId">체험단 제목</label>
                <select id="experienceId" name="experienceId">
                    <option value="">체험단을 선택하세요</option>
                    <c:forEach var="dto" items="${list}">
                        <option value="${dto.num}">${dto.title}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="memberName">신청자 목록</label>
                <select id="memberName" name="memberName">
                    <option value="">체험단을 먼저 선택하세요</option>
                    <!-- AJAX로 채워질 부분 -->
                </select>
            </div>
            <div class="form-group">
                <label for="applicationDate">신청 날짜</label>
                <input type="date" id="applicationDate" name="applicationDate" readonly>
            </div>
            <div class="form-group">
                <label for="status">상태</label>
                <select id="status" name="status">
                    <option value="pending">대기중</option>
                    <option value="approved">승인</option>
                    <option value="rejected">거절</option>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="submit-btn" id="submitApplicant">상태 변경</button>
            </div>
        </form>
    </div>
</div>

    <script>
    // 모달 관련 스크립트
    const modal = document.getElementById("applicantModal");
    const btn = document.getElementById("applicantBtn");
    const closeBtn = document.getElementsByClassName("close-btn")[0];
    const submitBtn = document.getElementById("submitApplicant");
    const experienceIdSelect = document.getElementById("experienceId");
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

    // 체험단 선택 시 해당 체험단에 신청한 회원 목록 가져오기
    experienceIdSelect.addEventListener('change', function() {
        const experienceId = this.value;
        console.log("선택된 체험단 ID:", experienceId);
        
        if(experienceId) {
            const url = "${pageContext.request.contextPath}/admin/experience/" + experienceId + "/applicants";
            console.log("요청 URL:", url);
            
            // AJAX 요청 전 상태 표시
            memberNameSelect.innerHTML = '<option value="">로딩 중...</option>';
            
            const fn = function(data) {
                console.log("응답 데이터:", data);
                
                // 멤버 선택 옵션 초기화
                memberNameSelect.innerHTML = '<option value="">신청자를 선택하세요</option>';
                
                // 응답 데이터로 멤버 옵션 추가
                if (data && data.length > 0) {
                    data.forEach(function(member) {
                        console.log("신청자 데이터:", member);
                        const option = document.createElement("option");
                        option.value = member.memberIdx;
                        option.textContent = member.name;
                        option.dataset.applicationDate = member.applicationDate;
                        option.dataset.status = member.status;
                        memberNameSelect.appendChild(option);
                    });
                } else {
                    console.log("신청자 데이터가 없거나 비어있습니다.");
                    memberNameSelect.innerHTML = '<option value="">신청자가 없습니다</option>';
                }
            };
            
            // ajaxRequest 호출
            ajaxRequest(url, 'GET', null, 'json', fn);
        } else {
            // 체험단 선택 해제 시 멤버 선택 초기화
            memberNameSelect.innerHTML = '<option value="">체험단을 먼저 선택하세요</option>';
        }
    });

    // 신청자 선택 시 관련 정보 표시
    memberNameSelect.addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        if (selectedOption.value) {
            const applicationDate = selectedOption.dataset.applicationDate;
            const status = selectedOption.dataset.status;
            
            document.getElementById("applicationDate").value = applicationDate;
            document.getElementById("status").value = status;
        }
    });
    
    // 체험단 삭제 함수
    function deleteExperience(num) {
        if (!confirm("정말 삭제하시겠습니까?")) {
            return;
        }
        
        const url = "${pageContext.request.contextPath}/admin/experience/delete/" + num;
        
        ajaxRequest(url, 'DELETE', null, 'json', function(response) {
            if (response.status === "success") {
                alert("체험단이 삭제되었습니다.");
                location.reload();
            } else {
                alert(response.message || "삭제 중 오류가 발생했습니다.");
            }
        });
    }
 
    // 신청자 상태 변경 처리
    submitBtn.onclick = function() {
        // 필수 입력값 확인
        if (!experienceIdSelect.value) {
            alert("체험단을 선택해주세요.");
            experienceIdSelect.focus();
            return;
        }
        
        if (!memberNameSelect.value) {
            alert("신청자를 선택해주세요.");
            memberNameSelect.focus();
            return;
        }
        
        const status = document.getElementById("status").value;
        
        const formData = {
            experienceNum: parseInt(experienceIdSelect.value),
            memberIdx: parseInt(memberNameSelect.value),
            status: status
        };
        
        console.log("신청자 상태 변경 데이터:", formData);
        
        // 제출 버튼 비활성화
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 처리 중...';
        
        // ajaxRequest 함수 사용
        ajaxRequest(
            "${pageContext.request.contextPath}/admin/experience/applicant/update", 
            "POST", 
            JSON.stringify(formData), 
            "json", 
            function(response) {
                console.log("상태 변경 응답:", response);
                
                if (response.status === "success") {
                    alert(response.message || "신청자 상태가 성공적으로 변경되었습니다.");
                    
                    // 상태 변경 후 신청자 목록 갱신
                    experienceIdSelect.dispatchEvent(new Event('change'));
                } else {
                    alert(response.message || "상태 변경 중 오류가 발생했습니다.");
                }
                
                // 제출 버튼 상태 복원
                submitBtn.disabled = false;
                submitBtn.innerHTML = '상태 변경';
            }, 
            false, 
            'json' 
        );
    }
    </script>
</body>
</html>