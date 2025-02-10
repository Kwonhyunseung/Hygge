<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메이커 스튜디오</title>
<style>
/* 기본적인 초기화 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html, body {
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    overflow-x: hidden; /* 가로 스크롤 방지 */
}

/* 헤더 스타일 */
.header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 40px;
    border-bottom: 1px solid #ccc;
    z-index: 1000;
    box-sizing: border-box;
}

.header-left {
    font-size: 20px;
    font-weight: bold;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 10px; /* 버튼들 간 간격 */
}

.header-right button {
    background: #fff;
    border: 1px solid #ccc;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.header-right button:hover {
    background-color: #FF7F50;
    border-color: #FF7F50;
    color: white;
}

/* 콘텐츠 영역 */
.content {
    display: flex;
    flex: 1;
    width: 100%;
    margin-top: 60px; /* 헤더와 콘텐츠 간 간격 */
    padding: 40px;
    gap: 40px; /* 콘텐츠 섹션들 간 간격 */
    box-sizing: border-box;
    overflow: hidden; /* 넘치는 내용은 숨김 */
}

/* 왼쪽 섹션 (배경 이미지) */
.left-section {
    width: 25%;
    background: url('${pageContext.request.contextPath}/dist/images/balloon.png') no-repeat center center;
    background-size: cover;
    min-height: calc(100vh - 60px); /* 헤더 높이를 제외한 최소 높이 */
    position: fixed;
    top: 60px; /* 헤더 밑에 고정 */
    left: 0;
    z-index: 1; /* 콘텐츠가 배경 위에 오도록 설정 */
    box-sizing: border-box;
    overflow: hidden;
}

/* 오른쪽 섹션 */
.right-section {
    width: 70%;
    padding: 60px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 20px;
    margin-left: 30%; /* left-section만큼 왼쪽 여백 추가 */
    box-sizing: border-box;
}

/* 카테고리 버튼 */
.category-btn {
    padding: 14px 28px;
    border: 1px solid #FF7F50;
    color: #FF7F50;
    border-radius: 20px;
    margin: 5px;
    cursor: pointer;
    font-size: 16px;
}

.selected {
    background-color: #FF7F50;
    color: white;
}

/* 텍스트 영역 */
.textarea {
    width: 100%;
    height: 140px;
    padding: 14px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
}

/* '다음' 버튼 */
.next-btn {
    width: 100%;
    padding: 20px;
    background-color: #FF7F50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    margin-top: 20px;
}


</style>
</head>
<body>

	<div class="header">
		<img
			src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
			style="width: 100px;">
		<div class="header-left">메이커 스튜디오 | 펀딩·프리오더</div>
		<div class="header-right">
			<button>작성중</button>
			<button>나가기</button>
		</div>
	</div>
	<div class="content">
		<div class="left-section"></div>
		<div class="right-section">
			<h2 style="font-size: 24px; font-weight: bold;">
				멋진 아이디어가 있으신가요?<br />어떤 프로젝트를 계획 중이신가요?
			</h2>
			<p style="color: gray; font-size: 16px;">(나중에 변경 가능합니다.)</p>

			<div>
				<button class="category-btn">가전</button>
				<button class="category-btn">패션</button>
				<button class="category-btn">뷰티</button>
				<button class="category-btn">홈·리빙</button>
				<button class="category-btn">푸드</button>
				<button class="category-btn">캐릭터·굿즈</button>
				<button class="category-btn selected">도서</button>
				<button class="category-btn">문화</button>
				<button class="category-btn">반려동물</button>
			</div>

			<h3 style="font-size: 20px; font-weight: bold;">프로젝트를 간단하게 소개해
				주세요.</h3>
			<p style="color: gray; font-size: 16px;">(나중에 변경 가능합니다.)</p>

			<textarea class="textarea" placeholder="프로젝트 요약을 작성해 주세요"></textarea>

			<button class="next-btn">다음</button>
		</div>
	</div>
</body>
</html>
