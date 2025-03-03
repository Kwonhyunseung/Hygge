<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<head>

<title>hygge</title>
<link rel="icon" href="${pageContext.request.contextPath}/dist/images/hygge_logo.ico" type="image/x-icon">

<style>
.more-menu-container {
    display: flex;
    align-items: center;
    height: 100%;  /* 이 줄 추가 */
}
.hygge-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: rgba(0, 0, 0, 0.2);
    backdrop-filter: blur(2px);
    z-index: 999;
    margin: 0;
    padding: 0;
}

.hygge-more-menu {
    display: none;
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    width: 100%;
    max-width: 1200px;
    background: white;
    padding: 50px;
    border-radius: 10px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    z-index: 1001; /* z-index 증가 */
}

.hygge-menu-items {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 20px;
    justify-items: center;
}

.hygge-menu-item {
    text-decoration: none;
    text-align: center;
    transition: transform 0.2s ease;
}

.hygge-menu-item:hover {
    transform: translateY(-5px);
}

.hygge-circle-menu {
    width: 120px;
    height: 120px;
    background-color: #B7D12A;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 10px;
    transition: all 0.3s ease;
}

.hygge-circle-menu:hover {
    background-color: #82B10C;
    box-shadow: 0 4px 12px rgba(131, 177, 12, 0.3);
}

.hygge-circle-menu span {
    color: white;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    padding: 10px;
}

@media (max-width: 768px) {
    .hygge-more-menu {
        width: 95%;
        padding: 20px;
    }

    .hygge-menu-items {
        grid-template-columns: repeat(3, 1fr);
    }

    .hygge-circle-menu {
        width: 100px;
        height: 100px;
    }

    .hygge-circle-menu span {
        font-size: 14px;
    }
}

@media (max-width: 480px) {
    .hygge-menu-items {
        grid-template-columns: repeat(2, 1fr);
    }

    .hygge-circle-menu {
        width: 90px;
        height: 90px;
    }
}
.navbar-expand-lg {
	max-width: 1300px;
	margin: 0 auto;
}

.nav-item {
    height: 100%;  /* 이 줄 추가 */
    display: flex;
    align-items: center;
    margin: 0px;
    padding: 0px;
}

.nav-item a {
    padding: 0.5rem 1rem;
    margin: 0;
    color: #000;
    font-weight: 600;
    font-size: 20px;
}

.nav-item a:hover {
	color: #82B10C;
}

.nav-item a:active {
	color: #82B10C;
}

.navbar-nav {
	margin-left: 20px;
}

.btn-upload {
	background-color: #4CAF50;
	color: white;
	font-weight: bold;
	border-radius: 20px;
	padding: 5px 15px;
}

.btn-upload:hover {
	background-color: #45A049;
}

.header-right a {
	color: #333;
	font-size: 14px;
	margin: 0 10px;
	text-decoration: none;
}

.header-right a:hover {
	color: #4CAF50;
}

@media ( max-width : 768px) {
	.navbar-brand img {
		width: 60px;
	}
	.nav-item a {
		font-size: 14px;
		margin: 0 5px;
	}
	.btn-upload {
		font-size: 14px;
		padding: 5px 10px;
	}
}

/* 로그인 css */
.logo-container {
	text-align: center;
	margin-bottom: 20px;
}

.logo-img {
	width: auto;
	height: 50px;
}

.form-control {
	margin-bottom: 10px;
}

.btn-primary, .kakao-login {
	border: none;
}

.kakao-login {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 12px;
	background-color: #FEE500;
	border-radius: 10px;
	font-weight: bold;
	cursor: pointer;
}

.spacer {
	height: 10px;
}

.form-control-plaintext {
	text-align: center;
}

.btn-primary, .kakao-login {
	height: 50px;
	border-radius: 10px;
	font-size: 16px;
}

.btn-primary:hover {
	color: black !important;
	border: 1px solid #5C7F00;
}

.kakao-login:hover {
	color: white !important;
	border: 1px solid #E6C200;
}

.kakao-login:hover i {
	color: white !important;
}

.kakao-login i {
	color: black;
	.
	btn-primary
	{
}

.navbar-collapse {
    display: flex !important;
}

.nav-underline {
    display: flex;
    align-items: center;
}

.nav-item.position-relative {
    display: inline-block; /* 이 줄 추가 */
}

.nav-item {
    display: flex;
    padding: 0px;
}



</style>
</head>
<header>
  <nav class="navbar navbar-expand-lg">
  
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/dist/images/main/main_logo.png" style="width: 100px;">
      </a>

      <div class="navbar-collapse d-flex" id="navbarNav">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/funding/hotContent">인기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/funding/new">신규</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/funding/comingsoon">공개예정</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/funding/deadline">마감임박</a>
          </li>
          <li class="nav-item">
    		<a class="nav-link" id="moreMenuBtn" href="#">더보기</a>
    		<div class="hygge-overlay"></div> 
		    <div class="hygge-more-menu">
		      	<div class="hygge-menu-items">
		                <a href="${pageContext.request.contextPath}/today" class="hygge-menu-item">
                  <div class="hygge-circle-menu">
                    <span>이달의 투표</span>
                  </div>
                </a>
                <a href="${pageContext.request.contextPath}/event" class="hygge-menu-item">
                  <div class="hygge-circle-menu">
                    <span>이벤트</span>
                  </div>
                </a>
                <a href="${pageContext.request.contextPath}/notice" class="hygge-menu-item">
                  <div class="hygge-circle-menu">
                    <span>공지사항</span>
                  </div>
                </a>
                <a href="${pageContext.request.contextPath}/tester/list" class="hygge-menu-item">
                  <div class="hygge-circle-menu">
                    <span>체험단</span>
                  </div>
                </a>
                <a href="${pageContext.request.contextPath}/usedBoard/list" class="hygge-menu-item">
                  <div class="hygge-circle-menu">
                    <span>중고게시판</span>
                  </div>
                 
                </a>
              </div>
            </div>
          </li>
        </ul>
      </div>
      <div class="header-right d-flex align-items-center">
        <div class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/following"><i class="bi bi-stars"></i></a>
        </div>
        <div class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/alarm"><i class="bi bi-bell-fill"></i></a>
        </div>
        <div class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/wishlist"><i class="bi bi-suit-heart-fill"></i></a>
        </div>
        
        <c:choose>
          <c:when test="${not empty member}">
           <a href="${pageContext.request.contextPath}/myPage/myPage"> <span class="nav-link me-2">${member.name}님</span></a>
            <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
          </c:when>
          <c:otherwise>
            <a href="javascript:dialogLogin();">로그인</a>
            <a href="${pageContext.request.contextPath}/member/account">회원가입</a>
          </c:otherwise>
        </c:choose>
        
        <button class="btn btn-upload" onclick="location.href='${pageContext.request.contextPath}/makerPage/projectSign'">프로젝트 올리기</button>
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
        if(show) {
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
	if(!str) {
		f.id.focus();
		return;
	}
	
	str = f.pwd.value;
	if(!str) {
		f.pwd.focus();
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/member/login';
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
						<input type="text" name=id class="form-control"
							placeholder="아이디"> 
							<input type="password" name="pwd"
							class="form-control" autocomplete="off" placeholder="패스워드">

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
							 <a href="${pageContext.request.contextPath}/member/idFind" class="text-decoration-none me-2">아이디찾기 </a>
                       		 <a href="${pageContext.request.contextPath}/member/pwdFind" class="text-decoration-none me-2">비밀번호찾기 </a>
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