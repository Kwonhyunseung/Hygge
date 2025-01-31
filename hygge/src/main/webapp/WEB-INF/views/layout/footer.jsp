<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

 <style type="text/css">
    footer {
        background-color: #DDECB8; /* 연한 초록색 */
        padding: 20px;
        font-size: 14px;
    }
    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
    }
    .footer-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }
    .footer-bottom {
        display: flex;
        justify-content: space-between;
    }
    .footer-text {
        color: #333;
        margin: 0;
    }
    .footer-nav {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
    }
    .footer-nav li {
        margin-right: 15px;
    }
    .footer-nav a {
        text-decoration: none;
        color: #333;
    }
    .footer-nav a:hover {
        color: #007bff;
    }
    .bold-text {
        font-weight: bold;
    }
</style>

<footer>
    <div class="footer-container">
        <!-- 첫 번째 줄 -->
        <div class="footer-top">
            <p class="footer-text" style="font-size: 20px; font-weight: bold;">HYGGE 고객센터</p>
            <ul class="footer-nav" style="width: 46%;">
                <li><a href="#"><span class="bold-text">회사명</span> HYGGE(주) | </a></li>
                <li><a href="#"><span class="bold-text">사업자등록번호</span> 98-9999-0000 | </a></li>
                <li><a href="#"><span class="bold-text"> 서비스•사업자 </span> HYGGE(주) | </a></li>
            </ul>
        </div>

        <!-- 두 번째 줄 -->
        <div class="footer-bottom">
            <p class="footer-text">서울 무지개구 판타스틱로 2층</p>
            <p class="footer-text" style="width: 46%;">| <span class="bold-text">고객지원</span> 평일 10:00 ~ 17:00 (12:00 ~ 14:00 제외)</p>
        </div>
    </div>
</footer>
