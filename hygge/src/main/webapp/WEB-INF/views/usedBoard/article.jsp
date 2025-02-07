<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/usedBoard/article.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
.article-dropdown { cursor: pointer; }
.article-dropdown:hover { color: #45A049; }
.article-menu { display: none; position: absolute; width: 60px; background:#fff; border: 1px solid #d5d5d5; z-index: 9999; }
.article-menu-item { text-align: center; cursor: pointer; padding: 2px; }
.article-menu-item:hover { color: #45A049; font-weight: 500; }

.reply { clear: both; padding: 20px 0 10px; }

.reply .form-header { padding-bottom: 7px; }
.reply-form { border: 1px solid #DDECB8 !important; }
.reply-form tr > td { padding: 2px 0 2px; }
.reply-form textarea { width: 100%; height: 75px; resize: none; border-style: none; border-radius: 0px; }
.reply-form textarea:focus { box-shadow: none; border-color: none; }
.reply-form button { padding: 5px 15px; margin: 5px; background-color: #ebf1db; border-style: none; }
.reply-form button:hover { background-color: #DDECB8; border-style: none; }

.reply .reply-info { padding-top: 25px; padding-bottom: 7px; }
.reply-info .reply-count { color: #3ea9cd; font-weight: 700; }

.profile-container { display: flex; flex-direction: row; align-items: center; }
.profile-img-container { width: 30px !important; height: 30px; margin: 0px 5px; overflow: hidden; border-radius: 15px; border: 1px solid #DDECB8; }

.reply-list tr > td { padding: 5px 10px 5px; }
.reply-list .list-header { box-shadow: 0 0 0 1px #d5d5d5; background:  #ebf1db; border-radius: 3px; border-style: hidden; }
.reply-list .list-header > td:first-child { border-radius: 3px 0 0 3px; }
.reply-list .list-header > td:last-child { border-radius: 0 3px 3px 0; }
.reply-list .list-header > td { padding-top: 7px; padding-bottom: 7px; }

.reply .reply-writer { display: flex; }
.reply .reply-writer-left { font-size: 15px; padding: 3px 3px 5px 7px;  border-radius: 30px; width: 30px; height: 30px; }
.reply .reply-writer-right { margin-left: 7px; }
.reply-writer .icon { color: #999; }
.reply-writer .name { font-weight: 600; font-size: 14px; }
.date { font-size: 12px; display: inline; }

.reply .deleteReply, .reply .deleteReplyAnswer { cursor: pointer; }
.reply .notifyReply, .reply .notifyReplyAnswer { cursor: pointer; }
.reply .hideReply, .reply .hideReplyAnswer { cursor: pointer; }
.reply .blockReply, .reply .blockReplyAnswer { cursor: pointer; }

.reply .reply-dropdown { cursor: pointer; }
.reply .reply-dropdown:hover { color: #45A049; }
.reply .reply-menu { display: none; position: absolute; width: 60px; background:#fff; border: 1px solid #d5d5d5; z-index: 9999; }
.reply .reply-menu-item { text-align: center; cursor: pointer; padding: 2px; }
.reply .reply-menu-item:hover { color: #0d6efd; font-weight: 500; }

.reply-answer { display: none; }
.reply-answer .answer-body { border: 1px solid #d5d5d5; padding-left: 7px; padding-right: 7px; }
.answer-body .answer-list { padding: 0 10px 7px; }
.answer-body .answer-form { padding: 3px 10px 5px; }
.reply-answer textarea { height: 75px; border-style: none; border-radius: 0px; }
.reply-answer textarea:focus { box-shadow: none; border-radius: 0px; }
.reply-answer button { padding: 5px 15px; margin: 5px; background-color: #ebf1db; border-style: none; }
.reply-answer button:hover { background-color: #DDECB8; border-style: none; }
.answer-body .answer-footer { padding: 0 13px 10px 10px; text-align: right; }

.answer-article .article-header { display: flex; padding-top: 10px; }
.answer-article .article-header-left { text-align: left; }
.answer-article .article-header-right { margin-left: auto; text-align: right; }
.answer-article .article-body { padding: 5px 5px; border-bottom: 1px solid #d5d5d5; }
</style>
<script type="text/javascript">
$(function() {
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
			// listReplyAnswer(replyNum); // 답글 리스트
			// countReplyAnswer(replyNum); // 답글 개수
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

</script>
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
					<span>두 번 쓴 물티슈</span>
					<span class="article-dropdown"><i class="bi bi-three-dots-vertical" title="메뉴"></i></span>
					<div class="article-menu" style="font-weight: 500;">
						<div class="deleteArticle article-menu-item" data-articleNum="${dto.replyNum}">삭제</div>
					</div>
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
								<span style="margin-left: 5px;">홍길동</span>
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
			
			<div id="listReply">
			<div class="reply-info">
	<span class="reply-count">댓글 1개</span>
	<span>[목록, 1/1 페이지]</span>
</div>

<table class="table table-borderless">
	<tr class="table-light">
		<td width="50%" style="background-color: #ebf1db;">
			<div class="row reply-writer">
				<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
				<div class="col-auto align-self-center">
					<div class="name">홍길동</div>
				</div>
			</div>				
		</td>
		<td width="50%" align="right" class="align-middle" style="background-color: #ebf1db;">
			<div style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; width: 35%;">
				<div class="date">2025-02-07 13:43:27</div>
				<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
				<div class="reply-menu">
					<div class="deleteReply reply-menu-item" data-replyNum="${dto.replyNum}" data-pageNo="">삭제</div>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="top">테스트</td>
	</tr>

	<tr>
		<td colspan="2">
			<button type="button" class="btn btnReplyAnswerLayout" data-replyNum="" style="background-color: #ebf1db;">답글 <span id="answerCount ">2</span></button>
		</td>
	</tr>

	<tr class="reply-answer">
		<td colspan="2">
			<div style="border: 1px solid #DDECB8;">
				<div id="listReplyAnswer" class="answer-list">
				
				
				
				
					<div class="border-bottom m-1">
		<div class="row p-1">
			<div class="col-auto">
				<div class="row reply-writer">
					<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
					<div class="col ms-2 align-self-center">
						<div class="name">홍길동</div>
					</div>
				</div>
			</div>
			<div class="col align-self-center text-end" style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; width: 35%;">
				<div class="date">2025-02-07-17:36:37</div>
				<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
				<div class="reply-menu">
					<div class="notifyReplyAnswer reply-menu-item">삭제</div>
				</div>
			</div>
		</div>

		<div class="p-2">
			테스트
		</div>
	</div>
	
	
	
	
	
	
				</div>
				<div style="border-bottom: 1px solid #DDECB8; display: flex; flex-direction: row;">
					<span style="margin: 6px;"><i class="bi bi-arrow-return-right"></i></span>
					<textarea class="form-control" style="resize: none; margin: 0px;"></textarea>
				</div>
				<div class="text-end">
					<button type="button" class="btn btnSendReplyAnswer" data-replyNum="">답글 등록</button>
				</div>
			</div>
		</td>
	</tr>
</table>

<div class="page-navigation">
	페이징처리
</div>			
			
			</div>
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