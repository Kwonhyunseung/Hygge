<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYWISHLIST</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/wish.css" type="text/css">
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">

<script type="text/javascript">
$(function() {
	// 위시리스트에서 삭제
	$(".heart-icon").click(function() {
	    let num = $(this).attr("data-num");
	    let $item = $(this).closest(".wishlist-item");
	    
	    if(confirm("위시리스트에서 제거하시겠습니까?")) {
	        $.ajax({
	            url: "${pageContext.request.contextPath}/wish/remove",
	            type: "POST",
	            data: {num: num},
	            dataType: "json",
	            success: function(data) {
	                if(data.state === "success") {
	                    $item.fadeOut(300, function() {
	                        $(this).remove();
	                        
	                        if($(".wishlist-item").length === 0) {
	                            $(".wishlist-items").html('<div class="empty-wish">위시리스트에 추가된 프로젝트가 없습니다.</div>');
	                        }
	                    });
	                } else {
	                    alert(data.message || "삭제에 실패했습니다.");
	                }
	            },
	            error: function(jqXHR) {
	                console.log("삭제 요청 중 오류 발생:", jqXHR.responseText);
	                alert("위시리스트 삭제 중 오류가 발생했습니다.");
	            }
	        });
	    }
	});
    
    $(".item-info, .item-image").click(function() {
        let num = $(this).closest(".wishlist-item").find(".buyBtn").attr("data-num");
        location.href = "${pageContext.request.contextPath}/funding/product/" + num;
    });
    
    $(".buyBtn").click(function() {
        let num = $(this).attr("data-num");
        location.href = "${pageContext.request.contextPath}/buy/productList/" + num;
    });
});
</script>
</head>
<body>
<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<div class="wishlist-container">
    <div class="wishlist-header">
        <i class="bi bi-heart-fill"></i>
        <h3>MY WISHLIST</h3>
    </div>

    <div class="wishlist-items">
        <c:if test="${empty list}">
            <div class="empty-wish">위시리스트에 추가된 프로젝트가 없습니다.</div>
        </c:if>
        
        <c:forEach var="item" items="${list}">
            <div class="wishlist-item">
                <div class="item-image-container">
                    <img src="${pageContext.request.contextPath}/uploads/project/${item.thumbnail}" class="item-image">
                    <i class="bi bi-heart-fill heart-icon" data-num="${item.num}"></i>
                </div>
                <div class="item-info">
                    <h4>${item.title}</h4>
                </div>
                <button class="buyBtn" data-num="${item.num}">구매하기</button>
            </div>
        </c:forEach>
    </div>
    
</div>

<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>