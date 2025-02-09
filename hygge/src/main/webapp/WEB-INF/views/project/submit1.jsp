<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>협업심의 프로젝트</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: white;
        }

        .header {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }

        .logo {
            height: 24px;
        }

        .nav {
            display: flex;
            border-bottom: 1px solid #FF5733;
            max-width: 800px;
            margin: 0 auto;
        }

        .nav-item {
            padding: 15px 25px;
            cursor: pointer;
            color: #666;
            font-size: 14px;
            position: relative;
        }

        .nav-item.active {
            color: #FF5733;
            border-bottom: 2px solid #FF5733;
        }

        .main-content {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .project-header {
            display: flex;
            align-items: flex-start;
            margin-bottom: 30px;
            gap: 20px;
        }

        .project-image {
            width: 100px;
            height: 100px;
            background-color: #f5f5f5;
        }

        .project-title-container {
            flex-grow: 1;
        }

        .badge {
            display: inline-block;
            padding: 2px 8px;
            border: 1px solid #FF5733;
            color: #FF5733;
            border-radius: 4px;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .project-title {
            font-size: 18px;
            font-weight: 500;
        }

        .section-title {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .required {
            color: #FF5733;
            margin-left: 4px;
        }

        .warning-box {
            background-color: #fff2f0;
            border: 1px solid #ffccc7;
            padding: 15px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #ff4d4f;
        }

        .warning-box ul {
            margin-left: 20px;
            margin-top: 8px;
        }

        .warning-box li {
            margin-bottom: 5px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .input-field {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .input-field:disabled {
            background-color: #f5f5f5;
            color: #999;
        }

        .date-section {
            margin-bottom: 15px;
        }

        .date-section label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #666;
        }

        .info-text {
            font-size: 13px;
            color: #666;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <header class="header">
        <img src="logo.png" alt="Logo" class="logo">
    </header>

    <nav class="nav">
        <div class="nav-item">요금제 선택</div>
        <div class="nav-item active">판매 계획</div>
        <div class="nav-item">상품 구성</div>
        <div class="nav-item">프로젝트 정보</div>
        <div class="nav-item">결제</div>
        <div class="nav-item">메이커 정보</div>
    </nav>

    <main class="main-content">
        <div class="project-header">
            <img src="project-image.jpg" alt="프로젝트 사진" class="project-image">
            <div class="project-title-container">
                <div class="badge">도서</div>
                <h1 class="project-title">협업심의 프로젝트</h1>
            </div>
        </div>

        <div class="form-grid">
            <div class="form-section">
                <h2 class="section-title">목표 금액<span class="required">*</span></h2>
                <div class="warning-box">
                    <strong>목표 금액 설정시 꼭 주의하세요!</strong>
                    <ul>
                        <li>프로젝트의 특성과 선물 구성의 단위를 고려하여 금액을 설정하세요.</li>
                        <li>선물의 가치 전달과 제작 비용을 고려해 과도한 할인은 피해주세요.</li>
                        <li>프로젝트 종료일까지 100% 달성이 되지 않으면 결제가 진행되지 않습니다.</li>
                    </ul>
                </div>
                <input type="text" class="input-field" placeholder="500만원 미만의 금액을 입력하세요">
            </div>

            <div class="form-section">
                <div class="section-title">목표 금액</div>
                <input type="text" class="input-field" disabled value="500만원 미만의 금액을 입력하세요">
            </div>
        </div>

        <div class="form-section">
            <h2 class="section-title">판매 일정<span class="required">*</span></h2>
            <p class="info-text">설정된 일정은 이후 검토와 심의를 거쳐 확정됩니다.</p>
            
            <div class="date-section">
                <label>시작일</label>
                <input type="date" class="input-field">
            </div>
            
            <div class="date-section">
                <label>시작 시간</label>
                <input type="time" class="input-field">
            </div>
            
            <div class="date-section">
                <label>종료일</label>
                <input type="date" class="input-field">
            </div>
        </div>

        <div class="form-section">
            <h2 class="section-title">예상된 결제 예정</h2>
            <input type="text" class="input-field" value="판매 기간 설정 시 자동 입력됩니다" disabled>
        </div>

        <div class="form-section">
            <h2 class="section-title">대표 사진<span class="required">*</span></h2>
            <input type="file" class="input-field" accept="image/*">
        </div>
    </main>
</body>
</html>