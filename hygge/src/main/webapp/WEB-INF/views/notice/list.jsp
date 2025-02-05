<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
</style>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
</head>
<body>

<header>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<div class="container py-5">
        <h1 class="mb-4" style="color: #5E8400;">공지사항</h1>
        
        <!-- Search Form -->
        <!-- Search Form -->
		<div class="row justify-content-end mb-4">
		    <div class="col-md-6">
		        <form action="/notice/search" method="GET" class="d-flex">
		            <div class="input-group">
		                <select name="searchType" class="form-select" style="max-width: 150px; border-radius: 5px 0 0 5px;">
		                    <option value="all" ${param.searchType == 'all' ? 'selected' : ''}>제목+내용</option>
		                    <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
		                    <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
		                </select>
		                <input type="text" name="keyword" class="form-control" 
		                    placeholder="검색어를 입력해 주세요." 
		                    value="${param.keyword}">
		                <button class="btn btn-outline-secondary" type="submit" style="border: 1px solid #ced4da;">
		                    <i class="bi bi-search"></i>
		                </button>
		            </div>
		        </form>
		    </div>
		</div>

        <!-- Notice List -->
    <div class="border-top border-dark">
        <!-- 중요 공지 1 -->
        <div class="notice-item py-3 border-bottom">
        	<span class="badge bg-danger py-2 px-3 animate__animated animate__pulse animate__infinite">중요
                <span class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
                    <span class="visually-hidden">New alerts</span>
                </span>
            </span>
            <div class="mt-2">
                <a href="/notice/detail/1" class="text-decoration-none text-dark">
                    [작접/경력] 개인정보처리방침 개정 안내 [HYGGE]
                </a>
                <div class="text-muted mt-1" style="font-size: 0.9rem;">2025.02.02</div>
            </div>
        </div>

        <!-- 중요 공지 2 -->
        <div class="notice-item py-3 border-bottom">
        <span class="badge bg-danger py-2 px-3 position-relative"></span>
            <span class="important-notice">중요</span>
            <div class="mt-2">
                <a href="/notice/detail/2" class="text-decoration-none text-dark">
                    [작접/경력] 개인정보처리방침 개정 안내 [HYGGE]
                </a>
                <div class="text-muted mt-1" style="font-size: 0.9rem;">2025.02.02</div>
            </div>
        </div>

        <!-- 일반 공지 with 이미지 -->
        <div class="notice-item py-3 border-bottom">
	            <div class="d-flex justify-content-between">
                <div class="flex-grow-1 d-flex flex-column justify-content-between" style="min-height: 110px;">
                    <a href="/notice/detail/3" class="text-decoration-none text-dark">
                        펫 전담 백화점 기획전 참여 브랜드/입점업체서 공개 모집
                    </a>
                    <div class="text-muted" style="font-size: 0.9rem;">2025.02.02</div>
                </div>
                <div class="ms-3">
                    <img src="/dist/images/notice/거인.jpg" alt="메이커 모집 이미지" class="img-fluid" style="max-width: 200px;">
                </div>
	            </div>
	        </div>
	   	</div>
	</div>
        

        <%-- 
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item">
                        <a class="page-link" href="/notice?page=${pageMaker.startPage-1}">&lt;</a>
                    </li>
                </c:if>
                
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
                    <li class="page-item ${pageMaker.cri.page == pageNum ? 'active' : ''}">
                        <a class="page-link" href="/notice?page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>

                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link" href="/notice?page=${pageMaker.endPage+1}">&gt;</a>
                    </li>
                </c:if>
            </ul>
        </nav> --%>
    </div>

<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

</body>
</html>