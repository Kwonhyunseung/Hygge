<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메이커 스튜디오</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: white;
    height: 100vh;
    display: flex;
    flex-direction: column;
    overflow-x: hidden; /* 가로 스크롤 방지 */
}

/* 헤더 */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 40px;
    border-bottom: 1px solid #ddd;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: white;
    z-index: 1000;
}

.header .title {
    font-size: 24px;
    font-weight: bold;
}

.header button {
    padding: 10px 20px;
    border: 1px solid #ccc;
    background: white;
    cursor: pointer;
}

.content {
    display: flex;
    flex: 1;
    width: 100%;
    margin-top: 70px; /* 헤더 크기만큼 여백 */
    overflow: hidden; /* 넘치는 내용은 숨김 */
}

/* 왼쪽 섹션 (배경 이미지) */
.left-section {
    width: 25%;
    background: url('${pageContext.request.contextPath}/dist/images/balloon.png') no-repeat center center/cover;
    min-height: 100vh; /* 화면 높이에 맞게 설정 */
    position: absolute; /* fixed에서 absolute로 변경 */
    top: 70px; /* 헤더 바로 아래에 고정 */
    left: 0;
    z-index: 1; /* 오른쪽 콘텐츠가 왼쪽 섹션 위에 오도록 설정 */
    overflow: hidden;
}

/* 오른쪽 섹션 */
.right-section {
    flex: 3;
    padding: 60px;
    text-align: left;
    display: flex;
    flex-direction: column;
    justify-content: center;
    box-sizing: border-box;
    margin-left: 25%; /* 왼쪽 섹션이 차지한 공간만큼 여백을 추가 */
}

.right-section h2 {
    font-size: 26px;
    margin-bottom: 15px;
}

.right-section p {
    color: gray;
    font-size: 16px;
    margin-bottom: 25px;
}

.checkbox-group {
    margin-bottom: 25px;
}

.checkbox-group label {
    display: block;
    margin-bottom: 10px;
    font-size: 18px;
}

.checkbox-group input {
    margin-right: 10px;
}

.start-btn {
    width: 100%;
    padding: 20px;
    background-color: #FF7F50;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 20px;
    border-radius: 5px;
    box-sizing: border-box;
}
</style>
</head>
<body>
    <div class="header">
        <img src="${pageContext.request.contextPath}/dist/images/main/main_logo.png" style="width: 100px;">
        <div class="title">메이커 스튜디오</div>
        <div>
            <button>작성중</button>
            <button>나가기</button>
        </div>
    </div>
    <div class="content">
        <div class="left-section"></div>
        <div class="right-section">
            <h2>프로젝트를 시작하기 위해서 아래의 준비가 필요해요!</h2>
            <p>(프로젝트 진행을 위한 동의를 해주세요.)</p>
            <div class="checkbox-group">
                <label><input type="checkbox"> 대표 메이커는 <b>만 19세 이상</b>이어야 합니다.</label>
                <label><input type="checkbox"> 연락 가능한 <b>본인 명의의 휴대폰 번호</b>와 <b>이메일 주소</b>가 필요합니다.</label>
                <label><input type="checkbox"> 펀딩 성공 후의 정산을 위해 <b>신분증</b> 또는 <b>사업자 등록증, 국내 은행 계좌</b>를 준비해주세요.</label>
            </div>
            <button class="start-btn">시작하기</button>
        </div>
    </div>
</body>
</html>
