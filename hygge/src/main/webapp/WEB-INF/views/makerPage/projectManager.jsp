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
        padding: 20px;
    }

    .container {
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

    /* 프로젝트/게시판 카드 공통 스타일 */
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
            <div class="tab active" data-tab="projects">프로젝트 관리</div>
            <div class="tab" data-tab="board">게시판 관리</div>
            <div class="tab" data-tab="inquiry">문의내역 관리</div>
        </div>

        <!-- 프로젝트 관리 탭 -->
        <div class="tab-content active" id="projects">
            <div class="filter-buttons">
                <button class="active" data-filter="all">전체</button>
                <button data-filter="심사중">심사중</button>
                <button data-filter="승인완료">승인완료</button>
                <button data-filter="거절">거절</button>
                <button data-filter="진행중">진행중</button>
                <button data-filter="종료">종료</button>
            </div>

            <div class="project-list">
                <c:forEach var="project" items="${listProject}">
                    <c:set var="statusLabel" value="심사중" />
                    <c:choose>
                        <c:when test="${project.accept_return == 1}">
                            <c:set var="statusLabel" value="승인완료" />
                        </c:when>
                        <c:when test="${project.accept_return == 0}">
                            <c:set var="statusLabel" value="거절" />
                        </c:when>
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
                                    <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}" alt="썸네일 이미지" style="max-width: 100%; height: auto;" />
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
        <div class="tab-content" id="board">
            <div class="filter-buttons" id="board-filter-buttons">
                <button class="active" data-filter="all">전체</button>
                <button data-filter="#">카테고리1</button>
                <button data-filter="#2">카테고리2</button>
                <button data-filter="0">기타</button>
            </div>

            <div class="board-list">
                <c:forEach var="board" items="${listBoard}">
                    <div class="project-card board-card" data-category="${board.category}">
                        <div class="top-section">
                            <span>게시판</span>
                            <c:choose>
                                <c:when test="${empty board.thumbnail}">
                                    <p>대표 이미지 등록 필요</p>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/uploads/board/${board.thumbnail}" alt="썸네일 이미지" style="max-width: 100%; height: auto;" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="middle-section">
                            <p>${board.title}</p>
                            <p class="status">${board.category}</p>
                        </div>
                        <div class="bottom-section">
                            <button onclick="location.href='#'">게시글 보기</button>
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
        </div>

        <!-- 1:1 문의 탭 -->
        <div class="tab-content" id="inquiry">
            <h3>1:1 문의</h3>
            <div class="filter-buttons" id="inquiry-filter-buttons">
                <button class="active" data-filter="all">전체</button>
                <button data-filter="#">미완료</button>
                <button data-filter="#2">답변완료</button>
            </div>
            <div class="board-list">
                <c:forEach var="board" items="${makerBoard}">
                    <div class="project-card board-card" data-category="${board.category}">
                        <div class="top-section">
                            <span>게시판</span>
                            <c:choose>
                                <c:when test="${empty board.thumbnail}">
                                    <p>대표 이미지 등록 필요</p>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/uploads/board/${board.thumbnail}" alt="썸네일 이미지" style="max-width: 100%; height: auto;" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="middle-section">
                            <p>${board.title}</p>
                            <p class="status">${board.category}</p>
                        </div>
                        <div class="bottom-section">
                            <button onclick="location.href='/board/view/${board.id}'">게시글 보기</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-container">
            <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 탭 전환 기능
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');

            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    const targetTab = this.getAttribute('data-tab');

                    // 모든 탭과 탭 콘텐츠에서 active 클래스 제거
                    tabs.forEach(t => t.classList.remove('active'));
                    tabContents.forEach(content => content.classList.remove('active'));

                    // 클릭한 탭과 해당 콘텐츠에 active 클래스 추가
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

                    projectCards.forEach(card => card.classList.remove('hide'));

                    if (filter !== 'all') {
                        projectCards.forEach(card => {
                            const status = card.getAttribute('data-status');
                            if (!status.includes(filter)) {
                                card.classList.add('hide');
                            }
                        });
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
                });
            });
        });
    </script>
</body>
</html>
