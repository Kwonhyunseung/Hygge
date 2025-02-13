<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
/* 전체 스타일 */
.content-wrapper {
    padding: 20px;
    background-color: #f9f9f9;
}

/* 컨테이너 스타일 */
.container {
    max-width: 800px;
    margin: 50px auto;
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
}

/* 제목 스타일 */
h2 {
    text-align: center;
    margin-bottom: 20px;
}

/* 카테고리 스타일 */
.category-label {
    display: inline-block;
    background-color: #82B10C;
    color: white;
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 14px;
    margin-bottom: 15px;
}

/* 문의 정보 테이블 */
.table th {
    background-color: #82B10C !important;
    color: white !important;
    text-align: center;
    vertical-align: middle;
}
.table td {
    text-align: center;
    vertical-align: middle;
}

/* 문의 내용 스타일 */
.qna-content {
    padding: 20px;
    background-color: #f5f5f5;
    border-radius: 5px;
    margin-top: 20px;
    word-break: break-word;
}

/* 관리자 답변 스타일 */
.answer-box {
    margin-top: 20px;
    padding: 15px;
    background-color: #e6f4ea;
    border-left: 4px solid #82B10C;
    border-radius: 5px;
}

/* 버튼 스타일 */
.btn-custom {
    width: 150px;
}
</style>
</head>
<body>

<!-- 헤더 -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 본문 내용 -->
<div class="content-wrapper">
    <div class="container">
        <h2>문의 상세보기</h2>

        <!-- 카테고리 정보 -->
        <div class="text-center">
            <span class="category-label">${qna.name}</span>
        </div>

        <!-- 문의 정보 -->
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th>제목</th>
                    <td>${qna.q_Title}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td><fmt:formatDate value="${qna.q_Date}" pattern="yyyy-MM-dd HH:mm" /></td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty qna.a_Content}">
                                <span class="badge bg-success">완료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning">대기</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="qna-content">
            <strong>질문</strong>
            <p>${qna.q_Content}</p>
        </div>

        <!-- 관리자 답변 -->
        <c:if test="${not empty qna.a_Content}">
            <div class="answer-box">
                <strong>관리자 답변</strong>
                <p>${qna.a_Content}</p>
            </div>
        </c:if>

        <!-- 버튼 영역 -->
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/qna/list" class="btn btn-secondary btn-custom">목록으로</a>
            <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-primary btn-custom" style="height: 38px; background-color:#82B10C; border-radius: 7px;">마이페이지</a>
        </div>
    </div>
</div>

<!-- 푸터 -->
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>

</body>
</html>
