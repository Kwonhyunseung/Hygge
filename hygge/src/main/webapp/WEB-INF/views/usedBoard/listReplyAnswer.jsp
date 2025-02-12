<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:forEach var="dto" items="${listAnswer}">
	<div class="border-bottom m-1">
		<div class="row p-1">
			<div class="col-auto">
				<div class="row reply-writer">
					<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
					<div class="col ms-2 align-self-center">
						<div class="name">${dto.name}</div>
					</div>
				</div>
			</div>
			<div class="col align-self-center text-end" style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; width: 35%;">
				<div class="date">${dto.reg_date}</div>
				<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
				<div class="reply-menu">
					<c:choose>
						<c:when test="${dto.memberIdx == sessionScope.member.memberidx || sessionScope.member.authority == 'ADMIN'}">
							<div class="deleteReplyAnswer reply-menu-item" data-replyNum="${dto.num}" data-parentNum="${dto.parent_num}">삭제</div>
						</c:when>
						<c:otherwise>
							<div class="reportReplyAnswer reply-menu-item" data-replyNum="${dto.num}" data-parentNum="${dto.parent_num}" data-writer="${dto.memberIdx}">신고</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

		<div class="p-2">
			${dto.content}
		</div>
	</div>
</c:forEach>
