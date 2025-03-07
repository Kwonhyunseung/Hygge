<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 관리</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="stylesheet" href="/dist/css/admin/project/list.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        
        <div class="main-content">
        
            <div class="content-header">
                <h2>프로젝트 관리</h2>
                <span class="total-count">총 ${dataCount}개의 프로젝트</span>
                <div class="tab-buttons">
                    <button class="tab-button active" data-tab="pending">승인 대기</button>
                    <button class="tab-button" data-tab="reported">신고 누적</button>
                </div>        
            </div>
            
            <div class="content-body">
                <form name="searchForm" method="get" action="${pageContext.request.contextPath}/admin/projectManagement/list">
                    <div class="search-bar">
                        <select name="schType">
                            <option value="all" ${schType == 'all' ? 'selected' : ''}>전체</option>
                            <option value="title" ${schType == 'title' ? 'selected' : ''}>제목</option>
                            <option value="request_date" ${schType == 'request_date' ? 'selected' : ''}>요청일</option>
                        </select>
                        <div class="search-wrapper">
                            <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
                            <button type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>

                <!-- 승인 대기 프로젝트 -->
                <div id="pendingProjects" class="project-panel active"">
                    <div class="board-container">
                        <table>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="checkAll"></th>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>요청일</th>
                                    <th>승인일</th>
                                    <th>상태</th>
                                    <th>목표금액</th>
                                    <th>기간</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dto" items="${list}" varStatus="status">
                                    <tr>
                                        <td><input type="checkbox" name="selectedItems" value="${dto.num}"></td>
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
                                                    <span class="status-badge status-pending">대기중</span>
                                                </c:when>
                                                <c:when test="${dto.accept_return == 1}">
                                                    <span class="status-badge status-approved">승인</span>
                                                </c:when>
                                                <c:when test="${dto.accept_return == 0}">
                                                    <span class="status-badge status-rejected">반려</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${dto.target}" type="number"/>원
                                        </td>
                                        <td>${dto.term}일</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty dto.accept_return}">
                                                    <button type="button" class="approve-btn" 
                                                            onclick="approveProject(${dto.num}, ${dto.term})">
                                                        승인
                                                    </button>
                                                    <button type="button" class="reject-btn" 
                                                            onclick="rejectProject(${dto.num})">
                                                        반려
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="manage-btn" onclick="loadProjectDetails(${dto.num})">
                                                        관리
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- 신고 누적 프로젝트 -->
                <div id="reportedProjects" class="project-panel">
                    <div class="board-container">
                        <table>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="checkAllReported"></th>
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
                                    <td><input type="checkbox" name="selectedReported" value="1002"></td>
                                    <td>1002</td>
                                    <td>전자마트</td>
                                    <td><a href="#">무선이어폰</a></td>
                                    <td>8</td>
                                    <td>2024-02-05</td>
                                    <td><span class="status-badge status-warning">경고</span></td>
                                    <td>
                                        <button type="button" class="manage-btn" onclick="showReportDetails(1002)">
                                            신고내역
                                        </button>
                                        <button type="button" class="reject-btn" onclick="blockProject(1002)">
                                            중단
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="content-footer">
                    <div class="button-group">
                        <button class="deleteBtn" type="button">선택 삭제</button>
                        <button type="button">선택 숨김</button>
                    </div>
                    <div class="pagination">
                        ${paging}
                    </div>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="/WEB-INF/views/admin/project/modal.jsp"/>
<script type="text/javascript">
$(function(){
    // 전체 선택 체크박스 - 승인 대기
    $("#checkAll").on("click", function(){
        $("input[name=selectedItems]").prop("checked", $(this).prop("checked"));
    });
    
    // 개별 체크박스가 모두 선택되었는지 확인 - 승인 대기
    $(document).on("click", "input[name=selectedItems]", function(){
        let total = $("input[name=selectedItems]").length;
        let checked = $("input[name=selectedItems]:checked").length;
        
        $("#checkAll").prop("checked", total === checked);
    });
    
    // 전체 선택 체크박스 - 신고 누적
    $("#checkAllReported").on("click", function(){
        $("input[name=selectedReported]").prop("checked", $(this).prop("checked"));
    });
    
    // 개별 체크박스가 모두 선택되었는지 확인 - 신고 누적
    $(document).on("click", "input[name=selectedReported]", function(){
        let total = $("input[name=selectedReported]").length;
        let checked = $("input[name=selectedReported]:checked").length;
        
        $("#checkAllReported").prop("checked", total === checked);
    });
    
    // 선택 삭제 버튼 클릭 이벤트
    $(document).on("click", ".deleteBtn", function(){
        let items = [];
        
        // 현재 활성화된 탭에 따라 선택 대상 변경
        let activeTab = $(".tab-button.active").data("tab");
        let selector = activeTab === "pending" ? "selectedItems" : "selectedReported";
        
        // 선택된 항목의 값을 배열에 추가
        $("input[name=" + selector + "]:checked").each(function(){
            items.push($(this).val());
        });
        
        if(items.length === 0) {
            alert("삭제할 항목을 선택해주세요.");
            return;
        }
        
        if(!confirm("선택한 " + items.length + "개의 프로젝트를 삭제하시겠습니까?")) {
            return;
        }
        
        // 선택된 항목을 서버로 전송
        let url = "${pageContext.request.contextPath}/admin/projectManagement/deleteProjects";
        let query = {
            nums: items
        };
        
        const fn = function(data) {
            if(data.status === "success") {
                alert("선택한 프로젝트가 삭제되었습니다.");
                // 삭제 성공 시 해당 행 제거
                $("input[name=" + selector + "]:checked").each(function(){
                    $(this).closest("tr").fadeOut(300, function(){
                        $(this).remove();
                        
                        updateTotalCount();
                    });
                });
            } else {
                alert("프로젝트 삭제 중 오류가 발생했습니다.");
            }
        };
        
        ajaxRequest(url, 'post', query, 'json', fn);
    });
    
    // 총 프로젝트 수 업데이트 함수
    function updateTotalCount() {
        let activeTab = $(".tab-button.active").data("tab");
        let selector = "#" + activeTab + "Projects tbody tr";
        let currentCount = $(selector).length;
        $(".total-count").text("총 " + currentCount + "개의 프로젝트");
    }
    
    // 탭 버튼 클릭 이벤트
    $(".tab-button").on("click", function() {
        $(".tab-button").removeClass("active");
        $(this).addClass("active");
        
        let tab = $(this).data("tab");
        $(".project-panel").removeClass("active");
        $("#" + tab + "Projects").addClass("active");
        
        // 탭에 따라 총 개수 업데이트
        updateTotalCount();
    });
    
    // 모달은 부트스트랩에 의해 자동으로 처리됨
});

// 신고 내역 표시 함수
function showReportDetails(projectId) {
    $('#projectManagementModal').modal('show');
    
    // AJAX로 신고 내역 불러오기
    let url = "${pageContext.request.contextPath}/admin/projectManagement/reportDetails";
    let query = {
        num: projectId
    };
    
    const fn = function(data) {
        if(data.status === "success") {
            // 신고 내역 출력
            let html = '<h4>신고 내역</h4>';
            html += '<table class="table">';
            html += '<thead><tr><th>신고자</th><th>신고 사유</th><th>신고일</th></tr></thead>';
            html += '<tbody>';
            
            for(let item of data.reports) {
                html += '<tr>';
                html += '<td>' + item.reporter + '</td>';
                html += '<td>' + item.reason + '</td>';
                html += '<td>' + item.reportDate + '</td>';
                html += '</tr>';
            }
            
            html += '</tbody></table>';
            
            $("#projectDetails").html(html);
        } else {
            $("#projectDetails").html('<p>신고 내역을 불러오는 중 오류가 발생했습니다.</p>');
        }
    };
    
    // 실제 연동 시 주석 해제
    // ajaxRequest(url, 'get', query, 'json', fn);
    
    // 테스트용 출력
    let testData = {
        status: "success",
        reports: [
            { reporter: "사용자1", reason: "허위 정보 제공", reportDate: "2024-02-01" },
            { reporter: "사용자2", reason: "부적절한 콘텐츠", reportDate: "2024-02-03" },
            { reporter: "사용자3", reason: "사기 의심", reportDate: "2024-02-05" }
        ]
    };
    
    let html = '<h4>신고 내역</h4>';
    html += '<table class="table">';
    html += '<thead><tr><th>신고자</th><th>신고 사유</th><th>신고일</th></tr></thead>';
    html += '<tbody>';
    
    for(let item of testData.reports) {
        html += '<tr>';
        html += '<td>' + item.reporter + '</td>';
        html += '<td>' + item.reason + '</td>';
        html += '<td>' + item.reportDate + '</td>';
        html += '</tr>';
    }
    
    html += '</tbody></table>';
    
    $("#projectDetails").html(html);
}

// 프로젝트 중단 함수
function blockProject(projectId) {
    if(!confirm("정말 이 프로젝트를 중단시키겠습니까?")) {
        return;
    }
    
    let url = "${pageContext.request.contextPath}/admin/projectManagement/blockProject";
    let query = {
        num: projectId
    };
    
    const fn = function(data) {
        if(data.status === "success") {
            alert("프로젝트가 중단되었습니다.");
            // 페이지 새로고침 또는 해당 행 업데이트
            location.reload();
        } else {
            alert("프로젝트 중단 처리 중 오류가 발생했습니다.");
        }
    };
    
    // 실제 연동 시 주석 해제
    // ajaxRequest(url, 'post', query, 'json', fn);
    
    // 테스트용
    alert("프로젝트가 중단되었습니다.");
}

// 프로젝트 승인 함수
function approveProject(num, term) {
    if(!confirm("프로젝트를 승인하시겠습니까?")) {
        return;
    }
    
    const url = "${pageContext.request.contextPath}/admin/projectManagement/approve";
    const query = "num=" + num + "&term=" + term;
    
    const fn = function(data) {
        if(data.state === "success"){
            alert('프로젝트가 승인되었습니다.');
            location.reload();
        } else {
            alert('프로젝트 승인 처리가 실패했습니다.');
        }
    };
    
    ajaxRequest(url, 'post', query, 'json', fn);
}

// 프로젝트 반려 함수
function rejectProject(num) {
    const reason = prompt("반려 사유를 입력해주세요.");
    if(!reason) {
        return;
    }
    
    if(!confirm('프로젝트를 반려하시겠습니까?')) {
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

// 프로젝트 상세 정보 불러오기
function loadProjectDetails(projectNum) {
    // 직접 모달 표시
    var modalElement = document.getElementById('projectManagementModal');
    var modal = new bootstrap.Modal(modalElement);
    modal.show();

    html += '</div>';
    
    $("#projectDetails").html(html);
}

</script>
</body>
</html>