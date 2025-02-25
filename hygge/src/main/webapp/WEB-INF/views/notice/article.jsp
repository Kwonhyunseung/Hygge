<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/notice/article.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
</head>

<body>

<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>
	<div></div>
    <div class="notice-container">
        <div class="notice-header">
            <h1 class="notice-title">${dto.title}</h1>
            <div class="notice-date">
           		 <fmt:formatDate value="${dto.regDate}" pattern="yyyy.MM.dd"/>
            </div>
        </div>
        
        <div class="notice-content">
            <p>
            	${dto.content}
            </p>
        </div>
        
        <div class="image-section">
            <div class="image-container">
			<c:if test="${not empty files}">
			    <div class="image-section">
			        <div class="image-container">
			            <c:forEach var="file" items="${files}">
			                <!-- 파일 이름에서 확장자 추출 -->
			                <c:set var="fileNameLower" value="${file.s_FileName.toLowerCase()}" />
			                <!-- 이미지 파일 확장자 체크 -->
			                <c:if test="${fileNameLower.endsWith('.jpg') || fileNameLower.endsWith('.jpeg') || 
			                              fileNameLower.endsWith('.png') || fileNameLower.endsWith('.gif') || 
			                              fileNameLower.endsWith('.bmp')}">
			                    <img src="${pageContext.request.contextPath}/uploads/notice/${file.s_FileName}" alt="공지사항 이미지">
			                </c:if>
			            </c:forEach>
			        </div>
			    </div>
			</c:if>
            </div>
        </div>
        
		<div class="navigation">
		<div class="nav-item">
		<span class="nav-label">이전 글:</span>
		<c:choose>
		    <c:when test="${not empty prevDto}">
		        <a href="${pageContext.request.contextPath}/notice/article/${prevDto.num}?${query}">${prevDto.title}</a>
		    </c:when>
		    <c:otherwise>
		        이전 글이 없습니다.
		    </c:otherwise>
		</c:choose>
		</div>
		<div class="nav-item">
		<span class="nav-label">다음 글:</span>
		<c:choose>
		    <c:when test="${not empty nextDto}">
		        <a href="${pageContext.request.contextPath}/notice/article/${nextDto.num}?${query}">${nextDto.title}</a>
		    </c:when>
		    <c:otherwise>
		        다음 글이 없습니다.
		    </c:otherwise>
		</c:choose>
		</div>
		</div>
    </div>
    
    <div class="button-container">
    <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/notice/list?page=${page}&${query}';">목록</button>
</div>
</body>

<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
</body>
</html>