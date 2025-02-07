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
</c:forEach>
