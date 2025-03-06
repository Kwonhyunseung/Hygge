<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    /* 기본 스타일 */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    .main-container {
        font-family: Arial, sans-serif;
        background: white;
    }
    .container {
        position: relative; /* 작성 버튼 위치 기준 설정 */
        width: 90%;
        max-width: 1200px;
        margin: 100px auto 40px;
        padding: 40px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }
    /* 탭 스타일 */
    .tabs {
        display: flex;
        border-bottom: 2px solid #FF7F50;
        margin-bottom: 30px;
    }
    .tab {
        padding: 14px 28px;
        font-size: 20px;
        cursor: pointer;
        border: 1px solid #FF7F50;
        border-bottom: none;
        transition: background 0.3s, color 0.3s;
    }
    .tab.active {
        background: #FF7F50;
        color: white;
    }
    .tab:hover {
        background: #FF5733;
        color: white;
    }
    .tab-content {
        display: none;
    }
    .tab-content.active {
        display: block;
    }
    /* 필터 버튼 스타일 */
    .filter-buttons {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
        justify-content: center;
    }
    .filter-buttons button {
        padding: 12px 18px;
        border: 1px solid #ccc;
        background: white;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
        transition: background 0.3s, color 0.3s;
    }
    .filter-buttons button.active {
        background: #FF7F50;
        color: white;
    }
    .filter-buttons button:hover {
        background: #FF5733;
        color: white;
    }
    /* 카드 영역 스타일 */
    .project-list, .board-list {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 30px;
        width: 100%;
        padding: 20px;
    }
    .project-card, .board-card {
        border: 1px solid #ddd;
        border-radius: 10px;
        background: #f9f9f9;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        display: block;
    }
    .hide {
        display: none;
    }
    .top-section {
        position: relative;
        background: white;
        text-align: center;
        height: 250px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .top-section img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .top-section span {
        color: white;
        background: #FF7F50;
        padding: 5px 10px;
        border-radius: 3px;
        font-size: 12px;
        position: absolute;
        top: 8.5%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    .top-section button {
        position: absolute;
        top: 5px;
        right: 5px;
        background: white;
        border: 1px solid #000;
        padding: 3px 8px;
        cursor: pointer;
        font-size: 12px;
        transition: background 0.3s, color 0.3s;
    }
    .top-section button:hover {
        background: #FF5733;
        color: white;
    }
    .middle-section {
        text-align: center;
        background: white;
        border-top: 1px solid #ddd;
        padding: 15px;
        font-size: 18px;
        font-weight: bold;
    }
    .status {
        color: #FF7F50;
        font-size: 14px;
        margin-bottom: 6px;
        margin-top: 10px;
    }
    .bottom-section {
        background: white;
        text-align: center;
        padding: 10px;
        border-top: 1px solid #ddd;
    }
    .bottom-section button {
        padding: 8px 15px;
        border: none;
        background: linear-gradient(135deg, #FF7F50, #FF5733);
        color: white;
        font-size: 12px;
        border-radius: 15px;
        cursor: pointer;
        font-weight: bold;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        transition: background 0.3s, transform 0.2s;
    }
    .bottom-section button:hover {
        background: linear-gradient(135deg, #FF5733, #FF2E00);
        transform: scale(1.05);
    }
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 30px;
    }
    .pagination button {
        padding: 10px 15px;
        border: 1px solid #ccc;
        background: white;
        cursor: pointer;
        margin: 0 8px;
        border-radius: 5px;
        font-size: 16px;
        transition: background 0.3s, color 0.3s;
    }
    .pagination button.active {
        background: #FF7F50;
        color: white;
    }
    .pagination button:hover {
        background: #FF5733;
        color: white;
    }
    .write-btn {
        position: absolute;
        bottom: 12px; /* 컨테이너 하단에서 위치 조정 */
        right: 15px;
        width: 50px;
        height: 50px;
        background: #FF7F50;
        color: white;
        border: none;
        border-radius: 50%;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s, transform 0.2s;
        z-index: 10;
    }
    .write-btn:hover {
        background: #FF5733;
        transform: scale(1.1);
    }
    .btn-edit {
        background: #FF7F50;
        color: white;
    }
    .btn-delete {
        background: #FF0000;
        color: white;
    }
    .btn-edit:hover {
        background: #FF5733;
    }
    .btn-delete:hover {
        background: #CC0000;
    }
    .project-thumbnail {
        width: 100%;
        height: 250px; /* 혹은 원하는 높이 */
        object-fit: cover;
    }
    /* 필터 결과가 없어 보일 때 표시할 메시지 스타일 */
    .no-data {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 300px;
        font-size: 20px;
        color: #777;
        background: #f9f9f9;
        border: 1px dashed #ddd;
        border-radius: 10px;
        margin: 20px 0;
    }
    
    /* 현승 추가 */
    .container{
    	margin-bottom: 150px;
    }
    
    
</style>
</head>
<body class="main-container">
    <header>
        <div class="header-container">
            <jsp:include page="/WEB-INF/views/project/layout/header.jsp" />
        </div>
    </header>

    <div class="container">
        <h2 style="margin-bottom: 38px;">${sessionScope.member.name}님, 반가워요</h2>

        <!-- 탭 영역 -->
        <div class="tabs">
            <div class="tab ${tab==1?'active':''}" data-tab="projects">프로젝트 관리</div>
            <div class="tab ${tab==2?'active':''}" data-tab="board">게시판 관리</div>
            <div class="tab ${tab==3?'active':''}" data-tab="inquiry">문의내역 관리</div>
        </div>

        <!-- 프로젝트 관리 탭 -->
        <div class="tab-content ${tab==1?'active':''}" id="projects">
            <!-- 필터 버튼 -->
            <div class="filter-buttons">
                <button class="active" data-filter="all">전체</button>
                <button data-filter="심사중">심사중</button>
                <button data-filter="승인">승인</button>
                <button data-filter="반려">반려</button>
                <button data-filter="진행중">진행중</button>
                <button data-filter="종료">종료</button>
            </div>
            <div class="project-list">
                <c:if test="${empty listProject}">
                    <div class="no-data">등록된 프로젝트가 없습니다.</div>
                </c:if>
                <c:forEach var="project" items="${listProject}">
                    <c:choose>
                        <c:when test="${project.accept_return == 1}">
                            <c:set var="statusLabel" value="승인" />
                        </c:when>
                        <c:when test="${project.accept_return == 0}">
                            <c:set var="statusLabel" value="반려" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="statusLabel" value="심사중" />
                        </c:otherwise>
                    </c:choose>
                    <c:set var="progressStatus" value="진행중" />
                    <c:if test="${not empty project.end_date and project.end_date < currentDate}">
                        <c:set var="progressStatus" value="종료" />
                    </c:if>
                    <div class="project-card" data-status="${statusLabel} ${progressStatus}">
                        <div class="top-section">
                            <span>프로젝트</span>
                            <c:choose>
                                <c:when test="${empty project.thumbnail}">
                                    <p>대표 이미지 등록 필요</p>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}" alt="썸네일 이미지"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="middle-section">
                            <p>${project.title}</p>
                            <p class="status">${statusLabel}/ ${progressStatus}</p>
                        </div>
                        <div class="bottom-section">
                            <button onclick="location.href='/funding/product/${project.num}'">프로젝트 바로가기</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${totalProjects > 1}">
                <div class="pagination">
                    <button>&lt;</button>
                    <button class="active">1</button>
                    <button>2</button>
                    <button>3</button>
                    <button>&gt;</button>
                </div>
            </c:if>
        </div>

        <!-- 게시판 관리 탭 -->
        <div class="tab-content ${tab==2?'active':''}" id="board">
            <!-- 필터 버튼 -->
            <div class="filter-buttons" id="board-filter-buttons">
                <button class="active" data-filter="all">전체</button>
                <button data-filter="패션">패션</button>
                <button data-filter="뷰티">뷰티</button>
                <button data-filter="가전">가전</button>
                <button data-filter="0">기타</button>
            </div>
            <div class="board-list">
                <c:if test="${empty listboard}">
                    <div class="no-data">등록된 게시판이 없습니다.</div>
                </c:if>
                <c:forEach var="board" items="${listboard}">
                    <div class="project-card board-card" data-category="${board.category}">
                        <div class="top-section">
                            <span>게시판</span>
                            <c:choose>
                                <c:when test="${empty board.sfileName}">
                                    <p>대표 이미지 등록 필요</p>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/uploads/makerBoard/${board.sfileName}" alt="썸네일 이미지" style="max-width: 100%; height: auto;" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="middle-section">
                            <p>${board.title}</p>
                            <p class="status">${board.category}</p>
                        </div>
                        <div class="bottom-section">
                            <button onclick="location.href='${pageContext.request.contextPath}/makerPage/medit?mkboard_Num=${board.mkboard_Num}'" class="btn-edit">수정</button>
                            <button class="btn-delete" data-num="${board.mkboard_Num}">삭제</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${totalBoards > 1}">
                <div class="pagination">
                    <button>&lt;</button>
                    <button class="active">1</button>
                    <button>2</button>
                    <button>3</button>
                    <button>&gt;</button>
                </div>
            </c:if>
            <button class="write-btn" onclick="location.href='${pageContext.request.contextPath}/makerPage/mwrite'">+</button>
        </div>

        <!-- 1:1 문의 탭 (임시 데이터 포함) -->
        <div class="tab-content ${tab==3?'active':''}" id="inquiry">
            <!-- 필터 버튼 -->
            <div class="filter-buttons" id="inquiry-filter-buttons">
                <button class="active" data-filter="all">전체</button>
                <button data-filter="답변대기">답변대기</button>
                <button data-filter="답변완료">답변완료</button>
            </div>
            <div class="board-list">
                <!-- 임시 데이터 시작 -->
                <div class="project-card board-card" data-category="답변완료">
                    <div class="top-section">
                        <span>문의</span>
                        <img src="${pageContext.request.contextPath}/uploads/profile/noimg.png" alt="문의 이미지" style="max-width: 100%; height: auto;">
                    </div>
                    <div class="middle-section">
                        <p>서비스 이용 관련 문의</p>
                        <p class="status">답변완료</p>
                    </div>
                    <div class="bottom-section">
                        <button onclick="location.href='/board/view/1'">상세보기</button>
                    </div>
                </div>
                <div class="project-card board-card" data-category="답변대기">
                    <div class="top-section">
                        <span>문의</span>
                        <img src="${pageContext.request.contextPath}/uploads/profile/noimg.png" alt="문의 이미지" style="max-width: 100%; height: auto;">
                    </div>
                    <div class="middle-section">
                        <p>결제 오류 문의</p>
                        <p class="status">답변대기</p>
                    </div>
                    <div class="bottom-section">
                        <button onclick="location.href='/board/view/2'">상세보기</button>
                    </div>
                </div>
                <!-- 임시 데이터 끝 -->
            </div>
            <!-- 필터 후 '데이터 없음' 메시지 영역 -->
            <div id="inquiry-no-data" class="no-data" style="display:none;"></div>
        </div>
    </div>
<%-- 
    <footer>
        <div class="footer-container">
            <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
        </div>
    </footer>
 --%>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 탭 전환 기능
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    const targetTab = this.getAttribute('data-tab');
                    tabs.forEach(t => t.classList.remove('active'));
                    tabContents.forEach(content => content.classList.remove('active'));
                    this.classList.add('active');
                    document.getElementById(targetTab).classList.add('active');
                });
            });

            // 프로젝트 필터링 기능
            const projectFilterButtons = document.querySelectorAll('#projects .filter-buttons button');
            const projectCards = document.querySelectorAll('#projects .project-card');
            projectFilterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const filter = this.getAttribute('data-filter');
                    projectFilterButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    // 모든 카드를 보이게 초기화
                    projectCards.forEach(card => card.classList.remove('hide'));
                    if (filter !== 'all') {
                        projectCards.forEach(card => {
                            const status = card.getAttribute('data-status');
                            if (!status.includes(filter)) {
                                card.classList.add('hide');
                            }
                        });
                    }
                    // 보이는 카드가 하나도 없으면 메시지 표시
                    const visibleProjects = document.querySelectorAll('#projects .project-card:not(.hide)');
                    const noDataDiv = document.getElementById('project-no-data');
                    if (visibleProjects.length === 0) {
                        noDataDiv.style.display = 'flex';
                        noDataDiv.innerText = filter === 'all' 
                            ? "등록된 프로젝트가 없습니다." 
                            : `등록된 ${filter} 프로젝트가 없습니다.`;
                    } else {
                        noDataDiv.style.display = 'none';
                    }
                });
            });

            // 게시판 필터링 기능
            const boardFilterButtons = document.querySelectorAll('#board .filter-buttons button');
            const boardCards = document.querySelectorAll('#board .board-card');
            boardFilterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const filter = this.getAttribute('data-filter');
                    boardFilterButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    boardCards.forEach(card => card.classList.remove('hide'));
                    if (filter !== 'all') {
                        boardCards.forEach(card => {
                            const category = card.getAttribute('data-category');
                            if (!category.includes(filter)) {
                                card.classList.add('hide');
                            }
                        });
                    }
                    const visibleBoards = document.querySelectorAll('#board .board-card:not(.hide)');
                    const boardNoDataDiv = document.getElementById('board-no-data');
                    if (visibleBoards.length === 0) {
                        boardNoDataDiv.style.display = 'flex';
                        boardNoDataDiv.innerText = filter === 'all'
                            ? "등록된 게시판이 없습니다." 
                            : `등록된 ${filter} 게시판이 없습니다.`;
                    } else {
                        boardNoDataDiv.style.display = 'none';
                    }
                });
            });
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.btn-delete').forEach(button => {
                button.addEventListener('click', function() {
                    const boardNum = this.getAttribute('data-num');
                    if (!confirm("게시글을 삭제하시겠습니까?")) {
                        return;
                    }
                    let url = '${pageContext.request.contextPath}/makerPage/delete?mkboard_Num=' + boardNum;
                    location.href = url;
                });
            });
        });
    </script>
</body>
</html>
