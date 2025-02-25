<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="/dist/css/project/layout/header.css">
<link rel="stylesheet" href="/dist/css/project/layout/nav-item.css">
<link rel="stylesheet" href="/dist/css/project/button.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">
.maker-container {
    width: 1000px;
    padding: 30px 0px;
    margin: 0 auto;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}

.maker-section {
    margin-bottom: 40px;
    padding-bottom: 30px;
    border-bottom: 1px solid #eee;
}

.maker-section:last-child {
    border-bottom: none;
}

.section-title {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
}

.section-title::after {
    content: "*";
    color: #FF5733;
    margin-left: 2px;
}

.section-description {
    color: #666;
    font-size: 14px;
    margin-bottom: 15px;
}

.form-input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.profile-image-section {
    display: flex;
    align-items: flex-start;
    gap: 20px;
}

.contact-grid {
    display: grid;
    grid-template-columns: 150px 1fr;
    gap: 10px;
    align-items: center;
}

.contact-label {
    font-size: 14px;
    color: #333;
}

.introduction-input {
    min-height: 100px;
    resize: vertical;
}

.save-button {
    width: 100px;
    padding: 12px 20px;
    background-color: #FF5733;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    float: right;
    margin-top: 20px;
}

.save-button:hover {
    background-color: #ff4518;
}

.profile-circle {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	background-color: #ddd;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden; /* 이미지 넘치면 자르기 */
	position: relative;
	cursor: pointer;
	text-align: center;
	font-size: 14px;
	color: #555;
}

.profile-circle img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지를 원에 맞게 조정 */
	display: none; /* 초기에는 숨김 */
}

.upload-button {
	position: absolute;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.upload-text {
	position: absolute;
	text-align: center;
	font-size: 14px;
	color: #555;
}
</style>
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>

<div class="maker-container">
	<form name="submit4" action="${pageContext.request.contextPath}/makerPage/projectSubmit4" method="post">
		<div class="maker-section">
			<div class="section-title">메이커 이름</div>
			<div class="section-description">메이커 개인이나 팀을 대표할 수 있는 이름을 써주세요.</div>
			<input type="text" class="form-input" placeholder="이름" name="makerName">
		</div>
		
		<div class="maker-section">
			<div class="section-title">프로필 이미지</div>
			<div class="section-description">메이커 개인이나 팀의 사진을 올려주세요.</div>
			<div class="profile-image-section">
				<div class="profile-circle">
					<label for="profile-upload" class="upload-button">
						<span class="upload-text">이미지 파일<br>업로드</span>
						<input type="file" id="profile-upload" accept="image/*" style="display: none;">
					</label>
					<img id="profile-image" src="" alt="프로필 이미지" name="profileImg_File">
				</div>
			</div>
		</div>
		
		<div class="maker-section">
			<div class="section-title">메이커 소개</div>
			<div class="section-description">2~3문장으로 메이커님의 이력과 간단한 소개를 써주세요.</div>
			<textarea class="form-input introduction-input" maxlength="300" placeholder="간단한 이력과 소개를 적어주세요." style="resize: none;" name="introduction"></textarea>
		</div>
		
		<div class="maker-section">
			<div class="section-title">연동 계좌</div>
			<div class="section-description">후원금을 전달받을 계좌를 등록해주세요.</div>
			<div class="contact-grid">
				<div class="contact-label">은행명과 계좌번호</div>
				<input type="text" class="form-input" placeholder="은행명 계좌번호" name="bankAccount">
			</div>
		</div>
		<div class="button-container" style="display: flex; justify-content: flex-end;">
			<button class="next-button" type="button" onclick="sendNext();">다음</button>
		</div>
	</form>
</div>

<script type="text/javascript">
document.getElementById("profile-upload").addEventListener("change", function (event) {
const file = event.target.files[0];
const preview = document.getElementById("profile-image");
const uploadText = document.querySelector(".upload-text");

if (file) {
	const reader = new FileReader();
	reader.onload = function (e) {
		preview.src = e.target.result;
		preview.style.display = "block"; // 이미지 표시
		uploadText.style.display = "none"; // 업로드 텍스트 숨기기
	};
	reader.readAsDataURL(file);
	}
});

function sendNext() {
	const f = document.submit4;
	let value = $('input[name="makerName"]').val();
	if (!value) {
		$('input[name="makerName"]').focus();
		return false;
	}
	let value = $('input[name="makerName"]').val();
	if (!value) {
		$('input[name="makerName"]').focus();
		return false;
	}
	let value = $('input[name="makerName"]').val();
	if (!value) {
		$('input[name="makerName"]').focus();
		return false;
	}
	let value = $('input[name="makerName"]').val();
	if (!value) {
		$('input[name="makerName"]').focus();
		return false;
	}
}
</script>
</body>
</html>