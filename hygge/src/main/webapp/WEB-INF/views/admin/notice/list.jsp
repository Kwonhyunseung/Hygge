<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

/* 페이징 스타일 */
.pagination-wrapper {
    display: flex;
    justify-content: center;
    width: 100%;
}

.pagination-wrapper .pagination {
    margin: 0;
}

.pagination .page-item .page-link {
    color: #333;
    border-radius: 4px;
    margin: 0 2px;
    transition: all 0.2s;
}

.pagination .page-item.active .page-link {
    background-color: #3498db;
    border-color: #3498db;
}

.pagination .page-item .page-link:hover {
    background-color: #f8f9fa;
    border-color: #3498db;
    color: #3498db;
}
</style>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/notice/list.css">
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
                <div class="content-title">
                    <h2>공지사항 관리</h2>
                    <span class="total-count">총 45개의 공지</span>
                </div>
                <button type="button" class="write-btn" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write';">
                    <i class="fas fa-pen"></i> 공지사항 작성
                </button>
            </div>

            <div class="content-body">
	            <div class="filter-section">
				    <form name="searchForm" action="${pageContext.request.contextPath}/admin/notice/list" method="get">
				        <div class="search-wrapper">
				            <select name="schType">
				                <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
				                <option value="title" ${schType=="title"?"selected":""}>제목</option>
				                <option value="content" ${schType=="content"?"selected":""}>내용</option>
				            </select>
				            <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
				            <button type="submit">
				                <i class="fas fa-search"></i>
				            </button>
				        </div>
				    </form>
				</div>

					
					<div class="board-container">
					    <table>
					        <thead>
					            <tr>
					                <th><input type="checkbox" id="checkAll"></th>
					                <th>번호</th>
					                <th>카테고리</th>
					                <th>제목</th>
					                <th>작성자</th>
					                <th>작성일</th>
					                <th>상단고정</th>
					                <th>관리</th>
					            </tr>
					        </thead>
					        <tbody>
					            <c:forEach var="dto" items="${list}" varStatus="status">
					                <tr>
					                    <td><input type="checkbox" name="selectedItems" value="${dto.num}"></td>
					                    <td>${dataCount - (page-1) * size - status.index}</td>
					                    <td><span class="category-badge general">일반</span></td>
					                    <td class="title">
					                        <a href="${articleUrl}&num=${dto.num}">${dto.title}</a>
					                    </td>
					                    <td>${dto.name}</td>
					                   		 <td><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd"/></td>
					                    <td>-</td>
					                    <td class="action-buttons">
					                        <button type="button" title="수정" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}';">
					                            <i class="fas fa-edit"></i>
					                        </button>
					                        <button type="button" title="삭제" onclick="deleteNotice(${dto.num});">
					                            <i class="fas fa-trash"></i>
					                        </button>
					                        <button type="button" title="상단고정">
					                            <i class="fas fa-thumbtack"></i>
					                        </button>
					                    </td>
					                </tr>
					            </c:forEach>
					        </tbody>
					    </table>
					</div>
					
					<div class="content-footer">
					    <div class="">
					   	 <button type="button" class="btn btn-danger" style="white-space: nowrap;" onclick="deleteList();">선택 삭제</button>
					    </div>
					    
					<div class="pagination-wrapper">
					        ${paging}
					    </div>						    
					</div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
$(document).ready(function() {
    // 전체 체크박스 클릭 이벤트
    $("#checkAll").click(function() {
        $("input[name='selectedItems']").prop("checked", this.checked);
    });
    
    // 개별 체크박스가 변경될 때 전체 선택 체크박스 상태 업데이트
    $(document).on('click', "input[name='selectedItems']", function() {
        const allChecked = $("input[name='selectedItems']").length === 
                          $("input[name='selectedItems']:checked").length;
        $("#checkAll").prop("checked", allChecked);
    });
});

function deleteList() {
    // 선택된 항목 체크
    const selectedItems = $("input[name='selectedItems']:checked");
    
    if (selectedItems.length === 0) {
        alert("삭제할 항목을 선택해주세요.");
        return;
    }
    
    if (!confirm("선택한 " + selectedItems.length + "개의 공지사항을 삭제하시겠습니까?")) {
        return;
    }
    
    // 선택된 항목의 ID 배열 생성
    const selectedIds = [];
    selectedItems.each(function() {
        selectedIds.push(Number($(this).val())); // Number로 타입 변환
    });
    
    // AJAX 요청
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/notice/deleteList",
        type: 'POST',
        contentType: 'application/json', // 명시적으로 JSON 타입 설정
        data: JSON.stringify({
            nums: selectedIds
        }),
        dataType: 'json',
        success: function(response) {
            if (response.status === "success") {
                alert("선택한 공지사항이 삭제되었습니다.");
                location.reload(); // 페이지 새로고침
            } else {
                alert("삭제 처리 중 오류가 발생했습니다: " + response.message);
            }
        },
        error: function(xhr, status, error) {
            alert("삭제 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

function deleteNotice(num) {
    if (!confirm("공지사항을 삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/notice/deleteList",
        type: 'POST',
        contentType: 'application/json', // 명시적으로 JSON 타입 설정
        data: JSON.stringify({
            nums: [num] // 단일 삭제의 경우 배열로 감싸기
        }),
        dataType: 'json',
        success: function(response) {
            if (response.status === "success") {
                alert("공지사항이 삭제되었습니다.");
                location.href = "${pageContext.request.contextPath}/admin/notice/list";
            } else {
                alert("삭제 처리 중 오류가 발생했습니다: " + response.message);
            }
        },
        error: function(xhr, status, error) {
            alert("삭제 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}
</script>
</html>