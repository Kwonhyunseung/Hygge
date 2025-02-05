<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style type="text/css">
/* 로그인 css */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}

body {
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* viewport height의 100% */
}

main {
    flex: 1 0 auto; /* 남은 공간을 모두 차지하도록 설정 */
    padding: 20px 0; /* 위아래 여백 추가 */
}

footer {
    flex-shrink: 0; /* 푸터 크기 고정 */
}

.body-container {
    max-width: 600px;
    margin: 0 auto;
    width: 100%;
}

.login-container {
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-top: 50px;
}

.logo-container {
    text-align: center;
    margin-bottom: 20px;
}

.logo-img {
    width: auto;
    height: 50px;
}

.form-control {
    margin-bottom: 10px;
}

.btn-primary {
    border: none;
}

.kakao-login {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 12px;
    background-color: #FEE500;
    border-radius: 10px;
    font-weight: bold;
    cursor: pointer;
    border: none;
    height: 50px;
    font-size: 16px;
}

.spacer {
    height: 10px;
}

.form-control-plaintext {
    text-align: center;
}

.btn-primary {
    height: 50px;
    border-radius: 10px;
    font-size: 16px;
}

.btn-primary:hover {
    color: black !important;
    border: 1px solid #5C7F00;
}

.kakao-login:hover {
    color: white !important;
    border: 1px solid #E6C200;
}

.kakao-login:hover i {
    color: white !important;
}

.kakao-login i {
    color: black;
}

.body-container {
    max-width: 500px;
    margin: 0 auto;
}

.login-container {
    padding: 20px;
}
</style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="container">
        <div class="body-container">
            <div class="login-container">
                <div class="logo-container">
                    <img src="${pageContext.request.contextPath}/dist/images/main/main_logo.png" class="logo-img">
                </div>

                <form name="loginForm" action="" method="post">
                    <input type="text" name="id" class="form-control" placeholder="아이디">
                    <input type="password" name="pwd" class="form-control" autocomplete="off" placeholder="패스워드">

                    <div class="form-check" style="display: flex; align-items: center;">
                        <input class="form-check-input" type="checkbox" id="rememberMe">
                        <label class="form-check-label" for="rememberMe" style="margin-left: 8px;">아이디 저장</label>
                    </div>

                    <button type="button" class="btn btn-primary w-100" 
                            style="background-color: #75A400; color: white; margin-top: 10px;"
                            onclick="sendLogin();">회원 로그인</button>

                    <button type="button" class="kakao-login w-100 mt-3">
                        <i class="bi bi-chat-fill" style="font-size: 20px; margin-right: 10px;"></i>
                        카카오로 로그인
                    </button>

                    <div class="spacer"></div>
					
					
					
                    <p class="form-control-plaintext text-center">
                        <a href="${pageContext.request.contextPath}/member/idFind" class="text-decoration-none me-2">아이디찾기 </a>
                        <a href="${pageContext.request.contextPath}/member/pwdFind" class="text-decoration-none me-2">비밀번호찾기 </a>
                    </p>

                    <hr class="mt-3">
                    
                    <div>
                        <p class="form-control-plaintext">
                            아직 회원이 아니세요 ? 
                            <a href="${pageContext.request.contextPath}/member/account" class="text-decoration-none">회원가입</a>
                        </p>
                    </div>
                </form>
                
                <div class="d-grid">
                    <p class="form-control-plaintext text-center text-primary">${message}</p>
                </div>
            </div>
        </div>
    </div>
</main>

<script type="text/javascript">
function sendLogin() {
    const f = document.loginForm;
    let str;

    str = f.id.value.trim();
    if(!str) {
        f.id.focus();
        return;
    }

    str = f.pwd.value.trim();
    if(!str) {
        f.pwd.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/member/login';
    f.submit();
}
</script>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>


</body>
</html>