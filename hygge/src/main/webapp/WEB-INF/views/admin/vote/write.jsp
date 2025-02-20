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

            <form name="voteForm" method="post" onsubmit="submitVoteForm();">
                <div class="write-container">
                    <div class="form-group">
                        <label for="vote-title">투표 제목</label>
                        <input type="text" id="vote-title" name="title" placeholder="투표 제목을 입력하세요" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="vote-title">내용</label>
                        <input type="text" id="content" name="content" placeholder="내용을 입력하세요.">
                    </div>
                    
                    <div class="form-group">
                        <label for="start-date">시작 날짜</label>
                        <div class="date-input-wrapper">
                            <input type="date" id="start-date" name="start_date" required>
                            <i class="fa-regular fa-calendar"></i>
                        </div>
                    </div>

                    <div class="candidates-container">
                        <h3>프로젝트 후보 선택</h3>
                        <div class="form-group">
                            <label>프로젝트 후보 1</label>
                            <select name="projectNum1" id="projectSelect1" required>
                                <option value="">프로젝트를 선택하세요</option>
                                <c:forEach var="project" items="${projects}">
                                    <option value="${project.num}">${project.title}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>프로젝트 후보 2</label>
                            <select name="projectNum2" id="projectSelect2" required>
                                <option value="">프로젝트를 선택하세요</option>
                                <c:forEach var="project" items="${projects}">
                                    <option value="${project.num}">${project.title}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>프로젝트 후보 3</label>
                            <select name="projectNum3" id="projectSelect3" required>
                                <option value="">프로젝트를 선택하세요</option>
                                <c:forEach var="project" items="${projects}">
                                    <option value="${project.num}">${project.title}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>프로젝트 후보 4</label>
                            <select name="projectNum4" id="projectSelect4" required>
                                <option value="">프로젝트를 선택하세요</option>
                                <c:forEach var="project" items="${projects}">
                                    <option value="${project.num}">${project.title}</option>
                                </c:forEach>
                            </select>
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
    function submitVoteForm() {
        const projects = [
            document.getElementById('projectSelect1').value,
            document.getElementById('projectSelect2').value,
            document.getElementById('projectSelect3').value,
            document.getElementById('projectSelect4').value
        ];
        
        // 중복 선택 체크
        const uniqueProjects = new Set(projects);
        if (uniqueProjects.size !== 4) {
            alert('프로젝트는 중복 선택할 수 없습니다.');
            return false;
        }
        
        return true;
        
        f.action = '${pageContext.request.contextPath}/admin/vote/write';
    }

    </script>
</body>
</html>