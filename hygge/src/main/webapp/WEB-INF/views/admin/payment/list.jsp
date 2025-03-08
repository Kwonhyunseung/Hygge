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
/* 검색 컨테이너 수정 */
.content-title {
    font-size: 24px;
    font-weight: bold;
    color: #2c3e50;
    margin-bottom: 10px;
}


.search-container {
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.search-form {
    display: flex;
    gap: 10px;
    align-items: center;
    flex: 1;
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

/* 탭 버튼 스타일 수정 */
.tab-buttons {
    display: flex;
    gap: 10px;
    margin-left: 20px;
}

.tab-button {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
    white-space: nowrap;
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
       <div class="tab-container">
           <!-- 전체 주문 -->
           <div id="allPurchases" class="tab-content active">
               <div class="search-container">
                   <form name="searchForm" action="${pageContext.request.contextPath}/admin/payment/list" method="get" class="search-form">
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
                   </form>
                   
                   <div class="tab-buttons">
                       <button class="tab-button active" data-tab="all">전체 주문</button>
                       <button class="tab-button" data-tab="project">프로젝트 주문</button>
                       <button class="tab-button" data-tab="used">중고장터 주문</button>
                   </div>
               </div>

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
                   <%--
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
                               </td>
                           </tr>
                       </c:forEach>
                   </tbody>
                   --%>
                   <!-- 구매내역 하드코딩 데이터 -->
<tbody>
    <tr>
        <td>P2024030001</td>
        <td>나무꾼</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030001" class="project-link">
                에코프렌들리 대나무 칫솔 세트
            </a>
        </td>
        <td>2024-03-01 14:25</td>
        <td>12,500원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-success">배송완료</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030001'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030002</td>
        <td>블루마린</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030002" class="project-link">
                올인원 스마트 요가 매트
            </a>
        </td>
        <td>2024-03-02 09:15</td>
        <td>89,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-info">배송중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030002'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>U2024030003</td>
        <td>핑크퐁</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/U2024030003" class="project-link">
                중고 아이패드 프로 5세대 256GB
            </a>
        </td>
        <td>2024-03-02 11:42</td>
        <td>580,000원</td>
        <td>
            <span class="status-badge status-pending">중고장터</span>
        </td>
        <td>
            <span class="status-badge status-info">배송중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/U2024030003'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030004</td>
        <td>메이커피플</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030004" class="project-link">
                마이크로 모빌리티 전동킥보드
            </a>
        </td>
        <td>2024-03-02 15:30</td>
        <td>429,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-pending">배송준비중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030004'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>U2024030005</td>
        <td>디지털노마드</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/U2024030005" class="project-link">
                중고 소니 A7III 카메라 바디
            </a>
        </td>
        <td>2024-03-03 08:52</td>
        <td>1,200,000원</td>
        <td>
            <span class="status-badge status-pending">중고장터</span>
        </td>
        <td>
            <span class="status-badge status-success">배송완료</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/U2024030005'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030006</td>
        <td>오가닉홈</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030006" class="project-link">
                유기농 면 침구세트 (퀸사이즈)
            </a>
        </td>
        <td>2024-03-03 14:10</td>
        <td>149,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-success">배송완료</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030006'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030007</td>
        <td>카페인러버</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030007" class="project-link">
                스페셜티 커피 정기 구독 (3개월)
            </a>
        </td>
        <td>2024-03-03 17:05</td>
        <td>45,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-pending">배송준비중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030007'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>U2024030008</td>
        <td>올라운더</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/U2024030008" class="project-link">
                중고 퍼팅 연습기
            </a>
        </td>
        <td>2024-03-03 18:30</td>
        <td>25,000원</td>
        <td>
            <span class="status-badge status-pending">중고장터</span>
        </td>
        <td>
            <span class="status-badge status-info">배송중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/U2024030008'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030009</td>
        <td>캠핑마스터</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030009" class="project-link">
                올시즌 초경량 백패킹 텐트
            </a>
        </td>
        <td>2024-03-04 09:45</td>
        <td>235,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-success">배송완료</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030009'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>U2024030010</td>
        <td>레트로게이머</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/U2024030010" class="project-link">
                중고 닌텐도 스위치 라이트
            </a>
        </td>
        <td>2024-03-04 10:20</td>
        <td>140,000원</td>
        <td>
            <span class="status-badge status-pending">중고장터</span>
        </td>
        <td>
            <span class="status-badge status-success">배송완료</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/U2024030010'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030011</td>
        <td>헬시쿡</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030011" class="project-link">
                스마트 저탄수 밀 프렙 컨테이너
            </a>
        </td>
        <td>2024-03-04 13:15</td>
        <td>57,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-pending">배송준비중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030011'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030012</td>
        <td>모닝조깅</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030012" class="project-link">
                울트라 경량 러닝화
            </a>
        </td>
        <td>2024-03-04 16:40</td>
        <td>119,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-info">배송중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030012'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>U2024030013</td>
        <td>북러버</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/U2024030013" class="project-link">
                중고 한정판 소설 컬렉션 (15권 세트)
            </a>
        </td>
        <td>2024-03-05 11:30</td>
        <td>75,000원</td>
        <td>
            <span class="status-badge status-pending">중고장터</span>
        </td>
        <td>
            <span class="status-badge status-pending">배송준비중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/U2024030013'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>P2024030014</td>
        <td>음악메이커</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/P2024030014" class="project-link">
                포터블 미디 컨트롤러
            </a>
        </td>
        <td>2024-03-05 15:22</td>
        <td>189,000원</td>
        <td>
            <span class="status-badge status-info">프로젝트</span>
        </td>
        <td>
            <span class="status-badge status-pending">배송준비중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/P2024030014'">
                상세보기
            </button>
        </td>
    </tr>
    <tr>
        <td>U2024030015</td>
        <td>티타임</td>
        <td>
            <a href="${pageContext.request.contextPath}/admin/payment/detail/U2024030015" class="project-link">
                중고 티포트 & 찻잔 세트
            </a>
        </td>
        <td>2024-03-05 17:50</td>
        <td>38,000원</td>
        <td>
            <span class="status-badge status-pending">중고장터</span>
        </td>
        <td>
            <span class="status-badge status-info">배송중</span>
        </td>
        <td>
            <button class="action-button detail-button" 
                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/U2024030015'">
                상세보기
            </button>
        </td>
    </tr>
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
                   
                   <div class="tab-buttons">
                       <button class="tab-button" data-tab="all">전체 주문</button>
                       <button class="tab-button active" data-tab="project">프로젝트 주문</button>
                       <button class="tab-button" data-tab="used">중고장터 주문</button>
                   </div>
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
                   
                   </tbody>
               </table>
               <div class="page-navigation">
               
               </div>
           </div>

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
                   
                   <div class="tab-buttons">
                       <button class="tab-button" data-tab="all">전체 주문</button>
                       <button class="tab-button" data-tab="project">프로젝트 주문</button>
                       <button class="tab-button active" data-tab="used">중고장터 주문</button>
                   </div>
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
                tr.innerHTML = '<td colspan="7" class="text-center">데이터가 없습니다.</td>';
                tbody.appendChild(tr);
            } else {
                // 각 행 추가
                data.list.forEach(item => {
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
                        <td>${item.nickname || '알 수 없음'}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/payment/detail/${item.payment_num}" class="project-link">
                                ${item.title || '알 수 없음'}
                            </a>
                        </td>
                        <td>${formattedDate}</td>
                        <td>${formattedAmount}원</td>
                        <td>${shippingStatus}</td>
                        <td>
                            <button class="action-button detail-button" 
                                    onclick="location.href='${pageContext.request.contextPath}/admin/payment/detail/${item.payment_num}'">
                                상세보기
                            </button>
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