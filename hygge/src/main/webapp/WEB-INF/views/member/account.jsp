<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>

        .signup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        .signup-options {
            display: flex;
            gap: 30px;
            margin-top: 40px;
        }
        .signup-box {
            width: 200px;
            height: 250px;
            border: 3px solid #75A400;
            border-radius: 15px;
            text-align: center;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease; /* 부드러운 애니메이션 */
        }
        .signup-box:hover {
            color: white !important;
            background: #82B10C !important;          
            border: 2px solid #5C7F00;
            transform: scale(1.1); /* 호버 시 크기 약간 증가 */
        }
        .signup-box i {
            font-size: 80px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <img src="${pageContext.request.contextPath}/dist/images/hygge_logo.png" alt="Hygge Logo" height="120" style="margin-bottom: 50px;">
        <div class="signup-options">
        
            <div class="signup-box" onmouseover="changeText(this, '일반유저')" onmouseout="resetText(this)">
            	<a class="dropdown-item" href="${pageContext.request.contextPath}/member/member">
               	 	<i class="bi bi-person-fill"></i>
                		<p style="font-size: 30px; font-weight: 700;">USER</p>
            	</a>
            </div>
            <div class="signup-box" onmouseover="changeText(this, '판매자')" onmouseout="resetText(this)">
                <i class="bi bi-people-fill"></i>
                <p style="font-size: 30px; font-weight: 700;">MAKER</p>
            </div>
        </div>
    </div>

    <script>
        function changeText(element, newText) {
            element.querySelector('p').innerText = newText;
        }

        function resetText(element) {
            if (element.querySelector('p').innerText === '일반유저') {
                element.querySelector('p').innerText = 'USER';
            } else {
                element.querySelector('p').innerText = 'MAKER';
            }
        }
    </script>
</body>
</html>
