<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 사용내역</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<style>
    .admin-content {
        margin-left: 270px;
        padding: 20px 20px 20px;
        min-height: calc(100vh - 60px);
    }
    
    .content-title {
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: bold;
        color: #2c3e50;
    }
    
    .coupon-filter {
        margin-bottom: 20px;
        padding: 15px;
        background: #f8f9fa;
        border-radius: 5px;
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .coupon-filter input, .coupon-filter select {
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .coupon-filter button {
        padding: 8px 12px;
        background: #3498db;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    
    .coupon-filter button:hover {
        background: #2980b9;
    }
    
    .coupon-table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }
    
    .coupon-table th, .coupon-table td {
        padding: 12px 15px;
        border: 1px solid #ddd;
        text-align: center;
        word-break: keep-all;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .coupon-table th:nth-child(1) { width: 7%; }
    .coupon-table th:nth-child(2) { width: 15%; }
    .coupon-table th:nth-child(3) { width: 13%; }
    .coupon-table th:nth-child(4) { width: 18%; }
    .coupon-table th:nth-child(5) { width: 22%; }
    .coupon-table th:nth-child(6) { width: 12%; }
    .coupon-table th:nth-child(7) { width: 13%; }
    
    .coupon-table th {
        background: #34495e;
        color: white;
    }
    
    .coupon-table tr:nth-child(even) {
        background: #f2f2f2;
    }
    
    .coupon-table tr:hover {
        background: #e9f7fe;
    }
    
    .pagination {
        margin-top: 20px;
        display: flex;
        justify-content: center;
        gap: 5px;
    }
    
    .pagination a {
        display: inline-block;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        text-decoration: none;
        color: #333;
    }
    
    .pagination a.active {
        background: #3498db;
        color: white;
        border-color: #3498db;
    }
</style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<div class="admin-container">
    <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
    
    <div class="admin-content">
        <div class="content-title">쿠폰 사용내역</div>
        <div style="margin-bottom: 15px; color: #666;">총 <strong>13</strong>개의 쿠폰이 조회되었습니다.</div>
        
        <div class="coupon-filter">
            <select name="couponType">
                <option value="">쿠폰 종류 전체</option>
                <option value="신규가입">만료</option>
                <option value="첫구매">사용완료</option>
                <option value="기념일">사용가능</option>
            </select>
            <input type="text" name="nickname" placeholder="닉네임 검색">
            <input type="date" name="startDate"> ~ <input type="date" name="endDate">
            <button type="button" id="searchBtn">검색</button>
        </div>
        
        <table class="coupon-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>쿠폰명</th>
                    <th>닉네임</th>
                    <th>사용일자</th>
                    <th>사용 펀딩 상품</th>
                    <th>할인금액</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>신규가입 쿠폰</td>
                    <td>행복한강아지</td>
                    <td>2024-01-15 14:32:22</td>
                    <td>친환경 대나무 텀블러</td>
                    <td>5,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>첫구매 쿠폰</td>
                    <td>바다소금</td>
                    <td>2024-01-20 09:15:43</td>
                    <td>유기농 면 티셔츠</td>
                    <td>3,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>이벤트 쿠폰</td>
                    <td>햇살가득</td>
                    <td>2024-01-27 18:42:11</td>
                    <td>재활용 플라스틱 화분</td>
                    <td>2,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>기념일 쿠폰</td>
                    <td>구름송이</td>
                    <td>2024-02-03 11:23:50</td>
                    <td>태양광 충전기</td>
                    <td>10,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>신규가입 쿠폰</td>
                    <td>별빛달빛</td>
                    <td>2024-02-10 16:37:05</td>
                    <td>생분해성 주방용품 세트</td>
                    <td>5,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>첫구매 쿠폰</td>
                    <td>숲속여우</td>
                    <td>2024-02-15 13:28:39</td>
                    <td>친환경 대나무 칫솔</td>
                    <td>3,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>이벤트 쿠폰</td>
                    <td>단풍나무</td>
                    <td>2024-02-22 10:19:27</td>
                    <td>재생 종이 노트북</td>
                    <td>2,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>기념일 쿠폰</td>
                    <td>바람몰이</td>
                    <td>2024-03-01 15:47:33</td>
                    <td>에코 백팩</td>
                    <td>10,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>신규가입 쿠폰</td>
                    <td>꽃길만걷자</td>
                    <td>2024-03-08 12:05:18</td>
                    <td>유리 빨대 세트</td>
                    <td>5,000원</td>
                    <td><span style="color: #e74c3c;">사용완료</span></td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>첫구매 쿠폰</td>
                    <td>두부왕자</td>
                    <td>2024-03-15 09:38:54</td>
                    <td>태양열 조리기구</td>
                    <td>3,000원</td>
                    <td><span style="color: #7f8c8d;">만료</span></td>
                </tr>
                <tr>
                    <td>11</td>
                    <td>이벤트 쿠폰</td>
                    <td>민들레홀씨</td>
                    <td>2024-03-22 14:21:09</td>
                    <td>에코 샴푸바</td>
                    <td>2,000원</td>
                    <td><span style="color: #7f8c8d;">만료</span></td>
                </tr>
                <tr>
                    <td>12</td>
                    <td>기념일 쿠폰</td>
                    <td>솔방울</td>
                    <td></td>
                    <td></td>
                    <td>10,000원</td>
                    <td><span style="color: #27ae60;">사용가능</span></td>
                </tr>
                <tr>
                    <td>13</td>
                    <td>신규가입 쿠폰</td>
                    <td>하늘연달</td>
                    <td></td>
                    <td></td>
                    <td>5,000원</td>
                    <td><span style="color: #27ae60;">사용가능</span></td>
                </tr>
            </tbody>
        </table>
        
        <div class="pagination">
            <a href="?page=1" class="active">1</a>
            <a href="?page=2">2</a>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 검색 버튼 클릭 시 실행
        document.getElementById('searchBtn').addEventListener('click', function() {
            const couponType = document.querySelector('select[name="couponType"]').value;
            const nickname = document.querySelector('input[name="nickname"]').value;
            const startDate = document.querySelector('input[name="startDate"]').value;
            const endDate = document.querySelector('input[name="endDate"]').value;
            
            let searchParams = new URLSearchParams(window.location.search);
            
            if(couponType) searchParams.set('couponType', couponType);
            else searchParams.delete('couponType');
            
            if(nickname) searchParams.set('nickname', nickname);
            else searchParams.delete('nickname');
            
            if(startDate) searchParams.set('startDate', startDate);
            else searchParams.delete('startDate');
            
            if(endDate) searchParams.set('endDate', endDate);
            else searchParams.delete('endDate');
            
            // 페이지 초기화
            searchParams.set('page', '1');
            
            // 검색 실행
            window.location.href = window.location.pathname + '?' + searchParams.toString();
        });
        
        // URL 파라미터로 필터 필드 초기화
        const urlParams = new URLSearchParams(window.location.search);
        
        if(urlParams.has('couponType')) {
            document.querySelector('select[name="couponType"]').value = urlParams.get('couponType');
        }
        
        if(urlParams.has('nickname')) {
            document.querySelector('input[name="nickname"]').value = urlParams.get('nickname');
        }
        
        if(urlParams.has('startDate')) {
            document.querySelector('input[name="startDate"]').value = urlParams.get('startDate');
        }
        
        if(urlParams.has('endDate')) {
            document.querySelector('input[name="endDate"]').value = urlParams.get('endDate');
        }
    });
</script>
</body>
</html>