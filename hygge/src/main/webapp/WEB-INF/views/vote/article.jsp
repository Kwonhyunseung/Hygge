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
		
	    <form action="" name="voteForm">
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
	                            <input type="radio" name="candidate" id="r${status.count}">
	                        </div>
	                    </div>
	                </label>
	            </c:forEach>
	        </div>
	    </form>	
		
		<div class="vote-btn">
		    <button type="button" class="btn-submit">투표</button>
		    <c:if test="${sessionScope.member.authority == 'ADMIN'}">
		  <div class="admin-buttons">
		    <button type="button" class="admin-btn btn-modify" onclick="location.href='${pageContext.request.contextPath}/admin/vote/update?vote_num=${vote_num}'">수정</button>
		    <button type="button" class="admin-btn btn-delete" onclick="deleteVote();">삭제</button>
		  </div>
		</c:if>
		</div>
	</div>
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

</script>
</body>
</html>