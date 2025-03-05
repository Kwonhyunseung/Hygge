<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 관리</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/qna/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 모달 배경 */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        /* 모달 컨테이너 */
        .answer-modal {
            background-color: white;
            width: 80%;
            max-width: 800px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        }
        
        /* 모달 헤더 */
        .modal-header {
            background-color: #4a6baf;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h3 {
            margin: 0;
            font-size: 1.2rem;
        }
        
        .close-modal {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }
        
        /* 모달 내용 */
        .modal-content {
            padding: 20px;
        }
        
        /* 문의 정보 섹션 */
        .question-info {
            background-color: #f5f7fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .info-header {
            margin-bottom: 15px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        
        .info-header h4 {
            font-size: 1.1rem;
            margin: 0 0 5px 0;
        }
        
        .info-meta {
            font-size: 0.9rem;
            color: #666;
            display: flex;
            justify-content: space-between;
        }
        
        .question-content {
            line-height: 1.6;
        }
        
        /* 답변 폼 */
        .answer-form {
            margin-top: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group textarea {
            min-height: 200px;
            resize: vertical;
        }
        
        /* 버튼 */
        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .modal-btn {
            padding: 8px 15px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        
        .cancel-btn {
            background-color: #e0e0e0;
            color: #333;
        }
        
        .submit-btn {
            background-color: #4a6baf;
            color: white;
        }
        
        /* 카테고리 배지 */
        .type-badge {
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: bold;
            color: white;
            display: inline-block;
        }
        
        .product {
            background-color: #3498db;
        }
        
        .delivery {
            background-color: #e74c3c;
        }
        
        .payment {
            background-color: #2ecc71;
        }
        
        .etc {
            background-color: #9b59b6;
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
                    <h2>1:1 문의 관리</h2>
                </div>
                <div class="status-summary">
                    <div class="status-item pending">
                        <span class="label">답변 대기</span>
                        <span class="count">${pendingCount}</span>
                    </div>
                    <div class="status-item completed">
                        <span class="label">답변 완료</span>
                        <span class="count">${completedCount}</span>
                    </div>
                    <div class="status-item total">
                        <span class="label">전체 문의</span>
                        <span class="count">${totalCount}</span>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <form name="searchForm" action="${pageContext.request.contextPath}/admin/qna/list" method="get">
                    <div class="filter-section">
                        <div class="filter-group">
                            <select name="category">
                                <option value="0">문의 유형</option>
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.category}" ${category.category == category ? "selected" : ""}>${category.name}</option>
                                </c:forEach>
                            </select>
                            <select name="status">
                                <option value="">처리 상태</option>
                                <option value="pending" ${status=="pending" ? "selected" : ""}>답변 대기</option>
                                <option value="completed" ${status=="completed" ? "selected" : ""}>답변 완료</option>
                            </select>
                            <input type="date" name="startDate" value="${startDate}">
                            <span>~</span>
                            <input type="date" name="endDate" value="${endDate}">
                        </div>
                        <div class="search-wrapper">
                            <select name="schType">
                                <option value="all" ${schType=="all" ? "selected" : ""}>전체</option>
                                <option value="content" ${schType=="content" ? "selected" : ""}>문의내용</option>
                                <option value="writer" ${schType=="writer" ? "selected" : ""}>작성자</option>
                                <option value="answer" ${schType=="answer" ? "selected" : ""}>답변내용</option>
                            </select>
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
                                <th>번호</th>
                                <th>문의유형</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>문의일시</th>
                                <th>처리상태</th>
                                <th>답변일시</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}" varStatus="status">
                                <tr>
                                    <td>${dataCount - (page-1) * size - status.index}</td>
                                    <td>
                                        <c:set var="categoryClass" value="other" />
                                        <c:choose>
                                            <c:when test="${dto.category_name eq '상품'}"><c:set var="categoryClass" value="product" /></c:when>
                                            <c:when test="${dto.category_name eq '배송'}"><c:set var="categoryClass" value="delivery" /></c:when>
                                            <c:when test="${dto.category_name eq '결제'}"><c:set var="categoryClass" value="payment" /></c:when>
                                            <c:when test="${dto.category_name eq '계정'}"><c:set var="categoryClass" value="account" /></c:when>
                                            <c:when test="${dto.category_name eq '환불'}"><c:set var="categoryClass" value="refund" /></c:when>
                                        </c:choose>
                                        <span class="type-badge ${categoryClass}">
                                            ${dto.category_name}
                                        </span>
                                    </td>
                                    <td class="title">
                                        <span class="text">${dto.q_title}</span>
                                    </td>
                                    <td>${dto.nickname}</td>
                                    <td>
                                        <fmt:parseDate value="${dto.q_date}" var="q_date" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <fmt:formatDate value="${q_date}" pattern="yyyy-MM-dd HH:mm" />
                                    </td>
                                    <td>
                                        <span class="status-badge ${dto.answer_status == '미답변' ? 'new' : 'completed'}">
                                            ${dto.answer_status}
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${not empty dto.a_date}">
                                            <fmt:parseDate value="${dto.a_date}" var="a_date" pattern="yyyy-MM-dd HH:mm:ss" />
                                            <fmt:formatDate value="${a_date}" pattern="yyyy-MM-dd HH:mm" />
                                        </c:if>
                                        <c:if test="${empty dto.a_date}">-</c:if>
                                    </td>
                                    <td class="action-buttons">
                                        <c:if test="${dto.answer_status == '미답변'}">
                                            <button type="button" class="answer-btn" onclick="openAnswerModal(${dto.num}, '${dto.category_name}', '${dto.q_title}', '${dto.nickname}', '${dto.q_date}', '${dto.q_content}')">
                                                답변하기
                                            </button>
                                        </c:if>
                                        <c:if test="${dto.answer_status != '미답변'}">
                                            <button type="button" onclick="location.href='/qna/article?num=${dto.num}';" class="view-btn">
                                                조회
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${dataCount == 0}">
                                <tr>
                                    <td colspan="8" class="empty-list">등록된 문의가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="content-footer">
                    <div class="pagination">
                        ${paging}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 답변 모달 -->
    <div class="modal-overlay" id="answerModal">
        <div class="answer-modal">
            <div class="modal-header">
                <h3>1:1 문의 답변</h3>
                <button class="close-modal" onclick="closeAnswerModal()">&times;</button>
            </div>
            <div class="modal-content">
                <div class="question-info">
                    <div class="info-header">
                        <h4 id="questionTitle">상품 관련 문의드립니다</h4>
                        <div class="info-meta">
                            <div>
                                <span class="type-badge product" id="questionCategory">상품</span>
                                <span id="questionAuthor">홍길동</span>
                            </div>
                            <div id="questionDate">2025-03-04 14:30</div>
                        </div>
                    </div>
                    <div class="question-content" id="questionContent">
                        구매한 상품에 문제가 있는 것 같습니다. 교환이나 환불 처리 가능할까요?
                        상품을 개봉했을 때 약간의 손상이 있었습니다. 사진을 첨부합니다.
                    </div>
                </div>
                
                <div class="answer-form">
                    <form id="qnaAnswerForm" method="post" action="${pageContext.request.contextPath}/admin/qna/answer">
                        <input type="hidden" name="num" id="questionNum" value="">
                        <input type="hidden" name="page" value="${page}">
                        
                        <div class="form-group">
                            <label for="answerTitle">답변 제목</label>
                            <input type="text" id="answerTitle" name="answerTitle" required placeholder="답변 제목을 입력하세요">
                        </div>
                        
                        <div class="form-group">
                            <label for="answerContent">답변 내용</label>
                            <textarea id="answerContent" name="answerContent" required placeholder="상세한 답변 내용을 입력하세요"></textarea>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button class="modal-btn cancel-btn" onclick="closeAnswerModal()">취소</button>
                <button class="modal-btn submit-btn" onclick="submitAnswer()">답변 등록</button>
            </div>
        </div>
    </div>
    
       <script>
    $(function(){
        $("form[name=searchForm]").submit(function(){
            const f = $(this);
            
            const schType = f.find("select[name=schType]").val();
            const kwd = f.find("input[name=kwd]").val().trim();
            if(schType && !kwd) {
                alert("검색어를 입력하세요.");
                f.find("input[name=kwd]").focus();
                return false;
            }
            
            const startDate = f.find("input[name=startDate]").val();
            const endDate = f.find("input[name=endDate]").val();
            if((startDate && !endDate) || (!startDate && endDate)) {
                alert("검색 기간을 시작일과 종료일 모두 입력하세요.");
                return false;
            }
            
            if(startDate && endDate && startDate > endDate) {
                alert("종료일은 시작일 이후 날짜를 선택하세요.");
                return false;
            }
            
            return true;
        });
    });
    
    // 모달 관련 함수
    function openAnswerModal(num, category, title, author, date, content) {
        // 실제 전달받은 파라미터 값 사용
        document.getElementById('questionNum').value = num;
        document.getElementById('questionTitle').textContent = title;
        document.getElementById('questionCategory').textContent = category;
        
        // 카테고리 클래스를 적절히 매핑
        let categoryClass = "type-badge ";
        switch(category.toLowerCase()) {
            case "상품": categoryClass += "product"; break;
            case "배송": categoryClass += "delivery"; break;
            case "결제": categoryClass += "payment"; break;
            case "계정": categoryClass += "account"; break;
            case "환불": categoryClass += "refund"; break;
            default: categoryClass += "other";
        }
        document.getElementById('questionCategory').className = categoryClass;
        
        document.getElementById('questionAuthor').textContent = author;
        document.getElementById('questionDate').textContent = date;
        document.getElementById('questionContent').textContent = content || "문의 내용이 없습니다.";
        
        // 모달 표시
        document.getElementById('answerModal').style.display = 'flex';
        document.body.style.overflow = 'hidden'; // 배경 스크롤 방지
    }
    
    function closeAnswerModal() {
        document.getElementById('answerModal').style.display = 'none';
        document.body.style.overflow = 'auto'; // 배경 스크롤 허용
        
        // 폼 초기화
        document.getElementById('qnaAnswerForm').reset();
    }
    
    function submitAnswer() {
        // 필수 입력값 확인
        const title = document.getElementById('answerTitle').value.trim();
        const content = document.getElementById('answerContent').value.trim();
        const num = document.getElementById('questionNum').value;
        
        if(!title) {
            alert("답변 제목을 입력하세요.");
            document.getElementById('answerTitle').focus();
            return;
        }
        
        if(!content) {
            alert("답변 내용을 입력하세요.");
            document.getElementById('answerContent').focus();
            return;
        }
        
        // Ajax 요청을 위한 데이터 준비
        const url = '${pageContext.request.contextPath}/admin/qna/answerQna';
        const data = {
            num: num,
            answerTitle: title,
            answerContent: content
        };
        
        // 성공 시 콜백 함수
        const fn = function(response) {
            if(response) {
                alert("답변이 등록되었습니다.");
                closeAnswerModal();
                
                // 페이지 새로고침 없이 테이블 행 업데이트
                updateTableRow(num);
            } else {
                alert("답변 등록에 실패했습니다. 다시 시도해주세요.");
            }
        };
        
        // Ajax 요청 실행
        ajaxRequest(url, 'post', data, 'json', fn);
    }
    
    // 테이블 행 업데이트 함수
    function updateTableRow(num) {
        // 현재 날짜 시간 포맷팅
        const now = new Date();
        const formattedDate = now.getFullYear() + "-" + 
                             String(now.getMonth() + 1).padStart(2, '0') + "-" + 
                             String(now.getDate()).padStart(2, '0') + " " +
                             String(now.getHours()).padStart(2, '0') + ":" +
                             String(now.getMinutes()).padStart(2, '0');
        
        // 해당 행 찾기
        const rows = document.querySelectorAll('tbody tr');
        for(let i = 0; i < rows.length; i++) {
            const answerBtn = rows[i].querySelector('.answer-btn');
            if(answerBtn && answerBtn.getAttribute('onclick').includes(num)) {
                // 상태 변경
                const statusCell = rows[i].querySelectorAll('td')[5];
                statusCell.innerHTML = '<span class="status-badge completed">답변완료</span>';
                
                // 답변 날짜 업데이트
                const dateCell = rows[i].querySelectorAll('td')[6];
                dateCell.textContent = formattedDate;
                
                // 버튼 변경
                const actionCell = rows[i].querySelectorAll('td')[7];
                actionCell.innerHTML = '<button type="button" onclick="location.href=\'article?num=' + num + '\';" class="view-btn">조회</button>';
                
                break;
            }
        }
    }
    </script>
</body>
</html>