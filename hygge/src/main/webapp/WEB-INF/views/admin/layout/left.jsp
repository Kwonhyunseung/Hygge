<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>


<script type="text/javascript">
$(function(){
    // 메뉴 클릭시 서브메뉴 토글
    $(".menu-title").click(function(){
        const $menu = $(this).closest(".menu-item");
        const $subMenu = $(this).next(".sub-menu");
        
        // 다른 열린 메뉴 닫기
        $(".sub-menu").not($subMenu).slideUp(300);
        
        // 클릭된 메뉴 토글
        $subMenu.slideToggle(300);
    });

    // 현재 페이지 메뉴 활성화
    var url = window.location.pathname;
    $('.sub-menu a').each(function() {
        if (url.endsWith($(this).attr('href'))) {
            $(this).addClass('active');
            $(this).closest('.sub-menu').show();
        }
    });
});
</script>
</head>
<body>

<div class="left-side-bar">
    <ul class="menu-list">
        <li class="menu-item">
            <span class="menu-title">회원 관리</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/member/list">일반유저 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/member/makerList">메이커 관리</a></li>
            </ul>
        </li>
        
        <li class="menu-item">
            <span class="menu-title">체험단</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/experience/list">가입 승인</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/experience/reject">거절</a></li>
            </ul>
        </li>
        
        <li class="menu-item">
            <span class="menu-title">프로젝트 관리</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/project/list">승인 대기</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/project/ongoing">진행중</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/project/complete">완료</a></li>
            </ul>
        </li>
        
        <li class="menu-item">
            <span class="menu-title">글 관리</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/board/used">중고 게시글</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/board/review">후기 관리</a></li>
            </ul>
        </li>
        
        <li class="menu-item">
            <span class="menu-title">공지사항</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/notice/event">이벤트</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/notice/vote">투표</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/notice/list">공지사항</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/notice/qna">1:1문의</a></li>
            </ul>
        </li>
    </ul>
</div>

</body>
</html>