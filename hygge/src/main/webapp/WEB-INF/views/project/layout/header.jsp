<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/project/layout/header.css">
</head>
<body>
    <header class="header">
        <div class="left-section">
        	<a href="${pageContext.request.contextPath}/">
            	<img class="logo" src="${pageContext.request.contextPath}/dist/images/main/main_logo.png">
            </a>
            <nav class="nav-links">
                <button style="font-weight: 1000;">메이커 스튜디오</button>
                <button style="font-weight: 1000;">펀딩•프리오더</button>
            </nav>
        </div>
        
        <div class="right-section">
        	<!-- 상황에 따라 2가지로 이동할 수 있도록 수정!! -->
        	<!-- 
        		2가지의 상황이 있음.
        		1. 메인페이지에서 셀러마이페이지 접속 후, 셀러마이페이지의 마이페이지 접속시 일반 유저 마이페이지 나와야함
        		2. 프로젝트 올리기에서 마이페이지 이동시, 셀러마이페이지로 이동해야 함
        	 -->
        	<!-- 셀러마이페이지로 가고싶으면, onclick="location.href='${pageContext.request.contextPath}/makerPage/projectManager'"> -->
        	<!-- 유저마이페이지로 가고싶으면, onclick="location.href='${pageContext.request.contextPath}/myPage/myPage'"> -->
            <button>마이페이지</button>
            <!-- <button>작성중</button> -->
            <!-- <button>나가기</button> -->
        </div>
    </header>
</body>
</html>