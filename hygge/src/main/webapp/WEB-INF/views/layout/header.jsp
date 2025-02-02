<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<head>
	<title>hygge</title>
	<link rel="icon" href="${pageContext.request.contextPath}/dist/images/hygge_logo.ico" type="image/x-icon">
	<style type="text/css">
	.nav-menu-self {
		font-size: 17px;
	}
	@font-face {
		font-family: 'GongGothicMedium';
		src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}
	</style>
</head>

<nav class="navbar navbar-expand-lg navbar-light" style="height: 50px; background-color: white; box-shadow: none;">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/" style="width: 5%;"><img src="${pageContext.request.contextPath}/dist/images/hygge_logo.png" style="width: 100%;"></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent" style="align">
			<ul class="navbar-nav flex-nowrap nav-menu-self">
				<li class="nav-item">
					<a class="nav-link" href="#">인기</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">신규</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">공개예정</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">마감임박</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						더보기 <i class="bi bi-chevron-down" style="font-size: 1.2rem"></i>
					</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">공지사항</a></li>
						<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">이벤트</a></li>
						<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">투표</a></li>
						<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">체험단</a></li>
						<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">중고장터</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="${pageContext.request.contextPath}/">QnA</a></li>
					</ul>
				</li>
			</ul>
			<ul class="navbar-nav ms-auto flex-nowrap">
				<li class="nav-item"><a class="nav-link" href="#">팔로잉</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/alarm">알림</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/wishlist">위시리스트</a></li>
				<li class="nav-item"><a class="nav-link" href="javascript:dialogLogin();">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/account">회원가입</a></li>
				<li class="nav-item">
					<div class="rounded p-1 m-3 div-project-upload" style="background-color: #82B10C;"><a class="nav-link nav-project-upload" href="#">프로젝트 올리기</a></div>
				</li>
			</ul>
		</div>
	   
	</div>
</nav>

<!-- Login Modal -->
<script type="text/javascript">
function dialogLogin() {
	$('form[name=modelLoginForm] input[name=userId]').val('');
	$('form[name=modelLoginForm] input[name=userPwd]').val('');
	 
	$('#loginModal').modal('show');   
	
	$('form[name=modelLoginForm] input[name=userId]').focus();
}

function sendModelLogin() {
	var f = document.modelLoginForm;
	var str;
	
	str = f.userId.value;
	if(!str) {
		f.userId.focus();
		return;
	}
	
	str = f.userPwd.value;
	if(!str) {
		f.userPwd.focus();
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/';
	f.submit();
}

$(function(){
	$('#loginModal').on('hide.bs.modal', function() {
		$('button, input, select, textarea').each(function(){
			$(this).blur();
		});
	});
});
</script>

<div class="modal fade" id="loginModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginViewerModalLabel">Login</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="p-3">
					<form name="modelLoginForm" action="" method="post" class="row g-3">
						<div class="mt-0">
						    <p class="form-control-plaintext">계정으로 로그인 하세요</p>
						</div>
						<div class="mt-0">
							<input type="text" name="userId" class="form-control" placeholder="아이디">
						</div>
						<div>
							<input type="password" name="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
						</div>
						<div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="rememberMeModel">
								<label class="form-check-label" for="rememberMeModel"> 아이디 저장</label>
							</div>
						</div>
						<div>
							<button type="button" class="btn btn-primary w-100" onclick="sendModelLogin();">Login</button>
						</div>
						<div>
							<p class="form-control-plaintext text-center">
							<a href="#" class="text-decoration-none me-2">패스워드를 잊으셨나요 ?</a>
							</p>
						</div>
					</form>
					<hr class="mt-3">
					<div>
						<p class="form-control-plaintext mb-0">
							아직 회원이 아니세요 ?
							<a href="${pageContext.request.contextPath}/" class="text-decoration-none">회원가입</a>
						</p>
					</div>
				</div>
			
			</div>
		</div>
	</div>
</div>