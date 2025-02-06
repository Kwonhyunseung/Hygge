<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/usedBoard/write.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/forms.css" type="text/css">

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>

<div class="body-main">
	<div class="body-title">
		<div class="title">중고게시판 글 등록</div>
	</div>
	<div class="body-container">
		<form action="" name="usedBoardForm" method="post">
			<table class="table">
				<tbody>
					<tr>
						<td width="100">제목</td>
						<td><input type="text" name="title"></td>
					</tr>
					<tr>
						<td>제품명</td>
						<td><input type="text" name="product"></td>
					</tr>
					<tr>
						<td>가격</td>
						<td style="text-align: left;">
							<div class="price-container">
								<input type="text" name="price" class="input-price">&nbsp;원
							</div>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control"></textarea></td>
					</tr>
					<tr>
						<td>파일첨부</td>
						<td><input type="file" name="selectFile"></td>
					</tr>
				</tbody>
			</table>
			<table class="table">
				<tr> 
					<td align="center">
						<button type="button" class="btnSend btn" onclick="sendOk();">${mode=='update'?'수정하기':'등록하기'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/usedBoard/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>