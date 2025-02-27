<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
.rcontainer {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
    margin: 40px auto;
    width: 800px;
    min-height: 400px;
}
h2 {
    text-align: center;
    margin-bottom: 20px;
}
.stars {
    display: flex;
    justify-content: center;
    margin-bottom: 15px;
}
.star {
    font-size: 1.8rem;
    cursor: pointer;
    color: #ddd;
}
.star.selected {
    color: #82B10C;
}
</style>
</head>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<body>

<main style="width: 1200px; margin: auto;">
    <div class="rcontainer">
        <h2>상품 후기 작성</h2>
       <input type="hidden" name="sales_num" value="${sales_num}" />
        <form action="${pageContext.request.contextPath}/myPage/rwrite" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-control" value="${title}"required>
            </div>
            <div class="stars mb-3">
                <span class="star" data-value="1">★</span>
                <span class="star" data-value="2">★</span>
                <span class="star" data-value="3">★</span>
                <span class="star" data-value="4">★</span>
                <span class="star" data-value="5">★</span>
            </div>
            <input type="hidden" name="grade" id="grade" value="5">
            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">등록</button>
                <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
</main>


<script type="text/javascript">
$(function() {
    $('.star').click(function() {
        let value = $(this).data('value');
        $('#grade').val(value);
        $('.star').removeClass('selected');
        $(this).prevAll().addBack().addClass('selected');
    });
});
</script>
</body>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>