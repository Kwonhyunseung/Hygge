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
    .custom-btn {
        display: inline-block;
        padding: 10px 20px;
        background: #ff7f50;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 14px;
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
    /* 1대1문의 버튼 스타일 */
    .inquiry-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 9999;
    }
    .inquiry-btn {
        background: #ff7f50;
        color: white;
        padding: 12px 20px;
        text-decoration: none;
        border-radius: 21px;
        font-size: 17px;
        box-shadow: 0 0 5px rgba(0,0,0,0.3);
        font-weight: bold;
    }
</style>
<script>
    // 기존 좋아요 토글 함수 (필요 시 jQuery AJAX 코드와 별도로 사용)
    function toggleLike(button) {
        var likeCount = button.querySelector(".like-count");
        var count = parseInt(likeCount.innerText);
        if (button.classList.contains("liked")) {
            button.classList.remove("liked");
            likeCount.innerText = count - 1;
        } else {
            button.classList.add("liked");
            likeCount.innerText = count + 1;
        }
    }
    
    // jQuery를 사용한 좋아요 AJAX 처리 코드
    $(function(){
        let isLiked = $('.custom-like-btn').hasClass('active');  // 초기 좋아요 상태 저장
        $('.custom-like-btn').click(function(e){
            e.preventDefault();
            const $btn = $(this);
            // <i> 요소가 있다면 선택, 없다면 빈 객체
            const $i = $btn.find('i');
            // 버튼에 data-num 속성이 있어야 함 (게시글 번호)
            const num = $btn.data('num');
            let msg;
            
            if($btn.hasClass('active')) {
                msg = '좋아요를 취소하시겠습니까?';
            } else {
                msg = '이 프로젝트를 좋아요 하시겠습니까?';
            }
    
            if(!confirm(msg)) {
                return false;
            }
    
            let url = '/makerPage/boardLike';
            let params = {
            		mkboard_Num : num,
                userLiked: $btn.hasClass('active')
            };
    
            $.ajax({
                type: 'post',
                url: url,
                data: params,
                dataType: 'json',
                success: function(data) {
                    if(data.message) {
                        alert(data.message);
                        if(data.message === '로그인이 필요한 서비스입니다.') {
                            location.href = '/member/login';
                        }
                        return;
                    }
    
                    if(data.state === "true") {
                        if(data.isLiked) {
                            if($i.length){
                                $i.removeClass('bi-suit-heart').addClass('bi-suit-heart-fill');
                            }
                            $btn.addClass('active');
                        } else {
                            if($i.length){
                                $i.removeClass('bi-suit-heart-fill').addClass('bi-suit-heart');
                            }
                            $btn.removeClass('active');
                        }
                        $('.like-count').text(data.likeCount);
                        
                        // 좋아요 상태 업데이트
                        isLiked = data.isLiked;
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
        <!-- 게시판 헤더는 리스트의 첫 번째 항목의 이름으로 표시 -->
        <div class="custom-board-header">${listBoard[0].name}님의 게시판</div>
    </c:if>
    <div class="custom-board-posts">
        <c:forEach var="board" items="${listBoard}">
            <div class="custom-container">
                <div class="custom-title">${board.title}</div>
                <div class="custom-image-container">
                    <img src="${pageContext.request.contextPath}/uploads/project/perfume_1.jpg" alt="신제품 이미지">
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

<div class="inquiry-button">
    <a href="#" class="inquiry-btn">1대1문의</a>
</div>

</body>
</html>
