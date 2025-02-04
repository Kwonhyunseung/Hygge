<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
/* 제목 스타일 */
.title {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
    border: 1px solid green;
    max-width: 700px;
    margin: 40px auto;
}

.body-container {
	display: flex;
	flex-direction: column;
	max-width: 1200px;
	margin: auto;
}

.notice {
	font-size: 20px;
	font-weight: 700;
	padding-bottom: 20px;
	margin: 20px;
}

/* 후보 리스트: 제목 크기에 맞춤 */
.candidate-list {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 40px;
    width: 100%;
    margin: 20px auto;
    flex-wrap: wrap;
}

label {width: 55%;}

/* 개별 후보: 가로 정렬 */
.candidate {
	width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between; /* 이미지와 버튼을 양 끝으로 배치 */
    background: #fff;
    padding: 10px;
}

.candidate .left {width: 80%; text-align: center; font-weight: bold; font-size: 16px;}
.candidate .right {width: 20%; display: flex; justify-content: center; align-items: center;}

/* 이미지 컨테이너: 전체 박스의 3/4 비율 유지 */
.candidate-img-container {
    width: 100%;
    height: 300px; /* 고정 높이 지정 */
    overflow: hidden;
    margin-bottom: 10px;
}

/* 이미지 스타일 */
.candidate-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.candidate .textArea p {margin-bottom: unset;}

/* 라디오 버튼: 오른쪽에 고정 */
.candidate input[type="radio"] {
    width: 20px;
    height: 20px;
    margin-left: 10px; /* 오른쪽 정렬 */
}

/* 투표 버튼 스타일 */
button {
    display: block;
    width: 100px;
    padding: 10px;
    margin: 20px auto;
    font-size: 16px;
    font-weight: bold;
    color: white;
    background-color: #7ac142;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #6aad3c;
}

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>
<div class="title">2024년 12월 투표를 실시합니다!</div>

<div class="body-container">
	<div class="notice">12월 슬픔의 프로젝트에 투표해주세요!(중복 투표 불가)</div>
	
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
</div>

<div>
    <button>투표</button>
</div>



</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>