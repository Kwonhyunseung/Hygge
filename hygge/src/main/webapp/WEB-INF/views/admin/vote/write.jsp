<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>투표 만들기</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/vote/write.css">
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
                    <h2>이달의 프로젝트 투표 만들기</h2>
                </div>
            </div>

            <form name="voteForm" method="post">
                <div class="write-container">
                    <div class="form-group">
                        <label for="vote-title">투표 제목</label>
                        <input type="text" id="vote-title" name="title" placeholder="투표 제목을 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label>투표 유형</label>
                        <select name="voteType" required>
                            <option value="best">이달의 최고 프로젝트</option>
                            <option value="worst">이달의 최악 프로젝트</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>투표 기간</label>
                        <div class="date-container">
                            <input type="date" name="startDate" required>
                            <span>~</span>
                            <input type="date" name="endDate" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>프로젝트 선택</label>
                        <div class="project-grid">
                            <c:forEach var="i" begin="1" end="6">
                                <div class="project-card" onclick="toggleSelection(this, ${i})">
                                    <div class="checkbox-wrapper">
                                        <div class="custom-checkbox">
                                            <i class="fas fa-check"></i>
                                        </div>
                                        <input type="checkbox" name="selectedProjects" value="${i}" style="display: none;">
                                    </div>
                                    <div class="project-image-container">
                                        <img src="/dist/images/choco.png" alt="프로젝트 이미지" class="project-image">
                                    </div>
                                    <div class="project-info">
                                        <div class="project-title">친환경 텀블러 프로젝트 ${i}</div>
                                        <div class="project-details">
                                            달성률: 128% | 후원금: 50,000,000원
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn btn-cancel" onclick="location.href='${pageContext.request.contextPath}/admin/vote/list';">취소</button>
                        <button type="submit" class="btn btn-primary">투표 만들기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        function toggleSelection(card, id) {
            card.classList.toggle('selected');
            const checkbox = card.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
        }
    </script>
</body>
</html>