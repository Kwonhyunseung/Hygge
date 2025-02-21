<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vote/article.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>
<div class="title">${dto.title}</div>

	<div class="body-container">
		<div class="notice">${dto.content}</div>
		
	    <form action="" name="voteForm" method="post">
	    	<input type="hidden" name="page" value="${page}">
		    <input type="hidden" name="schType" value="${schType}">
		    <input type="hidden" name="kwd" value="${kwd}">
	        <div class="candidate-list">
	            <c:forEach var="project" items="${projectDto}" varStatus="status">
	                <label for="r${status.count}">
	                    <div class="candidate">
	                        <div class="left">
	                            <div class="candidate-img-container">
	                                <img src="/uploads/project/${project.thumbnail}" class="candidate-img">
	                            </div>
	                            <div class="textArea">
	                                <p>${project.title}</p>
	                            </div>
	                        </div>
	                        <div class="right">
	                            <input type="radio" name="project_num" id="r${status.count}" value="${project.num}">
	                        </div>
	                    </div>
	                </label>
	            </c:forEach>
	        </div>
	        <div class="vote-btn">
	        	<button type="button" class="btn-submit" onclick="submitVote()">투표</button>
	        </div>
	    </form>	
		
		<div class="vote-btn">
		    
		    <c:if test="${sessionScope.member.authority == 'ADMIN'}">
		  <div class="admin-buttons">
		    <button type="button" class="admin-btn btn-modify" onclick="location.href='${pageContext.request.contextPath}/admin/vote/update?vote_num=${vote_num}'">수정</button>
		    <button type="button" class="admin-btn btn-delete" onclick="deleteVote();">삭제</button>
		  </div>
		</c:if>
		</div>
	</div>
	
	<input type="hidden" name="page" value="${page}">
    <input type="hidden" name="schType" value="${schType}">
    <input type="hidden" name="kwd" value="${kwd}">
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>

<script type="text/javascript">

function deleteVote() {
    if(confirm("투표를 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/vote/delete?vote_num=${dto.vote_num}";
    }
}


function submitVote() {
    const f = document.voteForm;
    
    const selectedProject = document.querySelector('input[name="project_num"]:checked');
    
    if(!selectedProject) {
        alert("투표할 프로젝트를 선택해주세요.");
        return;
    }
    
    if(confirm("투표하시겠습니까?")) {
        f.action = "${pageContext.request.contextPath}/vote/article/${dto.vote_num}";
        f.submit();
    }
}


</script>
</body>
</html>