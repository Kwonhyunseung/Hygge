<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>체험단 신청</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/testForm.css" type="text/css">
    <!-- 슬라이더를 위한 아이콘 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="form-container">
        <!-- 제목 -->
        <h1 class="main-title">22기 체험단을 모집합니다!</h1>

        <!-- 이미지 슬라이더 -->
        <div class="slider-container">
            <div class="slider-wrapper">
                <img src="/dist/images/logo.jpg" alt="제품 이미지 1" class="slider-image">
            </div>
            <button class="slider-button prev"><i class="bi bi-chevron-left"></i></button>
            <button class="slider-button next"><i class="bi bi-chevron-right"></i></button>
            <div class="slider-pagination">
                <span class="dot active"></span>
                <span class="dot"></span>
                <span class="dot"></span>
            </div>
        </div>

        <!-- 제품 설명 -->
        <div class="product-info">
            <div class="notice-box">
                [필독! 같이읽는 위험처 이젠 안심!] 깔끔한쪽기로 보여드리겠습니다.
            </div>
            
            <div class="detail-box">
                <p>거친 발끝점자도 부드럽게 녹여내는 신개념 각질 제거 크림!</p>
                <p>자연 유래 AHA, BHA 성분으로 각질을 부드럽게 케어하고, 사이버틱의 판태를 성분이 건조한 발을 촉촉하게 감싸줍니다.</p>
                <p>단 일주일만에 보름보름 새 발로 거듭나는 마법 같은 변화를 경험해보세요.</p>
            </div>
        </div>

        <!-- 신청 폼 -->
        <div class="application-form">
            <h2>신청하기</h2>
            <form action="/experience/apply" method="post">
                <div class="form-group">
                    <label for="name">닉네임</label>
                    <input type="text" id="name" name="name" class="form-input" required>
                </div>

                <div class="form-group">
                    <label for="age">나이</label>
                    <input type="number" id="age" name="age" class="form-input" required>
                </div>

                <div class="form-group">
                    <label>성별</label>
                    <div class="radio-group">
                        <label>
                            <input type="radio" name="gender" value="남"> 남
                        </label>
                        <label>
                            <input type="radio" name="gender" value="여"> 여
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">주소</label>
                    <input type="text" id="address" name="address" class="form-input" required>
                </div>

                <!-- 개인정보 동의 -->
                <div class="agreement-box">
                    <label class="checkbox-label">
                        <input type="checkbox" required>
                        개인정보 수집 및 이용에 동의합니다
                    </label>
                </div>

                <button type="submit" class="submit-button">신청</button>
            </form>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
</body>
</html>