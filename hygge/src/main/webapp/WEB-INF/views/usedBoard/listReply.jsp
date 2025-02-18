<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="reply-info">
	<span class="reply-count">댓글 ${replyCount}개</span>
	<span>[목록, ${pageNo}/${total_page} 페이지]</span>
</div>

<table class="table table-borderless">
	<c:forEach var="dto" items="${listReply}">
		<tr class="table-light">
			<td width="50%" style="background-color: #ebf1db;">
				<div class="row reply-writer">
					<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
					<div class="col-auto align-self-center">
						<div class="name">${dto.nickName}</div>
					</div>
				</div>				
			</td>
			<td width="50%" align="right" class="align-middle" style="background-color: #ebf1db;">
				<div style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; width: 35%;">
					<div class="date">${dto.reg_date}</div>
					<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
					<div class="reply-menu">
						<c:choose>
							<c:when test="${dto.memberIdx == sessionScope.member.memberidx || sessionScope.member.authority == 'ADMIN'}">
								<div class="deleteReply reply-menu-item" data-replyNum="${dto.num}" data-pageNo="${pageNo}">삭제</div>
							</c:when>
							<c:when test="${!requested && sessionScope.member.memberidx == boardwriterIdx}">
								<div class="reportReply reply-menu-item" data-replyNum="${dto.num}" data-pageNo="${pageNo}" data-writer="${dto.memberIdx}">신고</div>
								<div class="requestReply reply-menu-item" data-replyNum="${dto.num}" data-pageNo="${pageNo}" data-writer="${dto.memberIdx}">거래신청</div>
							</c:when>
							<c:otherwise>
								<div class="reportReply reply-menu-item" data-replyNum="${dto.num}" data-pageNo="${pageNo}" data-writer="${dto.memberIdx}">신고</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top">${dto.content}</td>
		</tr>
	
		<tr>
			<td colspan="2">
				<button type="button" class="btn btnReplyAnswerLayout" data-replyNum="${dto.num}" style="background-color: #ebf1db;">답글 <span id="answerCount${dto.num}">${dto.replyCount}</span></button>
			</td>
		</tr>
		<tr class="reply-answer">
			<td colspan="2">
				<div style="border: 1px solid #DDECB8;">
					<div id="listReplyAnswer${dto.num}" class="answer-list"></div>
					<div style="border-bottom: 1px solid #DDECB8; display: flex; flex-direction: row;">
						<span style="margin: 2px;"><i class="bi bi-arrow-return-right"></i></span>
						<textarea class="form-control" style="resize: none; margin: 0px;"></textarea>
					</div>
					<div class="text-end">
						<button type="button" class="btn btnSendReplyAnswer" data-replyNum="${dto.num}">답글 등록</button>
					</div>
				</div>
			</td>
		</tr>
	</c:forEach>
</table>

<div class="page-navigation">
	${replyCount == 0 ? '' : paging}
</div>			