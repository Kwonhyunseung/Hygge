﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f9f9f9;
}
.container {
    display: flex;
    max-width: 1200px;
    width: 100%;
    margin-top: 30px;
    margin-bottom: 30px;
    align-items: stretch; 
}
.sidebar {
    width: 250px;
    padding: 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    text-align: center;
    border: 1px solid black;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    gap: 60px; 
     margin: 15px;
}
.sidebar .top-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
   	margin-top: 40px; 
   
}
.sidebar .profile-icon-wrapper {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 60px;
    height: 60px;
    background-color: #ddd;
    border-radius: 50%;
    margin: 0 auto 3px;
}
.sidebar .profile-icon {
    font-size: 40px;
    color: #777;
}
.sidebar h3 {
    margin: 0;
}
.sidebar .bottom-section ul {
    list-style: none;
    padding: 0;
}
.sidebar .bottom-section ul li {
    padding: 5px 0;
    border-bottom: 1px solid #eee;
}
.sidebar .bottom-section ul li a {
    color: #333;
    text-decoration: none;
    display: block;
}
.sidebar .bottom-section ul li a:hover {
    background-color: #f1f1f1;
    border-radius: 4px;
    background: #82B10C !important;
    color: white !important;
}
.sidebar button {
    margin-top: 10px;
    padding: 10px;
    width: 100%;
    border: none;
    background-color: #ddd;
    cursor: pointer;
}
.sidebar button:hover {
    background: #82B10C !important;
    color: white !important;
}
.content {
    flex: 1;
    background: white;
    padding: 30px;
    border-radius: 8px;
    margin-left: 30px;
    margin-top: 15px;
    margin-bottom: 15px;
    border: 1px solid black;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.stats {
    display: flex;
    justify-content: space-around;
    margin-bottom: 100px;
    text-align: center;
    margin-top: 40px;
}
.stats div {
    background: #d4e157;
    padding: 10px;
    border-radius: 50%;
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    position: relative;
    
}
.stats span {
    position: absolute;
    margin-top: 50px;
    bottom: -20px;
    font-size: 14px;
    color: #333;
    font-weight: bold;
}
.info {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 5px;
    margin-left: 20px;
}
.info div {
    padding: 10px 0;
    display: flex;
    justify-content: space-between;
}
.chat-button {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: #82B10C;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 50px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.chat-popup {
    display: none;
    position: fixed;
    bottom: 80px;
    right: 20px;
    width: 300px;
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
}
.chat-box {
    height: 300px;
    overflow-y: auto;
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 8px;
    background-color: #f8f9fa;
}
.message {
    margin-bottom: 10px;
}
.user {
    text-align: right;
    color: blue;
}
.other {
    text-align: left;
    color: green;
}
.input-group {
    margin-top: 10px;
}
.quick-replies {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    margin-top: 10px;
}
.quick-replies button {
    padding: 5px 10px;
    border: none;
    background-color: #ddd;
    cursor: pointer;
    border-radius: 5px;
}
.quick-replies button:hover {
    background: #82B10C;
    color: white;
}
</style>

</head>
<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="top-section">
                <div class="profile-icon-wrapper">
                    <a href="#">
                        <i class="bi bi-person profile-icon"></i>
                    </a>
                </div>
                <h3>스프링님</h3>
            </div>
            <div class="bottom-section">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/member/profileEdit">프로필 수정</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/buyHistory">구매내역</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/couponList">보유 쿠폰</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/review">후기</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/chat">채팅</a></li>
                    <li><a href="${pageContext.request.contextPath}/inquiry/list">1:1 문의</a></li>
                </ul>
                <button type="button">로그아웃</button>
            </div>
        </div>
        <div class="content">
            <div class="stats">
                <div>17 개 <span>내가 쓴 글</span></div>
                <div>17 개 <span>내가 쓴 후기</span></div>
                <div>17 개 <span>내가 쓴 쿠폰</span></div>
            </div>
            <div class="info">
                <div><strong>이름</strong></div> <div>김선용</div>
                <div><strong>닉네임</strong></div> <div>스프링</div>
                <div><strong>아이디</strong></div> <div>spring11</div>
                <div><strong>생년월일</strong></div> <div>1999-06-02 | 만 25세</div>
                <div><strong>전화번호</strong></div> <div>010-1234-5678</div>
                <div><strong>이메일</strong></div> <div>spring@naver.com</div>
                <div><strong>주소</strong></div> <div>서울 마포구 월드컵북로21 풍성빌딩</div>
                <div><strong>성별</strong></div> <div>남자</div>
                <div><strong>선호 카테고리</strong></div> <div>가전 | 패션 | 뷰티</div>
            </div>
        </div>
    </div>
  
    <footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>
