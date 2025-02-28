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
<title>상품 후기</title>
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
    min-height: 500px;
}
h2 {
    text-align: center;
    margin-bottom: 20px;
}
.review-box {
    border: 1px solid #ddd;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 15px;
    background-color: #f8f9fa;
}
.review-box h5 {
    margin-bottom: 5px;
    font-weight: bold;
}
.review-box p {
    margin-bottom: 10px;
}
.review-box .review-date {
    font-size: 0.9em;
    color: gray;
}
.stars {
    color: #82B10C;
    font-size: 1.2em;
    margin-bottom: 5px;
}

.delete-review:hover {
	color: #82B10C;
}
.image-container {
    flex-shrink: 0;
    border-radius: 4px;
    overflow: hidden;
    transition: transform 0.2s;
}

.image-container:hover {
    transform: scale(1.03);
}

.image-container img {
    border-radius: 3px;
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<main style="width: 1200px; margin: auto;">
    <div class="rcontainer">
        <h2 style="margin-bottom: 1.5rem;">상품 후기</h2>
        <c:if test="${not empty reviewList}">
        <c:forEach var="review" items="${reviewList}">
    <div class="review-box" data-num="${review.review_num}">
        <div class="d-flex">
            <div class="image-container me-3" style="width: 150px; height: 150px; border: 1px solid #ddd; padding: 5px;">
                <c:choose>
                    <c:when test="${empty review.review_img}">
                        <div class="d-flex align-items-center justify-content-center h-100" 
                             style="background-color: #f8f9fa; color: #666;">
                            이미지 없음
                        </div>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/uploads/review/${review.review_img}" 
                             alt="리뷰 이미지" 
                             style="width: 100%; height: 100%; object-fit: cover;">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="flex-grow-1">
                <h5>${review.title}</h5>
                <div style="display: flex; flex-direction: row; justify-content: space-between;">
                    <div class="stars">
                        <c:forEach begin="1" end="${review.grade}" varStatus="status">
                            ★
                        </c:forEach>
                        <c:forEach begin="${review.grade+1}" end="5" varStatus="status">
                            ☆
                        </c:forEach>
                    </div>
                    <div>
                        <span class="delete-review" style="margin-right: 5px; cursor: pointer;">삭제</span>
                    </div>
                </div>
                <p>${review.content}</p>
                <p class="review-date">${review.reg_date}</p>
            </div>
        </div>
    </div>
</c:forEach>
        </c:if>
        <c:if test="${empty reviewList}">
        	<div class="content-container">
        		작성한 후기가 존재하지 않습니다.
        	</div>
        </c:if>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">마이페이지로 돌아가기</a>
        </div>
    </div>
</main>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script type="text/javascript">
$(function() {
	$('.delete-review').click(function() {
		if(!confirm('리뷰를 삭제하시겠습니까?')) {
			return false;
		}
		let num = $(this).closest('.review-box').attr('data-num');
		
		let url = '${pageContext.request.contextPath}/myPage/deleteReview?num=' + num;
		location.href = url;
	});
});
</script>
</body>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>
