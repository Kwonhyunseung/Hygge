<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디/비밀번호 찾기 완료</title>

<style>
    body {
        text-align: center;
        font-family: Arial, sans-serif;
        margin-bottom: 150px;
    }
    .logo img {
        width: 200px;
        height: auto;
    }
    .box-container {
        max-width: 400px;
        margin: 15px auto;
        border: 1px solid #7d9b1e;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }
    .box-header {
        background-color: #7d9b1e;
        color: white;
        padding: 15px;
        font-size: 18px;
        font-weight: bold;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }
    .message {
        margin: 20px 0;
        font-size: 16px;
    }
    .return-link {
        display: block;
        margin-top: 20px;
        font-size: 16px;
        text-decoration: underline;
        color: black;
        cursor: pointer;
    }
</style>
</head>
<body>
    <div class="logo"><img src="/dist/images/main/main_logo.png" alt="로고"></div>
    
    <div class="box-container">
        <div class="box-header">아이디 찾기 완료 // 비밀번호 찾기 완료</div>
        <div class="message">
            <p>아이디는 <strong>${userId}</strong> 입니다.</p>
            <p>|</p>
            <p>임시 비밀번호는 <strong>${tempPassword}</strong> 입니다.</p>
            <p>마이페이지에서 비밀번호를 변경해주세요.</p>
        </div>
    </div>
    
    <a href="${pageContext.request.contextPath}/" class="return-link">메인으로 돌아가기</a>

</body>
</html>

