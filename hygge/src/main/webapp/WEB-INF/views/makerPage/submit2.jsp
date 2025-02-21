<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="/dist/css/project/layout/header.css">
<link rel="stylesheet" href="/dist/css/project/layout/nav-item.css">
<link rel="stylesheet" href="/dist/css/project/button.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    line-height: 1.5;
    color: #333;
}

.main-content {
    max-width: 1000px;
    margin: 0 auto;
    padding: 40px 20px;
}

/* Project Header */
.project-header {
    display: flex;
    align-items: flex-start;
    margin-bottom: 30px;
    gap: 20px;
}

.project-title-container {
    flex-grow: 1;
}

.badge {
    display: inline-block;
    padding: 2px 8px;
    border: 1px solid #FF5733;
    color: #FF5733;
    border-radius: 4px;
    font-size: 12px;
    margin-bottom: 8px;
}

.project-title {
    font-size: 18px;
    font-weight: 500;
}

.project-image {
    width: 100px;
    height: 100px;
    background-color: #f5f5f5;
}

/* Content Wrapper */
.content-wrapper {
    display: flex;
    gap: 40px;
    margin-top: 40px;
}

.gift-form {
    flex: 1;
}

/* Form Styles */
.form-title {
    font-size: 18px;
    font-weight: 500;
    margin-bottom: 8px;
    color: #333;
}

.form-description {
    color: #666;
    font-size: 14px;
    margin-bottom: 30px;
    line-height: 1.6;
}

.form-group {
    margin-bottom: 24px;
}

.form-label {
    display: block;
    font-size: 14px;
    margin-bottom: 8px;
    color: #333;
}

.form-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.form-input::placeholder {
    color: #999;
}

/* Radio and Checkbox Styles */
.radio-group {
    margin-top: 10px;
}

.radio-label {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    font-size: 14px;
    color: #666;
}

.radio-input {
    margin-right: 8px;
}

/* Button Styles */
.button-group {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #eee;
}

.btn {
    padding: 10px 30px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    background: white;
}

.btn-cancel {
    color: #666;
}

.btn-add {
    border-color: #FF5733;
    color: #FF5733;
}

.btn-add:hover {
    background-color: #FF5733;
    color: white;
}

/* Gift List Styles */
.gift-list {
    flex: 1;
    border: 1px solid #eee;
    border-radius: 4px;
    margin-bottom: 20px;
}

.gift-item {
    padding: 20px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.gift-item:last-child {
    border-bottom: none;
}

.gift-price {
    font-size: 16px;
    font-weight: 500;
    color: #333;
}

.gift-details {
    margin-top: 8px;
    color: #666;
    font-size: 14px;
}

.gift-actions {
    display: flex;
    gap: 8px;
}

.action-btn {
    padding: 6px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: none;
    cursor: pointer;
    font-size: 12px;
    color: #666;
}

.action-btn:hover {
    background-color: #f5f5f5;
}

.origin-info {
	font-size: 0.7rem;
	color: gray;
	margin-left: 10px;
}
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/project/layout/header.jsp"/>
    </header>
    
    <jsp:include page="/WEB-INF/views/project/layout/nav-item.jsp"/>
    
<main class="main-content">
	<div class="content-wrapper">
		<div class="gift-list">
			<c:forEach var="dto" items="${funding.product}">
				<div class="gift-item">
					<div>
						<div class="gift-price">${dto.price} 원</div>
						<div class="gift-details">${dto.title}</div>
					</div>
					<div class="gift-actions">
						<button class="action-btn update-btn">수정</button>
						<button class="action-btn delete-btn">삭제</button>
					</div>
				</div>
			</c:forEach>
			<c:if test="${empty funding.product}">
				<div style="font-style: italic; color: gray; padding: 20px;">상품을 추가해주세요</div>
			</c:if>
		</div>
		
		<div class="gift-form">
			<form name="submit2">
				<h2 class="form-title">선물 만들기+</h2>
				<p class="form-description">선물은 프로젝트에서 서포터에게 가치를 전달하는 수단입니다.<br>
					이 점을 고려해서 혜택 개별 선물을 만들어주세요. 선물 설정을 완료하면 본격적으로 펀딩을 시작할 수 있습니다.</p>
				<div class="form-group">
					<label class="form-label">상품 제목</label>
					<input type="text" class="form-input" name="title">
				</div>
				
				<div class="form-group">
					<label class="form-label">선물 구성 및 세부 설명<i class="bi bi-info-circle" style="margin-left: 5px;"></i></label>
					<input type="text" class="form-input" placeholder="선물 구성을 자세하게 작성해주세요." name="detail">
				</div>
				
				<div class="form-group">
					<label class="form-label">금액</label>
					<input type="text" class="form-input" placeholder="원" name="price">
				</div>
				
				<div class="form-group">
					<label class="form-label">상품 재고 수량</label>
					<input type="text" class="form-input" name="stock">
				</div>
				
				<div class="form-group">
					<label class="form-label">원산지<span class="origin-info">원산지 기재 필수 품목: 수입물품</span></label>
					<input type="text" class="form-input" name="origin">
				</div>
				
				<div class="button-group">
					<button type="reset" class="btn btn-cancel">지우기</button>
					<button type="submit" class="btn btn-add">추가</button>
				</div>
			</form>
		</div>
	</div>
	<div class="button-container">
		<button type="button" class="prev-button" onclick="location.href='${pageContext.request.contextPath}/makerPage/projectSubmit1'">이전</button>
		<button type="button" class="next-button" onclick="location.href='${pageContext.request.contextPath}/makerPage/projectSubmit3'">다음</button>
	</div>
 </main>

<script type="text/javascript">
$(function() {
	$('.btn-add').click(function() {
		let url = '${pageContext.request.contextPath}/makerPage/addProduct';
		let title = $('input[name="title"]').val();
		if (!title) {
			$('input[name="title"]').focus();
			return false;
		}
		let detail = $('input[name="detail"]').val();
		if (!detail) {
			$('input[name="detail"]').focus();
			return false;
		}
		let price = $('input[name="price"]').val();
		if (!price) {
			$('input[name="price"]').focus();
			return false;
		}
		let stock = $('input[name="stock"]').val();
		if (!stock) {
			$('input[name="stock"]').focus();
			return false;
		}
		let origin = $('input[name="origin"]').val();
		if (!origin) {
			$('input[name="origin"]').focus();
			return false;
		}
		let params = {title: title, detail: detail, price: price, stock: stock, origin: origin};

		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

function sendNext() {
	const f = document.submit2;

	f.action = '${pageContext.request.contextPath}/makerPage/addProduct';
	f.submit();
}
</script>

</body>
</html>