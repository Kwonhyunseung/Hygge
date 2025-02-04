<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- 더보기 메뉴 -->
<div class="more-menu-container">
    <div class="menu-items d-flex justify-content-center">
        <a href="${pageContext.request.contextPath}/today" class="more-menu-item">
            <div class="circle-menu">
                <span>이달의 투표</span>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/event" class="more-menu-item">
            <div class="circle-menu">
                <span>이벤트</span>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/notice" class="more-menu-item">
            <div class="circle-menu">
                <span>공지사항</span>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/experience" class="more-menu-item">
            <div class="circle-menu">
                <span>체험단</span>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/market" class="more-menu-item">
            <div class="circle-menu">
                <span>중고게시판</span>
            </div>
        </a>
    </div>
</div>