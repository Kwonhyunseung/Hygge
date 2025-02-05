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
<div class="title">2024년 12월 투표를 실시합니다!</div>

<div class="body-container">
	<div class="notice">12월 슬픔의 프로젝트에 투표해주세요!(중복 투표 불가)</div>
	<form action="" name="voteForm">
		<div class="candidate-list">
		    <label for='r1'>
			    <div class="candidate">
			    	<div class="left">
				        <div class="candidate-img-container">
				            <img src="${pageContext.request.contextPath}/dist/images/main/ad2.jpg" class="candidate-img">
				        </div>
				        <div class="textArea">
				        	<p>[재주는 AI가 넘고 돈은 내가 버는 전자책 수익화 시스템 비결]</p>
				        </div>
			    	</div>
			        <div class="right">
				        <input type="radio" name="candidate" id="r1">
			        </div>
			    </div>
		    </label>
		    <label for='r2'>
			    <div class="candidate">
			    	<div class="left">
				        <div class="candidate-img-container">
				            <img src="${pageContext.request.contextPath}/dist/images/main/ad2.jpg" class="candidate-img">
				        </div>
				        <div class="textArea">
				        	<p>어쩌구저쩌구</p>
				        </div>
			    	</div>
			        <div class="right">
				        <input type="radio" name="candidate" id="r2">
			        </div>
			    </div>
		    </label>
		    <label for='r3'>
			    <div class="candidate">
			    	<div class="left">
				        <div class="candidate-img-container">
				            <img src="${pageContext.request.contextPath}/dist/images/main/ad2.jpg" class="candidate-img">
				        </div>
				        <div class="textArea">
				        	<p>어쩌구저쩌구</p>
				        </div>
			    	</div>
			        <div class="right">
				        <input type="radio" name="candidate" id="r3">
			        </div>
			    </div>
		    </label>
		    <label for='r4'>
			    <div class="candidate">
			    	<div class="left">
				        <div class="candidate-img-container">
				            <img src="${pageContext.request.contextPath}/dist/images/main/ad2.jpg" class="candidate-img">
				        </div>
				        <div class="textArea">
				        	<p>어쩌구저쩌구</p>
				        </div>
			    	</div>
			        <div class="right">
				        <input type="radio" name="candidate" id="r4">
			        </div>
			    </div>
		    </label>
		</div>
	</form>
	<div class="vote-btn">
	    <button type="button" class="btn-submit">투표</button>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>