<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

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
				<div id="listReplyAnswer" class="answer-list"></div>
				<div style="border-bottom: 1px solid #DDECB8; display: flex; flex-direction: row;">
					<span style="margin: 2px;"><i class="bi bi-arrow-return-right"></i></span>
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