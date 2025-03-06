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
<link rel="stylesheet" href="/dist/css/project/submit3.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<style type="text/css">
.btn-add {
    border-color: #FF5733;
    color: #FF5733;
}

.btn-add:hover {
    background-color: #FF5733;
    color: white;
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
		<form name="submit3" style="display: flex; width: 48%; flex-direction: column;" method="post">
			<div class="gift-list">
				<div style="font-style: italic; color: gray; padding: 20px;">
					<p>제출하신 순서대로 프로젝트 화면에 노출됩니다</p>
					<p>상품을 추가해주세요</p>
				</div>
			</div>
		</form>
		
		<div class="gift-form">
			<h2 class="form-title">선물 만들기+</h2>
			<p class="form-description">선물은 프로젝트에서 서포터에게 가치를 전달하는 수단입니다.<br>
				이 점을 고려해서 혜택 개별 선물을 만들어주세요.<br>선물 설정을 완료하면 본격적으로 펀딩을 시작할 수 있습니다.</p>
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
				<label class="form-label">상품 재고 수량<span class="origin-info">최대 5자리</span></label>
				<input type="text" class="form-input" name="stock">
			</div>
			
			<div class="form-group">
				<label class="form-label">원산지<span class="origin-info">원산지 기재 필수 품목: 수입물품</span></label>
				<input type="text" class="form-input" name="origin">
			</div>
			
			<div class="button-group">
				<button type="button" class="btn btn-add">추가</button>
			</div>
		</div>
	</div>
	<div class="button-container">
		<button type="button" class="prev-button" onclick="location.href='${pageContext.request.contextPath}/makerPage/projectSubmit2'">이전</button>
		<button type="button" class="next-button" onclick="sendNext();">다음</button>
	</div>
 </main>

<script type="text/javascript">
$(function() {
	$('.btn-add').click(function() {
		let url = '${pageContext.request.contextPath}/makerPage/addProduct';
		let title = $('.gift-form input[name="title"]').val();
		if (!title) {
			$('.gift-form input[name="title"]').focus();
			return false;
		}
		let detail = $('.gift-form input[name="detail"]').val();
		if (!detail) {
			$('.gift-form input[name="detail"]').focus();
			return false;
		}
		let price = $('.gift-form input[name="price"]').val();
		if (!price) {
			$('.gift-form input[name="price"]').focus();
			return false;
		}
		let stock = $('.gift-form input[name="stock"]').val();
		if (!stock) {
			$('.gift-form input[name="stock"]').focus();
			return false;
		}
		let origin = $('.gift-form input[name="origin"]').val();
		if (!origin) {
			$('.gift-form input[name="origin"]').focus();
			return false;
		}
		let projectNum = '${projectNum}';
		let out = '';
		out += '<div class="gift-item">';
		out += '	<div>';
		out += '		<div class="gift-price">' + price + ' 원</div>';
		out += '		<div class="gift-title">' + title + '</div>';
		out += '	</div>';
		out += '	<div class="gift-actions">';
		out += '		<button type="button" class="action-btn update-btn">수정</button>';
		out += '		<button type="button" class="action-btn delete-btn">삭제</button>';
		out += '	</div>';
		out += '	<input type="hidden" name="titleList" id="titleList" value="' + title + '">';
		out += '	<input type="hidden" name="priceList" value="' + price + '">';
		out += '	<input type="hidden" name="stockList" value="' + stock + '">';
		out += '	<input type="hidden" name="originList" value="' + origin + '">';
		out += '	<input type="hidden" name="detailList" value="' + detail + '">';
		out += '	<input type="hidden" name="num" value="' + projectNum + '">';
		out += '</div>';

		if ($('.gift-item').length > 0) {
			$('.gift-list').append(out);
		} else {
			$('.gift-list').html(out);
		}
		$('.gift-form input[name="title"]').val('');
		$('.gift-form input[name="detail"]').val('');
		$('.gift-form input[name="price"]').val('');
		$('.gift-form input[name="stock"]').val('');
		$('.gift-form input[name="origin"]').val('');
	});

	// 상품 수정
	$('.gift-list').on('click', '.update-btn', function() {
		let $item = $(this).closest('.gift-item');
		let price = $item.find('input[name="priceList"]').val();
		let title = $item.find('input[name="titleList"]').val();
		let detail = $item.find('input[name="detailList"]').val();
		let stock = $item.find('input[name="stockList"]').val();
		let origin = $item.find('input[name="originList"]').val();

		$('.gift-form input[name="title"]').val(title);
		$('.gift-form input[name="detail"]').val(detail);
		$('.gift-form input[name="price"]').val(price);
		$('.gift-form input[name="stock"]').val(stock);
		$('.gift-form input[name="origin"]').val(origin);
		$item.remove();
		if ($('.gift-item').length < 1) {
			$('.gift-list').html('<div style="font-style: italic; color: gray; padding: 20px;">'
				+ '<p>제출하신 순서대로 프로젝트 화면에 노출됩니다</p>'
				+ '<p>상품을 추가해주세요</p></div>');
		}
	});

	// 상품 삭제
	$('.gift-list').on('click', '.delete-btn', function() {
		$(this).closest('.gift-item').remove();
		if ($('.gift-item').length < 1) {
			$('.gift-list').html('<div style="font-style: italic; color: gray; padding: 20px;">'
				+ '<p>제출하신 순서대로 프로젝트 화면에 노출됩니다</p>'
				+ '<p>상품을 추가해주세요</p></div>');
		}
	});
});

function sendNext() {
	const f = document.submit3;
	let url = '${pageContext.request.contextPath}/makerPage/projectSubmit3';
	f.action = url;
	if ($('.gift-item').length < 1) {
		alert('상품은 한 개 이상 등록해야 합니다.');
		return false;
	}
	if (confirm('프로젝트를 등록하시겠습니까? 다음 단계로 넘어가면 수정하기 위해 돌아올 수 없습니다.')) {
		f.submit();
	}
}
</script>

</body>
</html>