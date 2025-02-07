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
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/admin/left.js"></script>

</head>
<body>

<div class="left-side-bar">
    <ul class="menu-list">
        <li class="menu-item">
            <span class="menu-title">회원 관리</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/memberManagement/normal">일반유저 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/memberManagement/maker">메이커 관리</a></li>
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
            <a href="${pageContext.request.contextPath}/admin/projectManagement/list" class="menu-title">프로젝트 관리</a>
            <ul class="sub-menu">
            </ul>
        </li>
        
        <li class="menu-item">
            <span class="menu-title">글 관리</span>
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/admin/usedBoard/list">중고 게시글</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/tester/list">후기 관리</a></li>
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