<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.tab-buttons {
    display: flex;
    gap: 10px;
}

.tab-button {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
}

.tab-button.active {
    background: #34495e;
    color: white;
    border-color: #34495e;
}

.tab-button:hover {
    background-color: #2ecc71;
}


</style>
<meta charset="UTF-8">
<title>중고게시판 관리</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="stylesheet" href="/dist/css/admin/usedBoard/usedList.css">
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
                <h2>중고게시판 관리</h2>
                <span class="total-count">총 ${dataCount}개의 게시글</span>
	            <div class="tab-buttons">
			    <button class="tab-button" data-tab="reported">신고 누적</button>
			    <button class="tab-button" data-tab="trade-status">거래 현황</button>
			    <button class="tab-button" onclick="${pageContext.request.contextPath}/admin">게시글</button>
			</div>        
            </div>
            
            <div class="content-body">
			<form name="searchForm" method="get" action="${pageContext.request.contextPath}/admin/usedBoard/list">
			    <div class="search-bar">
			        <select name="schType">
			            <option value="title" ${schType == 'title' ? 'selected' : ''}>제목</option>
			            <option value="writer" ${schType == 'writer' ? 'selected' : ''}>작성자</option>
			            <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
			        </select>
			        <div class="search-wrapper">
			            <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
			            <button type="submit">
			                <i class="fas fa-search"></i>
			            </button>
			        </div>
			    </div>
			</form>

			<div class="board-container">
			    <table>
			        <thead>
			            <tr>
			                <th><input type="checkbox" id="checkAll"></th>
			                <th>번호</th>
			                <th>제목</th>
			                <th>작성자</th>
			                <th>분류</th>
			                <th>상태</th>
			                <th>등록일</th>
			                <th>조회수</th>
			                <th>관리</th>
			            </tr>
			        </thead>
					<tbody>
					    <c:forEach var="board" items="${dto}" varStatus="status">
					        <tr>
					            <td><input type="checkbox" name="selectedItems" value="${board.board_num}"></td>
					            <td>${board.board_num}</td>
					            <td>
								    <a href="${pageContext.request.contextPath}/usedBoard/article?page=${page}&num=${board.board_num}">${board.title}</a>
								</td>
					            <td>${board.nickName}</td>
					            <c:choose>
					                <c:when test="${board.category == 0}">
					                    <td><span class="status-badge status-selling">판매</span></td>
					                </c:when>
					                <c:when test="${board.category == 1}">
					                    <td><span class="status-badge status-selling">구매</span></td>
					                </c:when>
					            </c:choose>					            
					            <c:choose>
					                <c:when test="${board.deal == 0}">
					                    <td><span class="status-badge status-selling">미거래</span></td>
					                </c:when>
					                <c:when test="${board.deal == 1}">
					                    <td><span class="status-badge status-selling">대기중</span></td>
					                </c:when>
					                <c:when test="${board.deal == -1}">
					                    <td><span class="status-badge status-selling">거래완료</span></td>
					                </c:when>
					            </c:choose>
					            <td>${board.reg_date}</td>
					            <td>${board.hitCount}</td>
					            <td class="action-buttons">
					                <button type="button"><i class="fas fa-eye"></i></button>
					                <button type="button"><i class="fas fa-edit"></i></button>
					                <button type="button"><i class="fas fa-trash"></i></button>
					            </td>
					        </tr>
					    </c:forEach>
					</tbody>
			    </table>
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
</body>

<script type="text/javascript">
$(function(){
    // 전체 선택 체크박스
    $("#checkAll").on("click", function(){
        $("input[name=selectedItems]").prop("checked", $(this).prop("checked"));
    });
    
    // 개별 체크박스가 모두 선택되었는지 확인
    $(document).on("click", "input[name=selectedItems]", function(){
        let total = $("input[name=selectedItems]").length;
        let checked = $("input[name=selectedItems]:checked").length;
        
        $("#checkAll").prop("checked", total === checked);
    });
    
    // 선택 삭제 버튼 클릭 이벤트
    $(document).on("click", ".deleteBtn", function(){
        let items = [];
        
        // 선택된 항목의 board_num 값을 배열에 추가
        $("input[name=selectedItems]:checked").each(function(){
            items.push($(this).val());
        });
        
        if(items.length === 0) {
            alert("삭제할 항목을 선택해주세요.");
            return;
        }
        
        if(!confirm("선택한 " + items.length + "개의 게시글을 삭제하시겠습니까?")) {
            return;
        }
        
        // 선택된 항목을 서버로 전송
        let url = "${pageContext.request.contextPath}/admin/usedBoard/deleteBoards";
        let query = {
        	board_num : items
        };
        
        const fn = function(data) {
            if(data.status === "success") {
                alert("선택한 게시글이 삭제되었습니다.");
                // 삭제 성공 시 해당 행 제거
                $("input[name=selectedItems]:checked").each(function(){
                    $(this).closest("tr").fadeOut(300, function(){
                        $(this).remove();
                        
                        updateTotalCount();
                    });
                });
            } else {
                alert("게시글 삭제 중 오류가 발생했습니다.");
            }
        };
        
        ajaxRequest(url, 'post', query, 'json', fn);
    });
    
    // 총 게시글 수 업데이트 함수
    function updateTotalCount() {
        let currentCount = $("tbody tr").length;
        $(".total-count").text("총 " + currentCount + "개의 게시글");
    }
});


// 선택적: 신고된 게시물 로드 함수
function loadReportedPosts() {
    let url = "${pageContext.request.contextPath}/admin/usedBoard/reportedPosts";
    
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function(data) {
            renderReportedPostsTable(data);
        },
        error: function(xhr, status, error) {
            console.error("신고된 게시물 로드 중 오류 발생:", error);
            alert("신고된 게시물을 불러오는 중 오류가 발생했습니다.");
        }
    });
}

$(function(){
    // 탭 버튼 클릭 이벤트 추가
    $(".tab-buttons").on("click", ".tab-button", function() {
        $(".tab-button").removeClass("active");
        $(this).addClass("active");
        
        let tab = $(this).data("tab");
        
        if(tab === "trade-status") {
            loadPurchaseStatus();
        }
        
    });
});

function loadPurchaseStatus() {
    let url = "${pageContext.request.contextPath}/admin/usedBoard/purchaseStatus";
    
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function(data) {
            renderPurchaseStatusTable(data);
        },
        error: function(xhr, status, error) {
            console.error("거래 현황 로드 중 오류 발생:", error);
            alert("거래 현황을 불러오는 중 오류가 발생했습니다.");
        }
    });
}

function renderPurchaseStatusTable(data) {
    let tableHead = $(".board-container table thead");
    let tbody = $(".board-container table tbody");
    
    // 테이블 헤더 업데이트
    tableHead.html(`
        <tr>
            <th><input type="checkbox" id="checkAll"></th>
            <th>번호</th>
            <th>글 제목</th>
            <th>상품 명</th>
            <th>판매자</th>
            <th>구매자</th>
            <th>가격</th>
            <th>거래 상태</th>
            <th>관리</th>
        </tr>
    `);
    
    // 기존 체크박스 전체 선택 이벤트 재설정
    $("#checkAll").on("click", function(){
        $("input[name=selectedItems]").prop("checked", $(this).prop("checked"));
    });
    
    // 테이블 바디 업데이트
    tbody.empty();
    
    data.forEach(function(item) {
        let progressText = item.progress === 0 ? '대기중' : 
                           item.progress === 9 ? '거래완료' :
        
        let row = 
            '<tr>' +
                '<td><input type="checkbox" name="selectedItems" value="' + item.board_num + '"></td>' +
                '<td>' + item.board_num + '</td>' +
                '<td>' + item.title + '</td>' +
                '<td>' + (item.product || '미지정') + '</td>' +
                '<td>' + item.nickName + '</td>' +
                '<td>' + (item.buyerNickName || '없음') + '</td>' +
                '<td>' + (item.price ? item.price.toLocaleString() + '원' : '가격 미정') + '</td>' +
                '<td>' +
                    '<span class="status-badge status-' + 
                         progressText === '대기중' ? 'progress' : 
                         'completed') + 
                    '">' + 
                        progressText + 
                    '</span>' +
                '</td>' +
                '<td class="action-buttons">' +
                    (progressText === '대기중' ? 
                        '<button type="button" class="approve-btn" data-board-num="' + item.board_num + '">승인</button>' +
                        '<button type="button" class="reject-btn" data-board-num="' + item.board_num + '">거절</button>' : 
                        '') +
                '</td>' +
            '</tr>';
        
        tbody.append(row);
    });
    
    // 총 게시글 수 업데이트
    $(".total-count").text("총 " + data.length + "개의 거래");

    // 승인 버튼 클릭 이벤트
    $(".approve-btn").on("click", function() {
        let boardNum = $(this).data("board-num");
        handleTradeStatus(boardNum, 'approve');
    });

    // 거절 버튼 클릭 이벤트
    $(".reject-btn").on("click", function() {
        let boardNum = $(this).data("board-num");
        handleTradeStatus(boardNum, 'reject');
    });
}

// 거래 상태 처리 함수
function handleTradeStatus(boardNum, action) {
    let url = "${pageContext.request.contextPath}/admin/usedBoard/updateTradeStatus";
    let query = {
        board_num: boardNum,
        action: action
    };

    const fn = function(data) {
        if(data.status === "success") {
            alert(action === 'approve' ? "거래가 승인되었습니다." : "거래가 거절되었습니다.");
            // 거래 현황 새로고침
            loadPurchaseStatus();
        } else {
            alert("거래 상태 업데이트 중 오류가 발생했습니다.");
        }
    };

    ajaxRequest(url, 'post', query, 'json', fn);
}

</script>
</html>