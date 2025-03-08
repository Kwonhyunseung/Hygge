<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메이커 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/maker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/normal.css">
    <!-- 부트스트랩 아이콘 CSS 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- 추가 CSS 스타일 -->
    <style>
    .content-title {
    font-size: 24px;
    font-weight: bold;
    color: #2c3e50;
    margin-bottom: 10px;
}
        /* 관리 버튼 스타일 */
        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .action-buttons button {
            padding: 6px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .detail-btn {
            background: #f5f5f5;
            color: #616161;
        }

        .approve-btn {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .reject-btn {
            background: #ffebee;
            color: #c62828;
        }

        .action-buttons button:hover {
            opacity: 0.8;
        }

        /* 보기 버튼 스타일 */
        .view-button {
            padding: 6px;
            border: none;
            border-radius: 4px;
            background: #e3f2fd;
            color: #1976d2;
            cursor: pointer;
        }

        .view-button:hover {
            opacity: 0.8;
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
        <div class="content-title">메이커 신청</div>
        <div class="search-container">
            <form class="search-form">
                <select class="search-input">
                    <option>전체</option>
                    <option>승인대기</option>
                    <option>승인완료</option>
                    <option>승인거절</option>
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
                    <th>신청일</th>
                    <th>프로젝트</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            
            
            <tbody>
                <!-- 하드코딩된 샘플 데이터 -->
                <tr data-project-num="1001">
                    <td>10001</td>
                    <td>김창작</td>
                    <td>create.kim@example.com</td>
                    <td>2023-09-15</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10001)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-pending">대기중</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10001)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                        <button type="button" class="approve-btn" title="승인" onclick="approveMaker(10001)">
                            <i class="fas fa-check"></i>
                        </button>
                        <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(10001,1001)">
                            <i class="fas fa-times"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1002">
                    <td>10002</td>
                    <td>박디자인</td>
                    <td>design.park@example.com</td>
                    <td>2023-09-16</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10002)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-approved">승인완료</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10002)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1003">
                    <td>10003</td>
                    <td>이혁신</td>
                    <td>innovation.lee@example.com</td>
                    <td>2023-09-17</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10003)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-rejected">승인거절</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10003)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1004">
                    <td>10004</td>
                    <td>정아트</td>
                    <td>art.jung@example.com</td>
                    <td>2023-09-18</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10004)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-pending">대기중</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10004)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                        <button type="button" class="approve-btn" title="승인" onclick="approveMaker(10004)">
                            <i class="fas fa-check"></i>
                        </button>
                        <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(10004,1004)">
                            <i class="fas fa-times"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1005">
                    <td>10005</td>
                    <td>최개발</td>
                    <td>dev.choi@example.com</td>
                    <td>2023-09-19</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10005)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-approved">승인완료</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10005)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1006">
                    <td>10006</td>
                    <td>한프로젝트</td>
                    <td>project.han@example.com</td>
                    <td>2023-09-20</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10006)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-pending">대기중</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10006)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                        <button type="button" class="approve-btn" title="승인" onclick="approveMaker(10006)">
                            <i class="fas fa-check"></i>
                        </button>
                        <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(10006,1006)">
                            <i class="fas fa-times"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1007">
                    <td>10007</td>
                    <td>윤크리에이터</td>
                    <td>creator.yoon@example.com</td>
                    <td>2023-09-21</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10007)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-rejected">승인거절</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10007)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1008">
                    <td>10008</td>
                    <td>송메이커</td>
                    <td>maker.song@example.com</td>
                    <td>2023-09-22</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10008)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-approved">승인완료</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10008)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1009">
                    <td>10009</td>
                    <td>조스타트</td>
                    <td>startup.jo@example.com</td>
                    <td>2023-09-23</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10009)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-pending">대기중</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10009)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                        <button type="button" class="approve-btn" title="승인" onclick="approveMaker(10009)">
                            <i class="fas fa-check"></i>
                        </button>
                        <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(10009,1009)">
                            <i class="fas fa-times"></i>
                        </button>
                    </td>
                </tr>
                <tr data-project-num="1010">
                    <td>10010</td>
                    <td>강펀딩</td>
                    <td>funding.kang@example.com</td>
                    <td>2023-09-24</td>
                    <td>
                        <button class="view-button" onclick="viewPortfolio(10010)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                    <td>
                        <span class="status-badge status-approved">승인완료</span>
                    </td>
                    <td class="action-buttons">
                        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10010)">
                            <i class="fas fa-info-circle"></i>
                        </button>
                    </td>
                </tr>
                
				<tr data-project-num="1011">
				    <td>10011</td>
				    <td>장기획</td>
				    <td>planner.jang@example.com</td>
				    <td>2023-09-25</td>
				    <td>
				        <button class="view-button" onclick="viewPortfolio(10011)">
				            <i class="fas fa-eye"></i>
				        </button>
				    </td>
				    <td>
				        <span class="status-badge status-pending">대기중</span>
				    </td>
				    <td class="action-buttons">
				        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10011)">
				            <i class="fas fa-info-circle"></i>
				        </button>
				        <button type="button" class="approve-btn" title="승인" onclick="approveMaker(10011)">
				            <i class="fas fa-check"></i>
				        </button>
				        <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(10011,1011)">
				            <i class="fas fa-times"></i>
				        </button>
				    </td>
				</tr>
				<tr data-project-num="1012">
				    <td>10012</td>
				    <td>오크리에이티브</td>
				    <td>creative.oh@example.com</td>
				    <td>2023-09-26</td>
				    <td>
				        <button class="view-button" onclick="viewPortfolio(10012)">
				            <i class="fas fa-eye"></i>
				        </button>
				    </td>
				    <td>
				        <span class="status-badge status-approved">승인완료</span>
				    </td>
				    <td class="action-buttons">
				        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10012)">
				            <i class="fas fa-info-circle"></i>
				        </button>
				    </td>
				</tr>
				<tr data-project-num="1013">
				    <td>10013</td>
				    <td>임기술</td>
				    <td>tech.lim@example.com</td>
				    <td>2023-09-27</td>
				    <td>
				        <button class="view-button" onclick="viewPortfolio(10013)">
				            <i class="fas fa-eye"></i>
				        </button>
				    </td>
				    <td>
				        <span class="status-badge status-rejected">승인거절</span>
				    </td>
				    <td class="action-buttons">
				        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10013)">
				            <i class="fas fa-info-circle"></i>
				        </button>
				    </td>
				</tr>
				<tr data-project-num="1014">
				    <td>10014</td>
				    <td>하디자이너</td>
				    <td>designer.ha@example.com</td>
				    <td>2023-09-28</td>
				    <td>
				        <button class="view-button" onclick="viewPortfolio(10014)">
				            <i class="fas fa-eye"></i>
				        </button>
				    </td>
				    <td>
				        <span class="status-badge status-pending">대기중</span>
				    </td>
				    <td class="action-buttons">
				        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10014)">
				            <i class="fas fa-info-circle"></i>
				        </button>
				        <button type="button" class="approve-btn" title="승인" onclick="approveMaker(10014)">
				            <i class="fas fa-check"></i>
				        </button>
				        <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(10014,1014)">
				            <i class="fas fa-times"></i>
				        </button>
				    </td>
				</tr>
				<tr data-project-num="1015">
				    <td>10015</td>
				    <td>배신상품</td>
				    <td>product.bae@example.com</td>
				    <td>2023-09-29</td>
				    <td>
				        <button class="view-button" onclick="viewPortfolio(10015)">
				            <i class="fas fa-eye"></i>
				        </button>
				    </td>
				    <td>
				        <span class="status-badge status-approved">승인완료</span>
				    </td>
				    <td class="action-buttons">
				        <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(10015)">
				            <i class="fas fa-info-circle"></i>
				        </button>
				    </td>
				</tr>                
            </tbody>
        </table>     
        
           <%-- 
			<tbody>
			    <c:forEach var="maker" items="${makers}">
			        <tr data-project-num="${maker.projectNum}">
			            <td>${maker.memberIdx}</td>
			            <td>${maker.name}</td>
			            <td>${maker.email1}@${maker.email2}</td>
			             <td><fmt:formatDate value="${maker.request_date}" pattern="yyyy-MM-dd"/></td>
			          
			            <td>${maker.request_date}</td>
			            <td>
			                <button class="view-button" onclick="viewPortfolio(${maker.memberIdx})">
			                    <i class="fas fa-eye"></i>
			                </button>
			            </td>
			            <td>
			                <c:choose>
			                    <c:when test="${maker.status eq '대기중'}">
			                        <span class="status-badge status-pending">대기중</span>
			                    </c:when>
			                    <c:when test="${maker.status eq '승인완료'}">
			                        <span class="status-badge status-approved">승인완료</span>
			                    </c:when>
			                    <c:otherwise>
			                        <span class="status-badge status-rejected">승인거절</span>
			                    </c:otherwise>
			                </c:choose>
			            </td>
			            <td class="action-buttons">
			                <button type="button" class="detail-btn" title="상세보기" onclick="viewDetails(${maker.memberIdx})">
			                    <i class="fas fa-info-circle"></i>
			                </button>
			                <c:if test="${maker.status eq '대기중'}">
			                    <button type="button" class="approve-btn" title="승인" onclick="approveMaker(${maker.memberIdx})">
			                        <i class="fas fa-check"></i>
			                    </button>
			                    <button type="button" class="reject-btn" title="거절" onclick="rejectMaker(${maker.memberIdx},${maker.projectNum})">
			                        <i class="fas fa-times"></i>
			                    </button>
			                </c:if>
			            </td>
			        </tr>
			    </c:forEach>
			</tbody>
			
        </table>
--%>
 
        <div class="pagination">
        	${paging}
        </div>
    </div>
</div>
 
 
<!-- 포트폴리오 모달 -->
<div class="modal fade" id="portfolioModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">포트폴리오 상세</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 포트폴리오 내용이 여기에 동적으로 로드됩니다 -->
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
function Request(url, method, formData, dataType, fn, file = false) {
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

// 승인
function approveMaker(memberIdx) {
    if(!confirm('이 회원의 메이커 신청을 승인하시겠습니까?')) {
        return;
    }
    
    let url = '${pageContext.request.contextPath}/admin/memberManagement/maker/approve';
    let query = {memberIdx: memberIdx};
    
    ajaxRequest(url, "post", query, "json", function(data) {
        if(data.success) {
            alert('메이커 신청이 승인되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            alert('승인 처리 중 오류가 발생했습니다.');
        }
    });
}

function rejectMaker(memberIdx, projectNum) {
    if(!confirm('이 회원의 메이커 신청을 거절하시겠습니까?')) {
        return;
    }
    
    let url = '${pageContext.request.contextPath}/admin/memberManagement/maker/reject';
    let query = {memberIdx: memberIdx, projectNum:projectNum};
    
    ajaxRequest(url, "post", query, "json", function(data) {
        if(data.success) {
            alert('메이커 신청이 거절되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            alert('거절 처리 중 오류가 발생했습니다.');
        }
    });
}

function viewPortfolio(memberIdx) {
    // 포트폴리오 모달 표시 로직
    const url = '${pageContext.request.contextPath}/admin/memberManagement/maker/portfolio';
    const query = 'memberIdx=' + memberIdx;
    
    const fn = function(data) {
        $('.modal-body').html(data);
        $('#portfolioModal').modal('show');
    };
    
    ajaxRequest(url, 'get', query, 'html', fn);
}

function viewDetails(memberIdx) {
    // 상세 정보 페이지로 이동
    location.href = '${pageContext.request.contextPath}/admin/memberManagement/maker/detail?memberIdx=' + memberIdx;
}

// AJAX 요청 헬퍼 함수
function ajaxRequest(url, method, query, dataType, fn) {
    $.ajax({
        type: method,
        url: url,
        data: query,
        dataType: dataType,
        success: function(data) {
            fn(data);
        },
        error: function(jqXHR) {
            console.log(jqXHR.responseText);
        }
    });
}
</script>

</body>
</html>