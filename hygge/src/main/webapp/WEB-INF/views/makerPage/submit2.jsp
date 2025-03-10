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


.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 16px;
    border-bottom: 1px solid #e5e7eb;
    background-color: #ffffff;
}

.nav {
    display: flex;
    border-bottom: 1px solid #FF5733;
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
}

.nav-item {
    padding: 15px 25px;
    cursor: pointer;
    color: #666;
    font-size: 14px;
    position: relative;
    text-decoration: none;
}

.form-container {
    max-width: 1000px;
    margin: 40px auto;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.form-section {
    margin-bottom: 30px;
}

.form-section h2 {
    font-size: 16px;
    margin-bottom: 10px;
    color: #333;
}

.form-section p {
    color: #666;
    font-size: 14px;
    margin-bottom: 15px;
}

.form-input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-top: 5px;
}

.radio-container {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-top: 10px;
}

.radio-container input[type="radio"] {
    margin-right: 5px;
}

.active {
    color: #FF5733;
    font-weight: bold;
}

.nav-item:hover {
    color: #FF5733;
}

        /* 새로운 스타일 추가 */
.form-section select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-top: 5px;
    margin-bottom: 15px;
    font-size: 14px;
    color: #333;
    background-color: white;
}

.form-section .sub-category {
    font-size: 14px;
    color: #333;
    margin: 15px 0 5px 0;
}

.form-input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-top: 5px;
    font-size: 14px;
}

textarea.form-input {
    min-height: 120px;
    resize: vertical;
    line-height: 1.5;
    font-family: inherit;
}

.radio-container {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-top: 10px;
}

.radio-container input[type="radio"] {
    margin-right: 5px;
}

.active {
    color: #FF5733;
    font-weight: bold;
}

.nav-item:hover {
    color: #FF5733;
}

.form-section select {
   width: 100%;
   padding: 10px;
   border: 1px solid #ddd;
   border-radius: 4px;
   margin-top: 5px;
   margin-bottom: 15px;
   font-size: 14px;
   color: #333;
   background-color: white;
}

.form-section .sub-category {
   font-size: 14px;
   color: #333;
   margin: 15px 0 5px 0;
}

textarea.form-input {
   min-height: 120px;
   resize: vertical;
   line-height: 1.5;
   font-family: inherit;
}

.tip-section {
    background-color: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
}

.tip-section h3 {
    font-size: 16px;
    color: #333;
    margin-bottom: 15px;
}

.tip-list {
    list-style: none;
}

.tip-list li {
    margin-bottom: 10px;
    font-size: 14px;
    color: #666;
    line-height: 1.5;
}

.save-button {
    width: 100px;
    padding: 12px 20px;
    background-color: #FF5733;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    float: right;
    margin-top: 20px;
}

.save-button:hover {
    background-color: #ff4518;
}

.button-container {
    width: 100%;
    overflow: hidden;
    padding: 20px 0;
}
		
</style>
</head>
<body>
<header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/header.jsp"/>
</header>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/project/layout/nav-item.jsp"/>


<form name="submit2" method="post" enctype="multipart/form-data">
<div class="form-container">
	<div class="form-section">
		<h2>프로젝트 카테고리</h2>
		<p>프로젝트의 성격과 가장 일치하는 카테고리를 선택해주세요.</p>
		<select class="parent_num" name="parent_num">
			<option value="1" ${funding.parent_num == 1 ? 'selected' : ''}>가전</option>
			<option value="2" ${funding.parent_num == 2 ? 'selected' : ''}>패션</option>
			<option value="3" ${funding.parent_num == 3 ? 'selected' : ''}>뷰티</option>
			<option value="4" ${funding.parent_num == 4 ? 'selected' : ''}>홈*리빙</option>
			<option value="5" ${funding.parent_num == 5 ? 'selected' : ''}>푸드</option>
			<option value="6" ${funding.parent_num == 6 ? 'selected' : ''}>도서</option>
			<option value="7" ${funding.parent_num == 7 ? 'selected' : ''}>캐릭터*굿즈</option>
			<option value="8" ${funding.parent_num == 8 ? 'selected' : ''}>문화</option>
			<option value="9" ${funding.parent_num == 9 ? 'selected' : ''}>반려동물</option>
		</select>
		<div>세부 카테고리</div>
		<select class="category_num" name="category_num">
			<option>대분류를 선택해주세요.</option>
		</select>
	</div>
	
	<div class="form-section">
		<h2>프로젝트 제목</h2>
		<p>프로젝트의 주요 내용을 담을 수 있고, 서포터들이 쉽게 이해할 수 있는 제목을 작성해주세요.</p>
		<input type="text" class="form-input" placeholder="제목을 입력해주세요" name="title">
	</div>
	
	<div class="form-section">
		<h2>프로젝트 요약 이미지</h2>
		<p>서포터들이 프로젝트의 내용을 쉽게 이해할 수 있도록 프로젝트 요약 이미지들을 등록해주세요.</p>
		<div class="radio-container">
			<input type="file" name="photoFiles" class="form-input" multiple>
		</div>
	</div>
	
	<div class="form-section">
		<h2>프로젝트 요약</h2>
		<p>소개 영상이나 사진과 함께 보이는 글이에요. 프로젝트를 쉽고 간결하게 소개해 주세요.</p>
		<textarea class="form-input" placeholder="내용을 입력해주세요." style="resize: none;" name="project_info"></textarea>
	</div>
	
	<div class="form-section">
		<h2>배송 일정</h2>
		<p>프로젝트가 성공적으로 완료된 후, 진행될 배송일정에 대해 간단히 적어주세요.</p>
		<input type="checkbox" name="isDelivery" id="checkbox1"><label style="margin-left: 5px;" for="checkbox1">배송이 필요한 상품입니다.</label>
		<div class="delivery-container" style="display: none;">
			<input type="text" class="form-input" placeholder="배송일정을 적어주세요" name="delivery_info">
			<input type="text" class="form-input" placeholder="배송비를 적어주세요 배송이 필요하지 않다면 0을 입력해주세요" name="delivery_fee">
		</div>
	</div>
	
	<div class="tip-section">
		<h3>프로젝트 스토리⁕TIP</h3>
		<div class="tip-list">
			<h4>TIP 1 스토리는 이렇게 작성해 보세요</h4>
			<ul>
				<li>이미지는 너비 740px 이상으로 등록해야 상세 페이지의 스토리에 여백이 생기지 않아요.</li>
				<li>이미지와 설명글 구성으로 스토리를 작성하면 내외부 포털 검색 결과에 상위 노출될 확률이 높아져요.</li>
				<li>이미지로만 구성된 스토리는 이미지 로딩 속도가 느려 서포터가 상세페이지를 벗어날 확률이 높아져요.</li>
				<li>스토리 작성이 어렵다면 스토리 제작 서비스로 전문가와 맞춤형 스토리를 만들어 보세요.</li>
			</ul>
			
			<h4 style="margin-top: 15px;">TIP 2 서포터에게 꼭 알려 주세요</h4>
			<ul>
				<li>도서산간 배송비가 있다면 정확한 추가 금액과 지불 방법을 스토리에 작성해 주세요.</li>
			</ul>
		</div>
	</div>
	<div class="form-section">
		<textarea name="content" id="ir1" class="form-control" style="max-width: 98%; height: 290px;">${funding.content}</textarea>
	</div>
	<div class="button-container" style="padding-bottom: 10px;">
		<button type="button" class="prev-button" onclick="location.href='${pageContext.request.contextPath}/makerPage/projectSubmit1'">이전</button>
		<button type="button" class="next-button" onclick="submitContents(this.form);">다음</button>
	</div>
	<div class="alert-container" style="display: none; justify-content: flex-end;">
		<span style="font-size: 13px; color: #ff4019;" class="alert-msg"></span>
	</div>
</div>
</form>

<script type="text/javascript">
$(function() {
	let value = $('.parent_num option:selected').val();
	loadCategory(value);
	$('.parent_num').change(function() {
		let value = $('.parent_num option:selected').val();
		let url = '${pageContext.request.contextPath}/makerPage/categories';
		let childcategory = $('.category_num');
		const fn = function(data) {
			let list = data.categories;
			let out = '';
			for (let category of list) {
				let category_num = category.category_num;
				let name = category.name;
				out += '<option value="' + category_num + '">' + name + '</option>';
			}
			childcategory.html(out);
		};
		ajaxRequest(url, 'get', {num: value}, 'json', fn);
	});
	// 배송일정 작성
	$('input[name="isDelivery"]').change(function() {
		if ($(this).is(':checked')) {
			$('.delivery-container').slideDown(200);
		} else {
			$('.delivery-container').slideUp(200);
		}
	});
});

function addCategory(data) {
	let categoryNum = '${funding.category_num}';
	let categories = data.categories;
	let childcategory = $('.category_num');
	let out = '';
	for (let category of categories) {
		let category_num = category.category_num;
		let name = category.name;
		if (category_num = categoryNum) {
			out += '<option value="' + category_num + '" selected>' + name + '</option>';
		} else {
			out += '<option value="' + category_num + '">' + name + '</option>';
		}
	}
	childcategory.html(out);
}

function loadCategory(num) {
	let url = '${pageContext.request.contextPath}/makerPage/categories';
	const fn = function(data) {
		addCategory(data);
	};
	ajaxRequest(url, 'get', {num: num}, 'json', fn);
}
/*
// 제출 버튼(다음 단계)
function sendNext() {
	const f = document.submit2;
	// f.action = '${pageContext.request.contextPath}/makerPage/projectSubmit2';
	// f.submit();
}
 */
</script>

<!-- 스마트 에디터 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: 'ir1',
	sSkinURI: '${pageContext.request.contextPath}/dist/vendor/se2/SmartEditor2Skin.html',
	fCreator: 'createSEditor2',
	fOnAppLoad: function(){
		// 로딩 완료 후
		oEditors.getById['ir1'].setDefaultFont('돋움', 12);
	},
});

function check() {
	const f = document.submit2;
	let str;
	// 1단계 기입 내용 확인(target, term, thumbnail, business)
	let value = '${funding.target}';
	let alertmsg = '이전 단계의 내용 입력을 완료해야 넘어갈 수 있습니다.';
	if (!value || value == 0) {
		$('.alert-msg').html(alertmsg);
		$('.alert-container').css('display', 'flex');
		console.log('목표금액');
		return false;
	}
	value = '${funding.term}';
	if (!value || value == 0) {
		$('.alert-msg').html(alertmsg);
		$('.alert-container').css('display', 'flex');
		console.log('목표기간');
		return false;
	}
	value = '${funding.thumbnail}';
	if (!value || value == '') {
		$('.alert-msg').html(alertmsg);
		$('.alert-container').css('display', 'flex');
		console.log('목표썸네일');
		return false;
	}
	value = '${funding.business}';
	if (!value) {
		$('.alert-msg').html(alertmsg);
		$('.alert-container').css('display', 'flex');
		console.log('목표비지니스');
		return false;
	}
	// 제목 확인
	str = f.title.value.trim();
	if (!str) {
		f.title.focus();
		return false;
	}
	// 프로젝트 요약 확인
	str = f.project_info.value.trim();
	if (!str) {
		f.project_info.focus();
		return false;
	}
	// 내용 확인
	str = f.content.value.trim();
	if (!str) {
		f.content.focus();
		return false;
	}
	// 배송 메세지 확인
	if ($('input[name="isDeliver"]').is(':checked')) {
		str = f.delivery_info.value.trim();
		if (!str) {
			f.delivery_info.focus();
		}
		str = f.delivery_fee.value.trim();
		if (!str) {
			f.delivery_fee.focus();
		}
	} else {
		f.delivery_info.value = '배송이 불필요한 상품입니다.';
		f.delivery_fee.value = 0;
	}
	// 요약 이미지들 확인
	let files = f.photoFiles.value;
	if (!files || files == null || files == '') {
		$('.alert-msg').html('프로젝트 요약 이미지들이 업로드되지 않았습니다.');
		$('.alert-container').css('display', 'flex');
		return false;
	}
	f.action = '${pageContext.request.contextPath}/makerPage/projectSubmit2';
	return true;
}

function submitContents(elClickedObj) {
	 oEditors.getById['ir1'].exec('UPDATE_CONTENTS_FIELD', []);
	 try {
		if(! check()) {
			return;
		}
		
		elClickedObj.submit();
		
	} catch(e) {
	}
}
</script>
</body>
</html>