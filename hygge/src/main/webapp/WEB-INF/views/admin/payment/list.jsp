<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매내역 관리</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style>
/* 컨텐츠 헤더 스타일 */
.content-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

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

/* 탭 컨텐츠 스타일 */
.tab-content {
    display: none;
}

.tab-content.active {
    display: block;
}

/* 테이블 스타일 */
.project-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    margin-bottom: 20px;
}

.project-table th,
.project-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.project-table th {
    background: #34495e;
    color: white;
}

.project-link {
    color: #34495e;
    text-decoration: none;
}

.project-link:hover {
    text-decoration: underline;
}

/* 상태 뱃지 */
.status-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
}

.status-pending {
    background: #f39c12;
    color: white;
}

.status-warning {
    background: #e74c3c;
    color: white;
}

.status-success {
    background: #2ecc71;
    color: white;
}

.status-info {
    background: #3498db;
    color: white;
}

/* 버튼 스타일 */
.action-button {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    margin-right: 4px;
}

.detail-button {
    background: #3498db;
    color: white;
}

.refund-button {
    background: #e74c3c;
    color: white;
}

/* 검색 컨테이너 */
.search-container {
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    margin-bottom: 20px;
}

.search-form {
    display: flex;
    gap: 10px;
    align-items: center;
}

.search-input {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    flex: 1;
}

.search-button {
    padding: 8px 16px;
    background: #34495e;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.pagination {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    gap: 5px;
}

.pagination a {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-decoration: none;
    color: #34495e;
}

.pagination a.active {
    background: #34495e;
    color: white;
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
           <h2>구매내역 관리</h2>
           <div class="tab-buttons">
               <button class="tab-button active" data-tab="all">전체 주문</button>
               <button class="tab-button" data-tab="project">프로젝트 주문</button>
               <button class="tab-button" data-tab="used">중고장터 주문</button>
           </div>
       </div>

       <div class="tab-container">
           <!-- 전체 주문 -->
           <div id="allPurchases" class="tab-content active">
               <form name="searchForm" action="${pageContext.request.contextPath}/admin/payment/list" method="get">
                   <div class="row mb-3">
                       <div class="col-auto">
                           <select name="schType" class="form-select">
                               <option value="all" ${schType=="all"?"selected":""}>전체</option>
                               <option value="nickname" ${schType=="nickname"?"selected":""}>구매자</option>
                               <option value="title" ${schType=="title"?"selected":""}>제품명</option>
                               <option value="payment_date" ${schType=="payment_date"?"selected":""}>결제일</option>
                           </select>
                       </div>
                       <div class="col-auto">
                           <input type="text" name="kwd" value="${kwd}" class="form-control">
                       </div>
                       <div class="col-auto">
                           <button type="submit" class="btn btn-primary">검색</button>
                       </div>
                   </div>
               </form>

               <table class="table table-hover project-table">
                   <thead>
                       <tr>
                           <th>결제번호</th>
                           <th>구매자</th>
                           <th>제품명</th>
                           <th>결제일</th>
                           <th>금액</th>
                           <th>구매종류</th>
                           <th>배송상태</th>
                           <th>관리</th>
                       </tr>
                   </thead>
                   <tbody>
                       <c:forEach var="dto" items="${list}" varStatus="status">
                           <tr>
                               <td>${dto.payment_num}</td>
                               <td>${dto.nickname}</td>
                               <td>
                                   <a href="${pageContext.request.contextPath}/admin/payment/detail/${dto.payment_num}" class="project-link">
                                       ${dto.title}
                                   </a>
                               </td>
                               <td>
                                   <fmt:formatDate value="${dto.payment_date}" pattern="yyyy-MM-dd HH:mm"/>
                               </td>
                               <td>
                                   <fmt:formatNumber value="${dto.pay_amount}" type="number"/>원
                               </td>
                               <td>
                                   <c:choose>
                                       <c:when test="${dto.sort == 0}">
                                           <span class="status-badge status-info">프로젝트</span>
                                       </c:when>
                                       <c:when test="${dto.sort == 1}">
                                           <span class="status-badge status-pending">중고장터</span>
                                       </c:when>
                                       <c:otherwise>
                                           <span class="status-badge">기타</span>
                                       </c:otherwise>
                                   </c:choose>
                               </td>
                               <td>
                                   <c:choose>
                                       <c:when test="${dto.shipping_state == 1}">
                                           <span class="status-badge status-pending">배송준비중</span>
                                       </c:when>
                                       <c:when test="${dto.shipping_state == 2}">
                                           <span class="status-badge status-info">배송중</span>
                                       </c:when>
                                       <c:when test="${dto.shipping_state == 3}">
                                           <span class="status-badge status-success">배송완료</span>
                                       </c:when>
                                       <c:otherwise>
                                           <span class="status-badge">상태미정</span>
                                       </c:otherwise>
                                   </c:choose>
                               </td>
                               <td>
                                   <button class="action-button detail-button" 
                                           onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/${dto.payment_num}'">
                                       상세보기
                                   </button>
                                   <button class="action-button refund-button" 
                                           onclick="openRefundModal(${dto.payment_num})">
                                       환불처리
                                   </button>
                               </td>
                           </tr>
                       </c:forEach>
                   </tbody>
               </table>
               
               <div class="page-navigation">
                   ${dataCount == 0 ? "등록된 구매내역이 없습니다." : paging}
               </div>
           </div>

           <!-- 프로젝트 주문 -->
           <div id="projectPurchases" class="tab-content">
               <div class="search-container">
                   <form class="search-form" action="${pageContext.request.contextPath}/admin/payment/list" method="get">
                       <input type="hidden" name="sort" value="0">
                       <select name="schType" class="search-input">
                           <option value="all">전체</option>
                           <option value="nickname">구매자</option>
                           <option value="title">제품명</option>
                           <option value="payment_date">결제일</option>
                       </select>
                       <input type="text" name="kwd" class="search-input" placeholder="검색어...">
                       <button type="submit" class="search-button">검색</button>
                   </form>
               </div>

               <table class="project-table">
                   <thead>
                       <tr>
                           <th>결제번호</th>
                           <th>구매자</th>
                           <th>제품명</th>
                           <th>결제일</th>
                           <th>금액</th>
                           <th>배송상태</th>
                           <th>관리</th>
                       </tr>
                   </thead>
                   <tbody>
                       <!-- 프로젝트 주문 목록이 여기에 표시됩니다 -->
                   </tbody>
               </table>
                   <div class="page-navigation">
			       	 <!-- 여기에 페이징이 동적으로 삽입됩니다 -->
			       </div>
           </div>

           <!-- 중고장터 주문 -->
           <div id="usedPurchases" class="tab-content">
               <div class="search-container">
                   <form class="search-form" action="${pageContext.request.contextPath}/admin/payment/list" method="get">
                       <input type="hidden" name="sort" value="1">
                       <select name="schType" class="search-input">
                           <option value="all">전체</option>
                           <option value="nickname">구매자</option>
                           <option value="title">제품명</option>
                           <option value="payment_date">결제일</option>
                       </select>
                       <input type="text" name="kwd" class="search-input" placeholder="검색어...">
                       <button type="submit" class="search-button">검색</button>
                   </form>
               </div>

               <table class="project-table">
                   <thead>
                       <tr>
                           <th>결제번호</th>
                           <th>구매자</th>
                           <th>제품명</th>
                           <th>결제일</th>
                           <th>금액</th>
                           <th>배송상태</th>
                           <th>관리</th>
                       </tr>
                   </thead>
                   <tbody>
                       <!-- 중고장터 주문 목록이 여기에 표시됩니다 -->
                   </tbody>
               </table>
                   <div class="page-navigation">
			       	 <!-- 여기에 페이징이 동적으로 삽입됩니다 -->
			       </div>               
           </div>
       </div>
   </div>
</div>

<!-- 환불 처리 모달 -->
<div class="modal fade" id="refundModal" tabindex="-1" aria-labelledby="refundModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="refundModalLabel">환불 처리</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="refundForm">
          <input type="hidden" id="payment_num" name="payment_num">
          <div class="mb-3">
            <label for="refund_reason" class="form-label">환불 사유</label>
            <textarea class="form-control" id="refund_reason" name="reason" rows="3" required></textarea>
          </div>
          <div class="mb-3">
            <label for="refund_fee" class="form-label">환불 수수료</label>
            <input type="number" class="form-control" id="refund_fee" name="fee" value="0">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="processRefund()">환불 처리</button>
      </div>
    </div>
  </div>
</div>

<script>
// 탭 전환
document.querySelectorAll('.tab-button').forEach(button => {
   button.addEventListener('click', () => {
       // 탭 버튼 활성화 상태 변경
       document.querySelectorAll('.tab-button').forEach(btn => 
           btn.classList.remove('active'));
       button.classList.add('active');
       
       // 탭 컨텐츠 전환
       const tabId = button.dataset.tab + 'Purchases';
       document.querySelectorAll('.tab-content').forEach(content => 
           content.classList.remove('active'));
       document.getElementById(tabId).classList.add('active');
       
       // 프로젝트 또는 중고장터 탭으로 이동할 경우 Ajax로 데이터 로드
       if (tabId !== 'allPurchases') {
           loadPurchaseData(button.dataset.tab);
       }
   });
});

//Ajax로 특정 탭의 구매 데이터 로드
function loadPurchaseData(type, page = 1) {
    console.log("타입:", type); // 이 값이 "project" 또는 "used"인지 확인
    const url = "${pageContext.request.contextPath}/admin/payment/listByType";
    const query = "type=" + type + "&page=" + page;
    
    console.log("요청 URL:", url + "?" + query); // 실제 요청 URL 확인
    
    ajaxRequest(url, 'get', query, 'json', function(data) {
        console.log("데이터 전체:", data);
        console.log("리스트 타입:", typeof data.list);
        console.log("리스트 길이:", data.list ? data.list.length : "없음");
        console.log("첫 번째 항목:", data.list && data.list[0] ? data.list[0] : "없음");
        
        if(data.state === "success") {
            const tableId = type + 'Purchases';
            const tbody = document.querySelector('#' + tableId + ' tbody');
            console.log("선택된 tbody:", tbody); // null인지 확인
            
            // 테이블 내용 초기화
            tbody.innerHTML = '';
            
            
            // 데이터가 없는 경우
            if(!data.list || data.list.length === 0) {
                const tr = document.createElement('tr');
                console.log("처리 중인 항목:", item);
                
                // 날짜 형식 변환 시도
                let formattedDate = "날짜 형식 오류";
                try {
                    const paymentDate = new Date(item.payment_date);
                    formattedDate = paymentDate.getFullYear() + '-' + 
                                 String(paymentDate.getMonth() + 1).padStart(2, '0') + '-' + 
                                 String(paymentDate.getDate()).padStart(2, '0') + ' ' +
                                 String(paymentDate.getHours()).padStart(2, '0') + ':' +
                                 String(paymentDate.getMinutes()).padStart(2, '0');
                    console.log("변환된 날짜:", formattedDate);
                } catch (e) {
                    console.error("날짜 변환 오류:", e);
                }
                tr.innerHTML = '<td colspan="7" class="text-center">데이터가 없습니다.</td>';
                tbody.appendChild(tr);
            } else {
                // 각 행 추가
                data.list.forEach(item => {
                    const tr = document.createElement('tr');
                    
                    const paymentDate = new Date(item.payment_date);
                    const formattedDate = paymentDate.getFullYear() + '-' + 
                                     String(paymentDate.getMonth() + 1).padStart(2, '0') + '-' + 
                                     String(paymentDate.getDate()).padStart(2, '0') + ' ' +
                                     String(paymentDate.getHours()).padStart(2, '0') + ':' +
                                     String(paymentDate.getMinutes()).padStart(2, '0');
                    
                    const formattedAmount = new Intl.NumberFormat('ko-KR').format(item.pay_amount);
                    
                    let shippingStatus = '';
                    switch(item.shipping_state) {
                        case 1:
                            shippingStatus = '<span class="status-badge status-pending">배송준비중</span>';
                            break;
                        case 2:
                            shippingStatus = '<span class="status-badge status-info">배송중</span>';
                            break;
                        case 3:
                            shippingStatus = '<span class="status-badge status-success">배송완료</span>';
                            break;
                        default:
                            shippingStatus = '<span class="status-badge">상태미정</span>';
                    }
                    
                    tr.innerHTML = `
                        <td>${item.payment_num}</td>
                        <td>테스트 이름</td>
                        <td>테스트 제목</td>
                        <td>테스트 날짜</td>
                        <td>테스트 금액</td>
                        <td>테스트 상태</td>
                        <td>
                            <button>테스트 버튼</button>
                        </td>
                    `;
                    
                    tbody.appendChild(tr);
                    
                });
            }
            
            // 페이징 처리
            const pagingDiv = document.querySelector('#' + tableId + ' .page-navigation');
            if(pagingDiv) {
                if(data.dataCount === 0) {
                    pagingDiv.textContent = "등록된 구매내역이 없습니다.";
                } else {
                    pagingDiv.innerHTML = data.paging;
                    
                    // 페이징 링크에 이벤트 추가
                    pagingDiv.querySelectorAll('a').forEach(link => {
                        link.addEventListener('click', function(e) {
                            e.preventDefault();
                            const pageUrl = new URL(this.href);
                            const pageNum = pageUrl.searchParams.get('page');
                            loadPurchaseData(type, pageNum);
                        });
                    });
                }
            }
        } else {
            alert("데이터 로드에 실패했습니다.");
        }
    });
}


// 환불 모달 열기
function openRefundModal(paymentNum) {
    document.getElementById('payment_num').value = paymentNum;
    const refundModal = new bootstrap.Modal(document.getElementById('refundModal'));
    refundModal.show();
}

// 환불 처리
function processRefund() {
    const paymentNum = document.getElementById('payment_num').value;
    const reason = document.getElementById('refund_reason').value;
    const fee = document.getElementById('refund_fee').value;
    
    if(!reason) {
        alert('환불 사유를 입력해주세요.');
        return;
    }
    
    if(!confirm('정말로 환불 처리하시겠습니까?')) {
        return;
    }
    
    const url = "${pageContext.request.contextPath}/admin/payment/refund";
    const query = "payment_num=" + paymentNum + "&reason=" + encodeURIComponent(reason) + "&fee=" + fee;
    
    const fn = function(data) {
        if(data.state === "success") {
            alert('환불이 처리되었습니다.');
            // 모달 닫기
            const refundModal = bootstrap.Modal.getInstance(document.getElementById('refundModal'));
            refundModal.hide();
            // 페이지 새로고침
            location.reload();
        } else {
            alert('환불 처리에 실패했습니다.');
        }
    };
    
    ajaxRequest(url, 'post', query, 'json', fn);
}

</script>
</body>
</html>