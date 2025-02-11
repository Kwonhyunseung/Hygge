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

$(function() {
	// 본문 삭제
	$('.deleteArticle').click(function() {
		let url = '${pageContext.request.contextPath}/usedBoard/delete?num=${dto.num}';
		if (confirm('게시글을 삭제하시겠습니까?')) {
			location.href = url;
		}
	});
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
						<c:if test="${sessionScope.member.memberidx == dto.memberIdx}">
						<div class="deleteArticle article-menu-item" data-articleNum="${dto.num}">삭제</div>
						</c:if>
						<c:if test="${sessionScope.member.memberidx != dto.memberIdx}">
						<div class="reportArticle article-menu-item" data-articleNum="${dto.num}">신고</div>
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
					<div class="deleteReply reply-menu-item" data-replyNum="" data-pageNo="">삭제</div>
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