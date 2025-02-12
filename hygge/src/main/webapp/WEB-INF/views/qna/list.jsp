<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        padding: 20px;
    }
    .container {
        max-width: 1000px;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
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
    .btn-primary {
        background-color: #82B10C !important;
        border-color: #82B10C !important;
        color: white !important;
    }
    .btn-primary:hover {
        background-color: #6a9009 !important;
        border-color: #6a9009 !important;
    }
    .content-wrapper {
        padding: 20px;
    }
    .category-filter {
        margin-bottom: 15px;
        text-align: right;
    }
</style>
<script>
function filterCategory() {
    var selectedCategory = document.getElementById("category").value;
    var rows = document.querySelectorAll(".qna-row");

    rows.forEach(function(row) {
        var category = row.getAttribute("data-category");

        // 선택한 카테고리에 맞게 표시/숨김 처리
        if (selectedCategory === "all" || category === selectedCategory) {
            row.style.display = ""; // 카테고리가 맞으면 표시
        } else {
            row.style.display = "none"; // 카테고리가 맞지 않으면 숨김
        }
    });
}
</script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
    <div class="content-wrapper">
        <div class="container">
            <h2 class="text-center mb-4">1:1 문의 게시판</h2>
            
            <!-- 카테고리 필터 -->
<div class="category-filter">
    <label for="category">카테고리:</label>
    <select id="category" class="form-select d-inline-block w-auto" onchange="filterCategory()">
        <option value="all">전체</option>
        <option value="1">상품</option>
        <option value="2">배송</option>
        <option value="3">결제</option>
        <option value="4">회원</option>
        <option value="5">기타</option>
    </select>
</div>

            <!-- 문의 목록 -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="qna" items="${qnaList}">
                        <tr class="qna-row" data-category="${qna.category}">
                            <td>${qna.num}</td>
                            <td>${qna.name}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/qna/article?num=${qna.num}">
                                    ${qna.q_Title}  <!-- 질문 제목 -->
                                </a>
                            </td>
                            <td>${qna.userName}</td>
                            <td><fmt:formatDate value="${qna.q_Date}" pattern="yyyy-MM-dd" /></td>  <!-- 질문 날짜 -->
                            <td>
                                <c:choose>
                                    <c:when test="${qna.block == 1}">
                                        <span class="badge bg-warning">대기</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">완료</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 문의 작성 버튼 -->
            <div class="text-end">
                <a href="${pageContext.request.contextPath}/qna/write" class="btn btn-primary" style="height: 39px;">문의 작성</a>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
</body>
</html>
