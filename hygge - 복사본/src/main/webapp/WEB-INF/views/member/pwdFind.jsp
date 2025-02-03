﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	

	        <div class="row justify-content-md-center">
	            <div class="col-md-7 pt-5">
	                <div class="border mt-5 p-4">
	                    <form name="pwdForm" method="post" class="row g-3">
	                        <h3 class="text-center fw-bold">패스워드 찾기</h3>
	                        
			                <div class="d-grid">
								<p class="form-control-plaintext text-center">회원 아이디를 입력 하세요.</p>
			                </div>
	                        
	                        <div class="d-grid">
	                            <input type="text" name="userId" class="form-control form-control-lg" placeholder="아이디">
	                        </div>
	                        <div class="d-grid">
	                            <button type="button" class="btn btn-lg btn-primary" onclick="sendOk();">확인 <i class="bi bi-check2"></i> </button>
	                        </div>
	                    </form>
	                </div>
	
	                <div class="d-grid">
						<p class="form-control-plaintext text-center py-3">${message}</p>
	                </div>
	            </div>
	        </div>

		</div>
	</div>
</main>

<script type="text/javascript">
function sendOk() {
	const f = document.pwdForm;

	let str = f.userId.value.trim();
	if(!str) {
		alert('아이디를 입력하세요. ');
		f.userId.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>