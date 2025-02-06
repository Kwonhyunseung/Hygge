<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>1:1 문의 게시판</title>
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
        var rows = document.querySelectorAll(".inquiry-row");

        rows.forEach(function(row) {
            var category = row.getAttribute("data-category");
            if (selectedCategory === "all" || category === selectedCategory) {
                row.style.display = "";
            } else {
                row.style.display = "none";
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
                    <option value="상품">상품</option>
                    <option value="배송">배송</option>
                    <option value="결제">결제</option>
                    <option value="회원">회원</option>
                    <option value="기타">기타</option>
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
                    <tr class="inquiry-row" data-category="상품">
                        <td>1</td>
                        <td>상품</td>
                        <td><a href="${pageContext.request.contextPath}/inquiry/article">상품 문의</a></td>
                        <td>사용자1</td>
                        <td>2025-02-06</td>
                        <td><span class="badge bg-warning">대기</span></td>
                    </tr>
                    <tr class="inquiry-row" data-category="배송">
                        <td>2</td>
                        <td>배송</td>
                        <td><a href="${pageContext.request.contextPath}/inquiry/article">배송 관련 문의</a></td>
                        <td>사용자2</td>
                        <td>2025-02-05</td>
                        <td><span class="badge bg-success">완료</span></td>
                    </tr>
                    <tr class="inquiry-row" data-category="결제">
                        <td>3</td>
                        <td>결제</td>
                        <td><a href="${pageContext.request.contextPath}/inquiry/article">결제 취소 문의</a></td>
                        <td>사용자3</td>
                        <td>2025-02-04</td>
                        <td><span class="badge bg-warning">대기</span></td>
                    </tr>
                    <tr class="inquiry-row" data-category="회원">
                        <td>4</td>
                        <td>회원</td>
                        <td><a href="${pageContext.request.contextPath}/inquiry/article">회원 탈퇴 문의</a></td>
                        <td>사용자4</td>
                        <td>2025-02-03</td>
                        <td><span class="badge bg-success">완료</span></td>
                    </tr>
                    <tr class="inquiry-row" data-category="기타">
                        <td>5</td>
                        <td>기타</td>
                        <td><a href="${pageContext.request.contextPath}/inquiry/article">기타 문의</a></td>
                        <td>사용자5</td>
                        <td>2025-02-02</td>
                        <td><span class="badge bg-warning">대기</span></td>
                    </tr>
                </tbody>
            </table>

            <!-- 문의 작성 버튼 -->
            <div class="text-end">
                <a href="${pageContext.request.contextPath}/inquiry/write" class="btn btn-primary" style="height : 39px;">문의 작성</a>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
</body>
</html>
