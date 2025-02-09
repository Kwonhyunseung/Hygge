<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메이커 스튜디오</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html, body { height: 100%; width: 100%; display: flex; flex-direction: column; }
        .header { 
            position: fixed;
            top: 0; left: 0; width: 100%; 
            background: white;
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            padding: 15px 40px; 
            border-bottom: 1px solid #ccc;
            z-index: 1000;
        }
        .header-left {
            font-size: 20px;
            font-weight: bold;
        }
        .header-right button {
            background: #fff;
            border: 1px solid #ccc;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }
        .content {
            display: flex;
            flex: 1;
            width: 100%;
            margin-top: 60px;
            padding: 40px;
        }
        .left-section { 
            width: 40%; 
            background: url('${pageContext.request.contextPath}/dist/images/balloon.png') no-repeat center center/cover; 
        }
        .right-section { 
            width: 60%; 
            padding: 60px; 
            display: flex; 
            flex-direction: column; 
            justify-content: center;
            gap: 20px;
        }
        .category-btn { 
            padding: 14px 28px; 
            border: 1px solid #FF7F50; 
            color: #FF7F50; 
            border-radius: 20px; 
            margin: 5px; 
            cursor: pointer; 
            font-size: 16px;
        }
        .selected { background-color: #FF7F50; color: white; }
        .textarea { 
            width: 100%; 
            height: 140px;
            padding: 14px; 
            border: 1px solid #ccc; 
            border-radius: 5px; 
            font-size: 16px;
        }
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
    	 <img src="${pageContext.request.contextPath}/dist/images/main/main_logo.png" style="width: 100px;">
        <div class="header-left">메이커 스튜디오 | 펀딩·프리오더</div>
        <div class="header-right">
            <button>작성중</button>
            <button>나가기</button>
        </div>
    </div>
    <div class="content">
        <div class="left-section"></div>
        <div class="right-section">
            <h2 style="font-size: 24px; font-weight: bold;">멋진 아이디어가 있으신가요?<br/>어떤 프로젝트를 계획 중이신가요?</h2>
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
            
            <h3 style="font-size: 20px; font-weight: bold;">프로젝트를 간단하게 소개해 주세요.</h3>
            <p style="color: gray; font-size: 16px;">(나중에 변경 가능합니다.)</p>
            
            <textarea class="textarea" placeholder="프로젝트 요약을 작성해 주세요"></textarea>
            
            <button class="next-btn">다음</button>
        </div>
    </div>
</body>
</html>
