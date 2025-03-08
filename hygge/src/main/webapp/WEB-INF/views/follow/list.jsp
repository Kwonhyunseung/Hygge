<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로잉 메이커</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/follow.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">

<script type="text/javascript">
$(function() {
    // 메이커 언팔로우
    $(".heart-icon").click(function() {
        let makerIdx = $(this).attr("data-maker");
        let $item = $(this).closest(".maker-item");
        
        if(confirm("메이커를 언팔로우하시겠습니까?")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/follow/unfollow",
                type: "POST",
                data: {makerIdx: makerIdx},
                dataType: "json",
                success: function(data) {
                    if(data.state === "success") {
                        $item.fadeOut(300, function() {
                            $(this).remove();
                            
                            if($(".maker-item").length === 0) {
                                $(".maker-list").html('<div class="empty-follow">팔로잉한 메이커가 없습니다.</div>');
                            }
                        });
                    } else {
                        alert(data.message || "언팔로우에 실패했습니다.");
                    }
                },
                error: function(jqXHR) {
                    console.log("언팔로우 요청 중 오류 발생:", jqXHR.responseText);
                    alert("언팔로우 중 오류가 발생했습니다.");
                }
            });
        }
    });
    
    $(".maker-name").click(function() {
        let makerIdx = $(this).attr("data-maker");
        location.href = "${pageContext.request.contextPath}/maker/detail/" + makerIdx;
    });
});
</script>
</head>
<body>
<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<div class="maker-container">
    <div class="maker-header">
        <i class="bi bi-person-heart"></i>
        <h3>FOLLOWING MAKER (${followCount})</h3>
    </div>

    <div class="maker-list">
        <c:if test="${empty list}">
            <div class="empty-follow">팔로잉한 메이커가 없습니다.</div>
        </c:if>
        
        <c:forEach var="maker" items="${list}">
            <!-- 메이커 아이템 -->
            <div class="maker-item">
                <div class="maker-banner">
                    <c:choose>
                        <c:when test="${not empty maker.profile_img}">
                            <img src="${pageContext.request.contextPath}/uploads/profile/${maker.profile_img}" alt="${maker.makerName}" class="banner-image">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/dist/images/logo.jpg" alt="${maker.makerName}" class="banner-image">
                        </c:otherwise>
                    </c:choose>
                    <i class="bi bi-heart-fill heart-icon" data-maker="${maker.memberIdx}"></i>
                </div>
                <div class="maker-info">
                    <h4 class="maker-name" data-maker="${maker.memberIdx}">${maker.makerName}</h4>
                    <p class="maker-description">${maker.introduction}</p>
                    <div class="maker-stats">
                        <span class="stat-item">
                            <i class="bi bi-box-seam"></i>
                            진행 프로젝트: ${maker.projectCount}개
                        </span>
                        <span class="stat-item">
                            <i class="bi bi-people"></i>
                            팔로워: <fmt:formatNumber value="${maker.followerCount}" pattern="#,###"/>
                        </span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>