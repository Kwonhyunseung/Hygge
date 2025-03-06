<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>투표 ${mode=='write' ? '만들기' : '수정하기'}</title>
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
                    <h2>이달의 프로젝트 투표 ${mode=='write' ? '작성' : '수정'}</h2>
                </div>
            </div>

            <form name="voteForm" method="post" onsubmit="return submitVoteForm();">
                <div class="write-container">
                    <div class="form-group">
                        <label for="vote-title">투표 제목</label>
                        <input type="text" id="vote-title" name="title" 
                               value="${dto.title}"
                               placeholder="투표 제목을 입력하세요" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="vote-title">내용</label>
                        <input type="text" id="content" name="content" 
                               value="${dto.content}"
                               placeholder="내용을 입력하세요.">
                    </div>
                    
                    <div class="form-group">
                        <label for="start-date">시작 날짜</label>
                        <div class="date-input-wrapper">
                            <input type="date" id="start-date" name="start_date" 
                                   value='<fmt:formatDate value="${dto.start_date}" pattern="yyyy-MM-dd"/>'
                                   required>
                            <i class="fa-regular fa-calendar"></i>
                        </div>
                    </div>

                    <div class="candidates-container">
                        <h3>프로젝트 후보 선택</h3>
                        <c:forEach var="i" begin="1" end="4">
                            <div class="form-group">
                                <label>프로젝트 후보 ${i}</label>
                                <select name="projectNum${i}" id="projectSelect${i}" required>
                                    <option value="">프로젝트를 선택하세요</option>
                                    <c:forEach var="project" items="${projects}">
                                        <option value="${project.num}" 
                                            ${selectedProjects[i-1].num == project.num ? 'selected' : ''}>
                                            ${project.title}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${mode=='update'}">
                        <input type="hidden" name="vote_num" value="${dto.vote_num}">
                    </c:if>

                    <div class="button-group">
                        <button type="button" class="btn btn-cancel" 
                                onclick="location.href='${pageContext.request.contextPath}/admin/vote/list';">취소</button>
                        <button onclick="location.href='${pageContext.request.contextPath}/admin/vote/update'" class="btn btn-primary">
                            ${mode=='write' ? '투표 만들기' : '투표 수정하기'}
                        </button>
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
        
        const f = document.voteForm;
        f.action = '${pageContext.request.contextPath}/admin/vote/${mode}';
        return true;
    }
    </script>
</body>
</html>