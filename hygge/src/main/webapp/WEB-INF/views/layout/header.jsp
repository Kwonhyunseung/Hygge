<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<head>

<title>hygge</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/dist/images/hygge_logo.ico"
	type="image/x-icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/layout/header.css"
	type="text/css">
</head>

<header>
	<nav class="navbar navbar-expand-lg">

		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">
				<img
				src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
				style="width: 100px;">
			</a>

			<div class="navbar-collapse d-flex" id="navbarNav">
				<ul class="nav nav-underline">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath}/funding/hotContent">인기</a>
					</li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath}/funding/new">신규</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath}/funding/comingsoon">공개예정</a>
					</li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath}/funding/deadline">마감임박</a>
					</li>
					<li class="nav-item"><a class="nav-link" id="moreMenuBtn"
						href="#">더보기</a>
						<div class="hygge-overlay"></div>
						<div class="hygge-more-menu">
							<div class="hygge-menu-items">
								<a href="${pageContext.request.contextPath}/vote/list"
									class="hygge-menu-item">
									<div class="hygge-circle-menu">
										<span>이달의 투표</span>
									</div>
								</a> <a href="${pageContext.request.contextPath}/event/list"
									class="hygge-menu-item">
									<div class="hygge-circle-menu">
										<span>이벤트</span>
									</div>
								</a> <a href="${pageContext.request.contextPath}/notice/list"
									class="hygge-menu-item">
									<div class="hygge-circle-menu">
										<span>공지사항</span>
									</div>
								</a> <a href="${pageContext.request.contextPath}/tester/list"
									class="hygge-menu-item">
									<div class="hygge-circle-menu">
										<span>체험단</span>
									</div>
								</a> <a href="${pageContext.request.contextPath}/usedBoard/list"
									class="hygge-menu-item">
									<div class="hygge-circle-menu">
										<span>중고게시판</span>
									</div>

								</a>
							</div>
						</div></li>
				</ul>
			</div>
			<div class="header-right d-flex align-items-center">
				<div class="nav-item">
					<a class="nav-link"
						href="${pageContext.request.contextPath}/following"><i
						class="bi bi-stars"></i></a>
				</div>
				<div class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/alarm"><i
						class="bi bi-bell-fill"></i></a>
				</div>
				<div class="nav-item">
					<a class="nav-link"
						href="${pageContext.request.contextPath}/wishlist"><i
						class="bi bi-bag-heart-fill"></i></a>
				</div>

				<c:choose>
					<c:when test="${not empty member}">
						<c:if test="${member.authority == 'Maker'}">
							<a
								href="${pageContext.request.contextPath}/makerPage/projectManager">
								<span class="nav-link me-2"><i
									class="bi bi-person-fill-up"></i></span>
							</a>
						</c:if>

						<c:if test="${member.authority == 'ADMIN'}">
							<a href="${pageContext.request.contextPath}/admin"> <span
								class="nav-link me-2"><i class="bi bi-person-fill-gear"></i></span>
							</a>
						</c:if>
						<a href="${pageContext.request.contextPath}/myPage/myPage"> <span
							class="nav-link me-2">${member.name}님</span>
						</a>

						<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="javascript:dialogLogin();">로그인</a>
						<a href="${pageContext.request.contextPath}/member/account">회원가입</a>
					</c:otherwise>
				</c:choose>

				<button class="btn btn-upload"
					onclick="location.href='${pageContext.request.contextPath}/makerPage/projectSign'">
					프로젝트 올리기</button>
			</div>
		</div>
	</nav>
</header>



<!-- 네비게이션 및 더보기 메뉴 관련 스크립트 -->
<script>
	$(document).ready(function() {
		// jQuery가 로드되었는지 확인용 로그
		console.log('jQuery loaded:', typeof jQuery !== 'undefined');

		const $moreMenuBtn = $('#moreMenuBtn');
		const $moreMenu = $('.hygge-more-menu');
		const $overlay = $('.hygge-overlay');

		function toggleMenu(show) {
			if (show) {
				$moreMenu.show();
				$overlay.show();
				// 버튼 활성화 상태 표시
				$moreMenuBtn.addClass('active');
			} else {
				$moreMenu.hide();
				$overlay.hide();
				// 버튼 비활성화 상태로 변경
				$moreMenuBtn.removeClass('active');
			}
		}

		// 클릭 이벤트를 직접 바인딩
		$moreMenuBtn[0].addEventListener('click', function(e) {
			e.preventDefault();
			e.stopPropagation();
			console.log('More menu clicked'); // 디버깅용 로그

			const isShown = $moreMenu.is(':visible');
			toggleMenu(!isShown);
		});

		// 오버레이 클릭시 메뉴 닫기
		$overlay.on('click', function() {
			toggleMenu(false);
		});

		// ESC 키 누를때 메뉴 닫기
		$(document).on('keydown', function(e) {
			if (e.key === 'Escape') {
				toggleMenu(false);
			}
		});

		// 메뉴 외부 클릭시 닫기
		$(document).on('click', function(e) {
			if (!$(e.target).closest('.more-menu-container').length) {
				toggleMenu(false);
			}
		});
	});
</script>




<!-- Login Modal -->
<script type="text/javascript">
	function dialogLogin() {
		$('form[name=modelLoginForm] input[name=id]').val('');
		$('form[name=modelLoginForm] input[name=pwd]').val('');

		$('#loginModal').modal('show');

		$('form[name=modelLoginForm] input[name=id]').focus();
	}

	function sendModelLogin() {
		var f = document.modelLoginForm;
		var str;

		str = f.id.value;
		if (!str) {
			f.id.focus();
			return;
		}

		str = f.pwd.value;
		if (!str) {
			f.pwd.focus();
			return;
		}

		f.action = '${pageContext.request.contextPath}/member/login';
		f.submit();
	}

	$(function() {
		$('#loginModal').on('hide.bs.modal', function() {
			$('button, input, select, textarea').each(function() {
				$(this).blur();
			});
		});
	});
</script>



<div class="modal fade" id="loginModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 600px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="login-container">
					<div class="logo-container">
						<img
							src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
							class="logo-img">
					</div>

					<form name="modelLoginForm" action="" method="post">
						<input type="text" name=id class="form-control" placeholder="아이디">
						<input type="password" name="pwd" class="form-control"
							autocomplete="off" placeholder="패스워드">

						<div class="form-check"
							style="display: flex; align-items: center;">
							<input class="form-check-input" type="checkbox"
								id="rememberMeModel"> <label class="form-check-label"
								for="rememberMeModel" style="margin-left: 8px;">아이디 저장</label>
						</div>

						<button type="button" class="btn btn-primary w-100"
							style="background-color: #75A400; color: white; margin-top: 10px;"
							onclick="sendModelLogin();">회원 로그인</button>

						<button type="button" class="kakao-login w-100 mt-3">
							<i class="bi bi-chat-fill"
								style="font-size: 20px; margin-right: 10px;"></i> 카카오로 로그인
						</button>

						<!-- 여백 추가 -->
						<div class="spacer"></div>

						<p class="form-control-plaintext text-center">
							<a href="${pageContext.request.contextPath}/member/idFind"
								class="text-decoration-none me-2">아이디찾기 </a> <a
								href="${pageContext.request.contextPath}/member/pwdFind"
								class="text-decoration-none me-2">비밀번호찾기 </a>
						</p>
					</form>
					<hr class="mt-3">
					<div>
						<p class="form-control-plaintext">
							아직 회원이 아니세요 ? <a
								href="${pageContext.request.contextPath}/member/account"
								class="text-decoration-none">회원가입</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>