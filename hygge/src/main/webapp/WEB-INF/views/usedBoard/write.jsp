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
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<script type="text/javascript">
function sendOk() {
	const f = document.usedBoardForm;
	let val;

	val = f.title.value.trim();
	if (!val) {
		f.title.focus();
		return false;
	}

	val = f.category.value;
	if (!val) {
		f.category.focus();
		return false;
	}

	val = f.product.value.trim();
	if (!val) {
		f.product.focus();
		return false;
	}

	val = f.price.value.trim();
	if (!val) {
		f.price.focus();
		return false;
	}

	val = f.content.value.trim();
	if (!val) {
		f.content.focus();
		return false;
	}

	val = document.getElementById("fileInput").files.length;
	if (val == 0) {
		alert('제품을 확인할 수 있는 사진 파일을 반드시 첨부해주세요.');
		return false;
	}

	f.submit();
}
</script>
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
		<form action="${pageContext.request.contextPath}/usedBoard/write" name="usedBoardForm" method="post" enctype="multipart/form-data">
			<table class="table">
				<tbody>
					<tr>
						<td width="100">제목<span class="info">*</span></td>
						<td><input type="text" name="title"></td>
					</tr>
					<tr>
						<td>분류<span class="info">*</span></td>
						<td style="text-align: left; display: flex; gap: 10px;">
							<label>
								<input type="radio" name="category" value="0" required>판매
							</label>
							<label>
								<input type="radio" name="category" value="1">구매
							</label>
						</td>
					</tr>
					<tr>
						<td>제품명<span class="info">*</span></td>
						<td><input type="text" name="product"></td>
					</tr>
					<tr>
						<td>가격<span class="info">*</span></td>
						<td style="text-align: left;">
							<div class="price-container">
								<input type="text" name="price" class="input-price">&nbsp;원
							</div>
						</td>
					</tr>
					<tr>
						<td>내용<span class="info">*</span></td>
						<td><textarea class="form-control" name="content" style="font-size: 14px;"></textarea></td>
					</tr>
					<tr>
						<td>파일첨부<span class="info">*</span></td>
						<td><input type="file" name="selectFile" id="fileInput" multiple></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right; font-size: 12px;"><span class="info">*</span> 표시된 내용은 필수입니다.</td>
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