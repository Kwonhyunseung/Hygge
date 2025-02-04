<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 찾기</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style>
    body {
        height: 100vh;
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
    .input-group {
        margin: 15px 0;
    }
    .input-group label {
        display: block;
        text-align: left;
        font-weight: bold;
        margin-bottom: 5px;
    }
    .input-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
    .submit-btn {
        background-color: #7d9b1e;
        color: white;
        border: none;
        width: 100%;
        padding: 12px;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 15px;
    }
    .submit-btn:hover {
        background-color: #6b881b;
    }
</style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="logo"><img src="${pageContext.request.contextPath}/dist/images/main/main_logo.png" class="login-logo" alt="로고"></div>

    <div class="box-container">
        <div class="box-header">아이디 찾기</div>
        <form name="idFindForm" method="post">
            <div class="input-group">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" placeholder="이름 입력">
            </div>
            <div class="input-group">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" placeholder="이메일 입력">
            </div>
            <button type="button" class="submit-btn" onclick="findId();">확인</button>
        </form>
    </div>
</main>

<script>
function findId() {
    const f = document.idFindForm;

    if (!f.userName.value.trim()) {
        alert('이름을 입력하세요.');
        f.userName.focus();
        return;
    }
    if (!f.userEmail.value.trim()) {
        alert('이메일을 입력하세요.');
        f.userEmail.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/member/findResult';
    f.submit();
}
</script>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>
