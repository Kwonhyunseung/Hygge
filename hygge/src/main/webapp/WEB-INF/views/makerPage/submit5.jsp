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
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">
        .maker-container {
            width: 1000px;
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

        .profile-circle {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 1px dashed #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            overflow: hidden;
        }

        .upload-button {
		    color: #FF5733;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration: none;
		    text-align: center;
		    width: 100%;
		    height: 100%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 10px;
            align-items: center;
        }
        
        .profile-circle img {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
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
</style>
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>

    <div class="maker-container">
        <div class="maker-section">
            <div class="section-title">메이커 이름</div>
            <div class="section-description">메이커 개인이나 팀을 대표할 수 있는 이름을 써주세요.</div>
            <input type="text" class="form-input" placeholder="이름">
        </div>

        <div class="maker-section">
            <div class="section-title">프로필 이미지</div>
            <div class="section-description">메이커 개인이나 팀의 사진을 올려주세요.</div>
			<div class="profile-image-section">
			    <div class="profile-circle">
			        <label for="profile-upload" class="upload-button">
			            이미지 파일<br>업로드
			            <input type="file" id="profile-upload" accept="image/*" style="display: none;">
			        </label>
			    </div>
			</div>
        </div>

        <div class="maker-section">
            <div class="section-title">메이커 소개</div>
            <div class="section-description">2~3문장으로 메이커님의 이력과 간단한 소개를 써주세요.</div>
            <textarea class="form-input introduction-input" placeholder="간단한 이력과 소개를 적어주세요."></textarea>
        </div>

	<div class="maker-section">
		<div class="section-title">연동 계좌</div>
		<div class="section-description">후원금을 전달받을 계좌를 등록해주세요.</div>
		<div class="contact-grid">
			<div class="contact-label">은행명</div>
			<input type="text" class="form-input" placeholder="은행명">
			<div class="contact-label">계좌번호</div>
			<input type="text" class="form-input" placeholder="숫자만 입력해주세요">
		</div>
	</div>

        <button class="save-button">저장</button>
    </div>
</body>
</html>