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
				<div id="carouselExampleIndicators" class="carousel slide">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>
					<div class="carousel-inner">
						<c:forEach var="dto" items="${dto.s_Filename}">
							<div class="carousel-item active">
								<img src="${pageContext.request.contextPath}/uploads/usedBoard/${dto}" class="d-block w-100">
							</div>
						</c:forEach>
					</div>
					<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			<div class="content-container">
				<div class="article-title">
					<span>${dto.title}</span>
					<span class="article-dropdown"><i class="bi bi-three-dots-vertical" title="메뉴"></i></span>
					<div class="article-menu" style="font-weight: 500;">
						<c:choose>
							<c:when test="${dto.memberIdx == sessionScope.member.memberidx || sessionScope.member.authority == 'ADMIN'}">
								<div class="deleteArticle article-menu-item" data-articleNum="${dto.num}">삭제</div>
							</c:when>
							<c:otherwise>
								<div class="reportArticle article-menu-item" data-articleNum="${dto.num}" data-writer="${dto.memberIdx}">신고</div>
							</c:otherwise>
						</c:choose>
						<c:if test="${sessionScope.member.memberidx == dto.memberIdx}">
						</c:if>
						<c:if test="${sessionScope.member.memberidx != dto.memberIdx}">
						</c:if>
					</div>
				</div>
				<div class="product">제품명&nbsp; ${dto.product}</div>
				<div class="price">가격&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #E95151; font-style: italic;">${dto.priceFormat}</span> 원</div>
				<div class="article-content">${dto.content}</div>
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
		<div class="reply" style="width: 100%; margin-top: 20px;">
			<form name="replyForm" method="post">
				<div class="form-header">
					<span class="bold">댓글</span><span style="font-size: 12px;"> 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
				</div>
				<table class="table reply-form">
					<tr>
						<td>
							<div class="profile-container">
								<div class="profile-img-container">
									<img src="${pageContext.request.contextPath}/dist/images/person.png" style="height: 100%">
								</div>
								<span style="margin-left: 5px;">${sessionScope.member.name}</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<textarea class="form-control" name="content"></textarea>
						</td>
					</tr>
					<tr>
					   <td align="right">
							<button type="button" class="btn btn-light btnSendReply">등록</button>
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
<script type="text/javascript">
$(function() {
	listPage(1);

	// 본문 삭제/신고 메뉴
	$('.article-menu').hide();
	$('.article-dropdown').click(function() {
		const $menu = $(this).next('.article-menu');
		if ($menu.is(':visible')) {
			$menu.fadeOut(100);
		} else {
			$('article-menu').hide();
			$menu.fadeIn(100);

			let pos = $(this).offset();
			$menu.offset({left: pos.left, top: pos.top+25});
		}
	});

	// 댓글 삭제/신고 메뉴
	$('.reply').on('click', '.reply-dropdown', function() {
		const $menu = $(this).next('.reply-menu');
		if ($menu.is(':visible')) {
			$menu.fadeOut(100);
		} else {
			$('.reply-menu').hide();
			$menu.fadeIn(100);

			let pos = $(this).offset();
			$menu.offset({left: pos.left, top: pos.top+25});
		}
	});

	$('.reply').on('click', '.btnReplyAnswerLayout', function() {
		const $trAnswer = $(this).closest('tr').next();
		let isVisible = $trAnswer.is(':visible');
		let replyNum = $(this).attr('data-replyNum');

		if (isVisible) {
			$trAnswer.hide();
		} else {
			$trAnswer.show();
			listReplyAnswer(replyNum); // 답글 리스트
			countReplyAnswer(replyNum); // 답글 개수
		}
	});
});

// 본문 삭제/신고 메뉴 창 닫기
window.addEventListener('click', function(evt) {
	if ($(evt.target.parentNode).hasClass('article-dropdown')) {
		return false;
	}
	$('.article-menu').hide();

	if ($(evt.target.parentNode).hasClass('reply-dropdown')) {
		return false;
	}
	$('.reply-menu').hide();
});

// 본문
$(function() {
	// 본문 삭제
	$('.deleteArticle').click(function() {
		let url = '${pageContext.request.contextPath}/usedBoard/delete?num=${dto.num}';
		if (confirm('게시글을 삭제하시겠습니까?')) {
			location.href = url;
		}
	});

	// 본문 신고
	$('.reportArticle').click(function() {
		if (!confirm('게시글을 신고하시겠습니까?')) {
			return false;
		}
		let reported = $(this).attr('data-writer');
		let url = '${pageContext.request.contextPath}/usedBoard/report?num=${dto.num}&query=${query}&reported=' + reported;
		location.href = url;
	});
});

// 댓글
$(function() {
	// 댓글 등록
	$('.btnSendReply').click(function() {
		let num = '${dto.num}'; // 게시글 번호
		let memberIdx = '${sessionScope.member.memberidx}';
		if (!memberIdx || !memberIdx.trim()) {
			location.href = '${pageContext.request.contextPath}/member/login';
			return false;
		}
		let f = document.replyForm;
		let content = f.content.value.trim();
		if (!content) {
			f.content.focus();
			return false;
		}
		let url = '${pageContext.request.contextPath}/usedBoard/insertReply';
		let params = {board_num: num, content: content, parent_num: 0};

		const fn = function(data) {
			f.content.value = '';
			if (data.state == 'true') {
				listPage(1);
			} else {
				alert('댓글 등록에 실패했습니다. 다시 시도해주세요.');
			}
		}

		ajaxRequest(url, 'post', params, 'json', fn);
	});

	// 댓글 삭제
	$('.reply').on('click', '.deleteReply', function() {
		if (!confirm('댓글을 삭제하시겠습니까?')) {
			return false;
		}
		let replyNum = $(this).attr('data-replyNum');
		let page = $(this).attr('data-pageNo');

		let url = '${pageContext.request.contextPath}/usedBoard/deleteReply';
		let params = {num: replyNum, mode: 'reply'};

		const fn = function(data) {
			listPage(page);
		};

		ajaxRequest(url, 'post', params, 'json', fn);
	});

	// 댓글 신고
	$('.reply').on('click', '.reportReply', function() {
		if (!confirm('댓글을 신고하시겠습니까?')) {
			return false;
		}
		let page = $(this).attr('data-pageNo');
		let num = $(this).attr('data-replyNum');
		let reported = $(this).attr('data-writer');
		let params = {tablename: 'usedBoardReply', reportedNumber: num, memberIdx2: reported};
		let url = '${pageContext.request.contextPath}/usedBoard/reportReply';
		const fn = function(data) {
			console.log(data);
			listPage(page);
		};

		ajaxRequest(url, 'post', params, 'json', fn);
	});

	// 답글 등록
	$('.reply').on('click', '.btnSendReplyAnswer', function() {
		let board_num = '${dto.num}'; // 글 번호
		let num = $(this).attr('data-replyNum'); // 댓글 번호
		let memberIdx = '${sessionScope.member.memberidx}';
		if (!memberIdx || !memberIdx.trim()) {
			location.href = '${pageContext.request.contextPath}/member/login';
			return false;
		}
		let $content = $(this).closest('div').prev().find('textarea');
		let content = $(this).closest('div').prev().find('textarea').val().trim();
		if (!content) {
			$(this).closest('div').prev().find('textarea').focus();
			return false;
		}

		let url = '${pageContext.request.contextPath}/usedBoard/insertReply';
		let params = {board_num: board_num, content: content, parent_num: num};

		const fn = function(data) {
			$content.val('');
			let state = data.state;
			if (state === 'true') {
				listReplyAnswer(num);
				countReplyAnswer(num);
			}
		};

		ajaxRequest(url, 'post', params, 'json', fn);
	});

	// 답글 삭제
	$('.reply').on('click', '.deleteReplyAnswer', function() {
		if (!confirm('답글을 삭제하시겠습니까?')) {
			return false;
		}
		let num = $(this).attr('data-replyNum');
		let parent_Num = $(this).attr('data-parentNum');

		let url = '${pageContext.request.contextPath}/usedBoard/deleteReply';
		let params = {num: num, mode: 'answer'};

		const fn = function(data) {
			listReplyAnswer(parent_Num);
			countReplyAnswer(parent_Num);
		}

		ajaxRequest(url, 'post', params, 'json', fn);
	});

	// 답글 신고
	$('.reply').on('click', '.reportReplyAnswer', function() {
		if (!confirm('답글을 신고하시겠습니까?')) {
			return false;
		}
		let num = $(this).attr('data-replyNum');
		let parentNum = $(this).attr('data-parentNum');
		let reported = $(this).attr('data-writer');
		let params = {tablename: 'usedBoardReply', reportedNumber: num, memberIdx2: reported};
		let url = '${pageContext.request.contextPath}/usedBoard/reportReply';
		const fn = function(data) {
			listReplyAnswer(parentNum);
			countReplyAnswer(parentNum);
		};

		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

function listPage(page) {
	let url = '${pageContext.request.contextPath}/usedBoard/listReply';
	let num = '${dto.num}';
	let params = {num: num, pageNo: page};

	const fn = function(data) {
		$('#listReply').html(data);
	};

	ajaxRequest(url, 'get', params, 'text', fn);
}

function listReplyAnswer(parentNum) {
	let url = '${pageContext.request.contextPath}/usedBoard/listReplyAnswer';

	const fn = function(data) {
		$('#listReplyAnswer' + parentNum).html(data);
	};

	ajaxRequest(url, 'get', {num: parentNum}, 'text', fn);
}

function countReplyAnswer(parentNum) {
	let url = '${pageContext.request.contextPath}/usedBoard/countReplyAnswer';

	const fn = function(data) {
		let count = data.count;
		$('#answerCount' + parentNum).html(count);
	};
	ajaxRequest(url, 'post', {num: parentNum}, 'json', fn);
}
</script>
</html>