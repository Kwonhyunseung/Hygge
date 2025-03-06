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
                 <span class="total-count">총 7개의 후기</span>
                <%-- <span class="total-count">총 ${dataCount}개의 후기</span>--%>
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
                        <!-- Replace the empty tbody with this: -->
<tbody>
    <tr>
        <td><input type="checkbox" name="selectedItems" value="1001"></td>
        <td>23</td>
        <td>주방용품</td>
        <td>우아한 티타임: 전통과 현대가 만난 프리미엄 티포트</td>
        <td>티백장인</td>
        <td class="review-content">구매 후 매일 사용중입니다. 보온 유지 시간이 생각보다 길어서 만족해요. 색상도 고급스럽고 손잡이 디자인이 잡기 편해서 좋네요. 다만 세척할 때 조금 신경써야 하는 점이 아쉽습니다.</td>
        <td>2023-11-15</td>
        <td class="report-count">2</td>
        <td class="action-buttons">
            <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
            <button type="button" title="차단"><i class="fas fa-ban"></i></button>
        </td>
    </tr>
    <tr>
        <td><input type="checkbox" name="selectedItems" value="1002"></td>
        <td>22</td>
        <td>주방용품</td>
        <td>일상의 작은 행복, 매일의 식사가 특별해지는 접시</td>
        <td>행복한식탁</td>
        <td class="review-content">너무 이쁘고 감각적인 디자인이에요! 친구들이 집에 놀러오면 항상 어디서 샀냐고 물어봐요. 다만 생각보다 무게가 있어서 설거지할 때 조금 불편한 점이 있네요. 그래도 인스타 감성 제대로 살릴 수 있어서 대만족입니다!</td>
        <td>2023-12-03</td>
        <td class="report-count">0</td>
        <td class="action-buttons">
            <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
            <button type="button" title="차단"><i class="fas fa-ban"></i></button>
        </td>
    </tr>
    <tr>
        <td><input type="checkbox" name="selectedItems" value="1003"></td>
        <td>19</td>
        <td>인테리어</td>
        <td>[MZ초인기] 무지 팔레트 디자인 액자</td>
        <td>인테리어덕후</td>
        <td class="review-content">이 액자 진짜 미쳤습니다. 제 방 분위기가 완전 바뀌었어요! 팔레트 색상 조합이 정말 세련되고 어떤 공간에도 잘 어울리는 것 같아요. 배송도 안전하게 잘 왔고, 액자 프레임 품질도 생각보다 훨씬 좋네요. 친구들 선물용으로도 몇 개 더 구매할 예정입니다.</td>
        <td>2024-01-17</td>
        <td class="report-count">1</td>
        <td class="action-buttons">
            <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
            <button type="button" title="차단"><i class="fas fa-ban"></i></button>
        </td>
    </tr>
    <tr>
        <td><input type="checkbox" name="selectedItems" value="1004"></td>
        <td>17</td>
        <td>뷰티</td>
        <td>[하루 5분의 기적] 라인이 매끈해지는 V컷! 동안 괄사</td>
        <td>동안피부지킴이</td>
        <td class="review-content">이거 진짜 효과 있어요!!!! 2주 사용했는데 턱선이 확실히 달라졌어요. 처음엔 힘 조절을 잘 못해서 피부가 좀 빨개졌는데, 익숙해지니 괜찮아졌어요. 무조건 유튜브 영상 보고 따라하세요. 제조사에서 제공하는 괄사 오일도 함께 쓰면 더 좋아요. 역시 입소문난 제품은 이유가 있네요~</td>
        <td>2024-02-05</td>
        <td class="report-count">8</td>
        <td class="action-buttons">
            <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
            <button type="button" title="차단"><i class="fas fa-ban"></i></button>
        </td>
    </tr>
    <tr>
        <td><input type="checkbox" name="selectedItems" value="1005"></td>
        <td>15</td>
        <td>가전</td>
        <td>[헤어드라이기의 혁명] 카이스트 헤어학과 박사들이 개발한 음이온 드라이기</td>
        <td>머릿결장인</td>
        <td class="review-content">가격이 좀 비싸서 고민 많이 했는데 정말 돈이 아깝지 않네요. 건조 시간이 절반으로 줄었고, 머릿결도 확실히 달라졌어요. 소음도 기존 드라이기보다 훨씬 적고 손목에 무리가 덜 가는 게 느껴집니다. 음이온 효과가 실제로 있는지는 모르겠지만 머리가 덜 부스스해지는 것 같아요. 다만 AS나 품질보증 관련 안내가 좀 부족한 느낌이에요.</td>
        <td>2024-03-10</td>
        <td class="report-count">12</td>
        <td class="action-buttons">
            <button type="button" title="상세보기"><i class="fas fa-eye"></i></button>
            <button type="button" title="차단"><i class="fas fa-ban"></i></button>
        </td>
    </tr>
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