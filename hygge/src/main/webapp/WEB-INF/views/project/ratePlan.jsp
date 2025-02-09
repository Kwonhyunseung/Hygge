<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요금제 선택</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .header {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }

        .logo {
            width: 100px;
        }

.nav {
    display: flex;
    justify-content: center;
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    border-bottom: 1px solid #eee;
    background-color: white;
    padding: 0 20px;
}

.nav-item {
    padding: 15px 25px;
    cursor: pointer;
    position: relative;
    color: #666;
    font-size: 14px;
    white-space: nowrap;
    transition: color 0.3s ease;
}

.nav-item:hover {
    color: #FF5733;
}

nav-item.active {
    color: #FF5733;
    font-weight: 500;
}

.nav-item.active::after {
    content: '';
    position: absolute;
    bottom: -1px;
    left: 0;
    width: 100%;
    height: 2px;
    background-color: #FF5733;
}

        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .title {
            text-align: center;
            margin-bottom: 40px;
        }

        .pricing-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .pricing-card {
            flex: 1;
            max-width: 350px;
            padding: 30px;
            border: 1px solid #eee;
            border-radius: 8px;
        }

        .pricing-card.highlighted {
            background-color: #fff9e6;
        }

        .plan-name {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .price {
            font-size: 28px;
            margin-bottom: 30px;
        }

        .feature-list {
            list-style: none;
            margin-bottom: 30px;
        }

        .feature-list li {
            margin-bottom: 10px;
            padding-left: 20px;
            position: relative;
        }

        .feature-list li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #FF5733;
        }

        .select-button {
            width: 100%;
            padding: 15px;
            background-color: #FF5733;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .notice-box {
            padding: 20px;
            border: 1px solid #eee;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .submit-button {
            display: block;
            width: 200px;
            margin: 0 auto;
            padding: 15px;
            background-color: #FF5733;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <header class="header">
        <img src="/dist/images/main/main_logo.png" alt="Logo" class="logo">
    </header>

    <nav class="nav">
        <div class="nav-item active">요금제 선택</div>
        <div class="nav-item">판매 계획</div>
        <div class="nav-item">상품 구성</div>
        <div class="nav-item">프로젝트 정보</div>
        <div class="nav-item">결제</div>
        <div class="nav-item">메이커 정보</div>
    </nav>

    <main class="main-content">
        <div class="title">
            <h2>요금제를 선택해 주세요</h2>
            <p>원하는 이용 서비스에 맞춰 요금제 선택이 가능합니다.</p>
        </div>

        <div class="pricing-container">
            <div class="pricing-card">
                <h3 class="plan-name">Basic</h3>
                <div class="price">무료</div>
                <ul class="feature-list">
                    <li>기본 기능 무료 이용</li>
                    <li>매출 분석</li>
                    <li>프로젝트 관리 Basic</li>
                </ul>
                <button class="select-button">선택하기</button>
            </div>

            <div class="pricing-card highlighted">
                <h3 class="plan-name">Pro</h3>
                <div class="price">월 49,000원</div>
                <ul class="feature-list">
                    <li>Basic 기능 포함</li>
                    <li>상세 분석</li>
                    <li>프로젝트 관리 Pro</li>
                    <li>우선 지원</li>
                </ul>
                <button class="select-button">선택하기</button>
            </div>

            <div class="pricing-card">
                <h3 class="plan-name">Premium</h3>
                <div class="price">월 99,000원</div>
                <ul class="feature-list">
                    <li>Pro 기능 포함</li>
                    <li>고급 분석</li>
                    <li>프로젝트 관리 Premium</li>
                    <li>24/7 지원</li>
                </ul>
                <button class="select-button">선택하기</button>
            </div>
        </div>

        <div class="notice-box">
            <p>HYGGЄ 프리미엄 프로젝트 워커 카테고리 제휴점의 '서비스 14일 미리보기'로<br>
            실제 환경 관련 기능들은 100만 원 이상 월별로 분할된 요금 프로젝트만 참여 가능합니다.</p>
        </div>

        <button class="submit-button">다음</button>
    </main>

    <script>
        document.querySelectorAll('.select-button').forEach(button => {
            button.addEventListener('click', function() {
                // Remove highlighting from all cards
                document.querySelectorAll('.pricing-card').forEach(card => {
                    card.classList.remove('highlighted');
                });
                // Highlight selected card
                this.closest('.pricing-card').classList.add('highlighted');
            });
        });
    </script>
</body>
</html>