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
            <img class="logo" alt="" src="${pageContext.request.contextPath}/dist/images/main/main_logo.png">
            <nav class="nav-links">
                <button style="font-weight: 1000;">메이커 스튜디오</button>
                <button style="font-weight: 1000;">펀딩•프리오더</button>
            </nav>
        </div>
        
        <div class="right-section">
            <button>마이페이지</button>
            <button>작성중</button>
            <button>나가기</button>
        </div>
    </header>
</body>
</html>