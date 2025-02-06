<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/usedBoard/article.css" type="text/css">

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>
<div class="body-container">
	<div class="body-title">
		<div class="title">중고게시판</div>
	</div>
	<div class="body-main">
		<div class="body-content">
			<div class="img-container">
				<img src="${pageContext.request.contextPath}/dist/images/sample.jpg">
			</div>
			<div class="content-container">
				<div class="article-title">
					두 번 쓴 물티슈
					<i class="bi bi-three-dots-vertical" title="메뉴"></i>
				</div>
				<div class="product">제품명&nbsp; lg 생활건강 물티슈</div>
				<div class="price">가격&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #E95151; font-style: italic;">1,000,000,000</span> 원</div>
				<div class="article-content">급전이 필요해서 싸게 팝니다</div>
			</div>
		</div>
		<table class="body-footer">
			<tr style="width: 100%; border-bottom: 1px solid #E1E1E1;">
				<td style="width: 20%">다음 글 </td>
				<td><a href="#">한 번 쓴 물티슈 팔아요</a></td>
			</tr>
			<tr>
				<td>이전 글 </td>
				<td><a href="#">세 번보다 적게 쓴 물티슈 팔아요</a></td>
			</tr>
		</table>
		<div class="reply">
			<form name="replyForm" method="post">
				<div class="form-header">
					<span class="bold">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
				</div>
				
				<table class="table table-borderless reply-form">
					<tr>
						<td>
							<textarea class="form-control" name="content"></textarea>
						</td>
					</tr>
					<tr>
					   <td align="right">
							<button type="button" class="btn btn-light btnSendReply">댓글 등록</button>
						</td>
					 </tr>
				</table>
			</form>
			
			<div id="listReply"></div>
		</div>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>