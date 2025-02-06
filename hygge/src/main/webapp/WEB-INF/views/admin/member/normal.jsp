<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반유저</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/member/normal.css" type="text/css">
</head>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <div class="main-content">
            <h2>일반회원 관리</h2>
            
            <div class="search-container">
                <form class="search-form">
                    <select class="search-input">
                        <option>전체</option>
                        <option>정상회원</option>
                        <option>차단회원</option>
                        <option>승인대기</option>
                    </select>
                    <input type="text" class="search-input" placeholder="회원 검색...">
                    <button type="submit" class="search-button">검색</button>
                </form>
            </div>

            <table class="member-table">
                <thead>
                    <tr>
                        <th>회원번호</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>가입일</th>
                        <th>신고횟수</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1001</td>
                        <td>홍길동</td>
                        <td>hong@example.com</td>
                        <td>2024-02-01</td>
                        <td>0</td>
                        <td><span class="status-badge status-active">정상</span></td>
                        <td>
                            <button class="action-button block-button">차단</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1002</td>
                        <td>김철수</td>
                        <td>kim@example.com</td>
                        <td>2024-02-03</td>
                        <td>3</td>
                        <td><span class="status-badge status-blocked">차단</span></td>
                        <td>
                            <button class="action-button approve-button">차단해제</button>
                        </td>
                    </tr>
                    <!-- 더미 데이터 추가 -->
                </tbody>
            </table>

            <div class="pagination">
                <a href="#">&laquo;</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
                <a href="#">5</a>
                <a href="#">&raquo;</a>
            </div>
        </div>
    </div>
    

</body>
</html>