<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/review/reviewList.css">
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
                <h2>후기 관리</h2>
                <span class="total-count">총 ${dataCount}개의 후기</span>
            </div>
            <div class="content-body">
                <div class="filter-section">
                	<form name="searchForm" action="${pageContext.request.contextPath}/admin/review/list" method="get">
						<div class="category-filter">
						  <select name="category">
						    <option value="">카테고리 선택</option>
						    	<c:forEach var="category" items="${categories}">
						    <option value="${category.category_name}" ${category.category_name == param.category ? 'selected' : ''}>${category.category_name}</option>
						    </c:forEach>
						  </select>
						  <select name="schType">
					        <option value="all" ${schType == 'all' ? 'selected' : ''}>전체</option>
					        <option value="nickname" ${schType == 'nickname' ? 'selected' : ''}>닉네임</option>
					        <option value="project_title" ${schType == 'project_title' ? 'selected' : ''}>프로젝트명</option>
					        <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
					        <option value="reg_date" ${schType == 'reg_date' ? 'selected' : ''}>등록일</option>
						  </select>
					      <select name="reportFilter">
					        <option value="all" ${reportFilter == 'all' ? 'selected' : ''}>신고 횟수</option>
					        <option value="5more" ${reportFilter == '5more' ? 'selected' : ''}>5회 이상</option>
					        <option value="10more" ${reportFilter == '10more' ? 'selected' : ''}>10회 이상</option>
					      </select>
						  <div class="search-wrapper">
	                    <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력해주세요.">
	                        <button type="submit" id="searchBtn">
	                            <i class="fas fa-search"></i>
	                        </button>
	                    </div>
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
                                <th>프로젝트 이름</th>
                                <th>닉네임</th>
                                <th>후기내용</th>
                                <th>등록일</th>
                                <th>신고수</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${review}" varStatus="status">
                                <tr>
                                    <td><input type="checkbox" name="selectedItems" value="${item.review_num}"></td>
                                    <td>${item.review_num}</td>
                                    <td>${item.category_name}</td>
                                    <td>${item.project_title}</td>
                                    <td>${item.nickName}</td>
                                    <td class="review-content">${item.content}</td>
                                    <td>${item.reg_date}</td>
                                    <td class="report-count">${item.report_count}</td>
                                    <td class="action-buttons">
                                        <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
                                        <button type="button" title="차단"><i class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty review}">
                                <tr>
                                    <td colspan="9" class="no-data">등록된 후기가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
                    <div class="button-group">
                        <button type="button">선택 삭제</button>
                        <button type="button">선택 차단</button>
                    </div>
                    <div class="pagination">
                    	${paging}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<script>
// 체크박스 전체 선택/해제 기능
document.getElementById('checkAll').addEventListener('click', function() {
	const checkboxes = document.querySelectorAll('input[name="selectedItems"]');
	checkboxes.forEach(checkbox => {
		checkbox.checked = this.checked;
            });
        });
</script>
<script type="text/javascript">

$(document).ready(function(){
	$('.button-group button:nth-child(1)').click(function(){
		const selectedItems = [];
		
		$('input[name="selectedItems"]:checked').each(function(){
			selectedItems.push($(this).val());
		});
		
		if(selectedItems.length === 0) {
			alert('삭제할 후기를 선택해주세요.')
			return;
		}
		
		if(!confirm('선택한' + selectedItems.length + '개의 후기를 삭제하시겠습니까?')) {
			return;
		}
		
		const url = '${pageContext.request.contextPath}/admin/review/deleteReviews';
        const query = {
            reviewIds: selectedItems
        };
        
		const fn = function(data) {
			if(data.status === 'success') {
				alert('선택한 후기가 성공적으로 삭제되었습니다.');
				location.reload();
			} else {
				alert('후기 삭제 중 오류가 발생했습니다: ' + data.message);
			}
		};
		
		ajaxRequest(url, 'post', query, 'json', fn)
		
	});
});

// 선택 차단 버튼 클릭 이벤트
$('.button-group button:nth-child(2)').click(function() {
    handleStatusChange('blocked', '차단');
});


function handleStatusChange(status, actionName) {
	const selectedItems = [];
	
	$('input[name="selectedItems"]:checked').each(function(){
		selectedItems.push($(this).val());
	});
	
	// 선택된 항목이 없는 경우
    if(selectedItems.length === 0) {
        alert(actionName + '할 후기를 선택해주세요.');
        return;
    }
	
    if(!confirm('선택한 ' + selectedItems.length + '개의 후기를 ' + actionName + '하시겠습니까?')) {
        return;
    }
	
    const url = '${pageContext.request.contextPath}/admin/review/updateStatus';
    const query = {
        reviewIds: selectedItems,
        status: status
    };
    
    const fn = function(data) {
        if(data.status === 'success') {
            alert('선택한 후기가 성공적으로 ' + actionName + ' 되었습니다.');
            location.reload();
        } else {
            alert('후기 ' + actionName + ' 중 오류가 발생했습니다: ' + data.message);
        }
    };
    
    ajaxRequest(url, 'post', query, 'json', fn);
}

$(document).ready(function() {
    $('.action-buttons button:nth-child(2)').click(function() {
        const reviewRow = $(this).closest('tr');
        const reviewId = reviewRow.find('input[name="selectedItems"]').val();
        const memberNickname = reviewRow.find('td:nth-child(5)').text();
        
        if(!confirm(memberNickname + ' 회원을 차단하시겠습니까?')) {
            return;
        }
        
        blockMember([reviewId], memberNickname);
    });
    
    $('.button-group button:nth-child(2)').click(function() {
        const selectedItems = [];
        const selectedMembers = [];
        
        $('input[name="selectedItems"]:checked').each(function() {
            const reviewId = $(this).val();
            const memberNickname = $(this).closest('tr').find('td:nth-child(5)').text();
            
            selectedItems.push(reviewId);
            if(!selectedMembers.includes(memberNickname)) {
                selectedMembers.push(memberNickname);
            }
        });
        
        if(selectedItems.length === 0) {
            alert('차단할 회원의 후기를 선택해주세요.');
            return;
        }
        
        if(!confirm('선택한 ' + selectedMembers.length + '명의 회원을 차단하시겠습니까?')) {
            return;
        }
        
        blockMember(selectedItems, selectedMembers.join(', '));
    });
    
    // 회원 차단
    function blockMember(reviewIds, memberInfo) {
        const url = '${pageContext.request.contextPath}/admin/review/blockMember';
        const query = {
            reviewIds: reviewIds
        };
        
        const fn = function(data) {
            if(data.status === 'success') {
                alert(memberInfo + ' 회원이 성공적으로 차단되었습니다.');
                location.reload();
            } else {
                alert('회원 차단 중 오류가 발생했습니다: ' + data.message);
            }
        };
        
        ajaxRequest(url, 'post', query, 'json', fn);
    }
});

    
</script>
</body>
</html>