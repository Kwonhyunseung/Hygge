<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

</style>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<div class="header">
    <div class="header-title">
        <h2 class="admin-title"><span>|</span> <a href="${pageContext.request.contextPath}/admin">관리자 페이지</a></h2>
    </div>
    <div class="header-right">
        <span>관리자님</span>
        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/logout';">로그아웃</button>
    </div>
</div>

