<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
    .custom-body {
        font-family: Arial, sans-serif;
        color: #333;
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .custom-board-container {
        width: 90%;
        max-width: 900px;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
        margin-top: 30px;
    }
    .custom-board-header {
        font-size: 24px;
        font-weight: bold;
        color: #ff7f50;
        text-align: center;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }
    .custom-board-posts {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
    .custom-container {
        background: #ffffff;
        padding: 16px;
        width: 100%;
        max-width: 800px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .custom-title {
        font-size: 20px;
        font-weight: bold;
        color: #ff7f50;
        text-align: center;
    }
    .custom-content {
        margin-top: 20px;
        margin-bottom: 20px;
        font-size: 16px;
        line-height: 1.6;
        text-align: center;
    }
    .custom-like-section {
        text-align: center;
        margin-top: 15px;
    }
    .custom-like-btn {
        background: none;
        border: none;
        color: #ff7f50;
        font-size: 16px;
        cursor: pointer;
    }
    .custom-image-container {
        border: 1px solid #ff7f50;
        text-align: center;
        margin-top: 15px;
    }
    .custom-image-container img {
        width: 100%;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function(){
        $('.custom-like-btn').click(function(e){
            e.preventDefault();
            const $btn = $(this);
            const $likeCount = $btn.find(".like-count");
            const num = $btn.data('num');
            let url = '/makerPage/boardLike';
            let params = {
                mkboard_Num: num,
                userLiked: $btn.hasClass('active')
            };
            $.ajax({
                type: 'post',
                url: url,
                data: params,
                dataType: 'json',
                success: function(data) {
                    if(data.state === "true") {
                        $btn.toggleClass('active');
                        $likeCount.text(data.likeCount);
                    } else {
                        alert('서버 오류가 발생했습니다.');
                    }
                },
                error: function(jqXHR) {
                    if(jqXHR.status === 401) {
                        alert('로그인이 필요한 서비스입니다.');
                        location.href = '/member/login';
                    } else {
                        console.error('Error:', jqXHR);
                        alert('서버 오류가 발생했습니다.');
                    }
                }
            });
        });
    });
</script>
</head>
<body class="custom-body">
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
<main>
   <div class="custom-board-container">
    <c:if test="${not empty listBoard}">
        <div class="custom-board-header">${listBoard[0].name}님의 게시판</div>
    </c:if>
    <div class="custom-board-posts">
        <c:forEach var="board" items="${listBoard}">
            <div class="custom-container">
                <div class="custom-title">${board.title}</div>
              	<div class="custom-image-container">
				    <c:choose>
				        <c:when test="${not empty board.sfileName}">
				            <img src="${pageContext.request.contextPath}/uploads/makerBoard/${board.sfileName}" alt="신제품 이미지">
				        </c:when>
				        <c:otherwise>
				            <img src="${pageContext.request.contextPath}/uploads/makerBoard/nophoto.jpg" alt="대체 이미지">
				        </c:otherwise>
				    </c:choose>
				</div>
                <div class="custom-content">
                    ${board.content}
                </div>
                <div class="custom-like-section">
                    <button class="custom-like-btn" data-num="${board.mkboard_Num}">
                        ❤️ 좋아요 <span class="like-count">${board.likeCount}</span>
                    </button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</main>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>