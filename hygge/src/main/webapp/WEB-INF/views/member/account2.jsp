<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 - 2</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/member/account2.css"
	type="text/css">
<script
	src="${pageContext.request.contextPath}/dist/js/member/account2.js"
	type="text/javascript"></script>

<script type="text/javascript">
function memberOk() {
	const f = document.getElementById("accountForm");
    let str;
    
    str = f.userId.value;
    if (!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
        alert('아이디를 입력해주세요!');
        f.userId.focus();
        return;
    }

    str = f.name.value;
    if (!/^[가-힣]{2,5}$/.test(str)) {
        alert('이름은 2~5자까지 가능하며, 한글만 가능합니다.');
        f.name.focus();
        return;
    }

    str = f.nickName.value;
    if (!/^[가-힣a-zA-Z]{2,8}$/.test(str)) {
        alert('닉네임은 2~8자까지 가능하며, 한글과 영어만 가능합니다.');
        f.nickName.focus();
        return;
    }

    str = f.pwd.value;
    if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) {
        alert('패스워드는 5~10자까지 가능하며, 특수문자 혹은 숫자가 포함되어야 합니다.');
        f.pwd.focus();
        return;
    }

    if (str !== f.pwdCheck.value) {
        alert('패스워드가 일치하지 않습니다.');
        f.pwd.focus();
        return;
    }

    const genderChecked = document.querySelector('input[name="gender"]:checked');
    if (!genderChecked) {
        alert('성별을 선택하세요.');
        return;
    }

 	// 필수 약관 동의 체크 여부 확인
    const requiredCheckboxes = document.querySelectorAll(".terms input[type='checkbox'][required]");
    let allRequiredChecked = Array.from(requiredCheckboxes).every(checkbox => checkbox.checked);

    if (!allRequiredChecked) {
        alert("필수 약관에 동의해야 회원가입이 가능합니다.");
        return;
    }

    f.action = '${pageContext.request.contextPath}/member/account2';
    f.submit();
}

// 아이디 중복 검사
function checkUserId() {
	let userId = $('#userId').val();

	if (!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) {
		let str = '아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.';
		$('#userId').focus();
		$('.checkId').find('#userIdStatus').html(str).css('margin-left', '5px');;
		return;
	}
	
	let url = '${pageContext.request.contextPath}/member/checkUserId';
	
	// AJAX:POST-JSON
	$.post(url, {userId:userId}, function(data){
		let passed = data.passed;

		if(passed === 'true') {
			let str = '<span style="color:blue; font-weight: bold;">' + userId + '</span> 아이디는 사용가능 합니다.';
			$('.checkId').find('#userIdStatus').html(str);
			$('#userIdValid').val('true');
		} else {
			let str = '<span style="color:red; font-weight: bold;">' + userId + '</span> 아이디는 사용할수 없습니다.';
			$('.checkId').find('#userIdStatus').html(str);
			$('#userId').val('');
			$('#userIdValid').val('false');
			$('#userId').focus();
		}
	}, 'json');
	
}

// 이메일2 선택
function handleDomainChange() {
    var emailDomainSelect = document.getElementById('emailDomain');
    var selectedValue = emailDomainSelect.value;
    var emailDomainContainer = emailDomainSelect.parentNode;

    if (selectedValue === "custom") {
        // 입력란으로 변경
        var customInput = document.createElement('input');
        customInput.type = "text";
        customInput.className = "form-control";
        customInput.id = "emailDomain";
        customInput.placeholder = "직접 입력";
        customInput.focus();
        customInput.style.flex = "2";
        customInput.oninput = updateEmail;

        emailDomainContainer.replaceChild(customInput, emailDomainSelect);
    } else {
        updateEmail();
    }
}

function updateEmail() {
    var emailPrefix = document.getElementById('emailPrefix').value;
    var emailDomain = document.getElementById('emailDomain').value || document.getElementById('customDomain').value;

    if (emailPrefix && emailDomain) {
        document.getElementById('emailFull').value = `${emailPrefix}@${emailDomain}`;
    }
}

// 카테고리 선택
document.addEventListener("DOMContentLoaded", function () {
	const categoryItems = document.querySelectorAll(".category-item");
    const category1 = document.getElementById('category1');
    const category2 = document.getElementById('category2');
    const category3 = document.getElementById('category3');

    const maxCategory = 3;

    categoryItems.forEach(item => {
        item.addEventListener("click", function () {
            const selectedCategories = document.querySelectorAll(".category-item.selected");

            // 카테고리 선택 해제
            if (this.classList.contains("selected")) {
                this.classList.remove("selected");
            } else {
                if (selectedCategories.length < maxCategory) {
                    this.classList.add("selected");
                } else {
                    alert("최대 3개 카테고리만 선택 가능합니다.");
                }
            }

            const selectedcatory = Array.from(document.querySelectorAll(".category-item.selected"));
            category1.value = selectedcatory[0] ? selectedcatory[0].getAttribute('data-value') : "0";
            category2.value = selectedcatory[1] ? selectedcatory[1].getAttribute('data-value') : "0";
            category3.value = selectedcatory[2] ? selectedcatory[2].getAttribute('data-value') : "0";
        });
    });
});
		
</script>
</head>

<body>
	<div class="container">
		<div class="text-center">
			<img
				src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
				width="150">
		</div>

		<h2 class="text-start"
			style="font-size: 23px; margin-top: 50px; margin-bottom: 3px;">
			<i class="bi bi-person-fill"></i> 회원가입
		</h2>

		<div class="line" style="margin-bottom: 40px;"></div>

		<form id="accountForm" name="accountForm" method="post"
			enctype="multipart/form-data">
			<div class="mb-3 checkId">
				<label for="userId">아이디 <span style="color: red;">*</span></label>
				<div class="d-flex">
					<input type="text" class="form-control me-2" name="id" id="userId"
						placeholder="아이디를 입력하세요" required>
					<button type="button" class="btn btn-secondary"
						onclick="checkUserId();"
						style="width: 130px; border-radius: 50%; background-color: #ACC569; color: white; font-size: 1rem;">
						중복확인</button>
				</div>
				<span id="userIdStatus"></span>
			</div>

			<div class="mb-3">
				<label for="name">이름 <span style="color: red;">*</span></label> <input
					type="text" class="form-control" name="name" id="name"
					placeholder="이름을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="nickname">닉네임 <span style="color: red;">*</span></label>
				<input type="text" class="form-control" name="nickName"
					id="nickName" placeholder="닉네임을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="pwd">비밀번호 <span style="color: red;">*</span></label> <input
					type="password" class="form-control" name="pwd" id="pwd"
					placeholder="비밀번호를 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="pwdCheck">비밀번호 확인 <span style="color: red;">*</span></label>
				<input type="password" class="form-control" id="pwdCheck"
					placeholder="비밀번호 확인" required>
			</div>

			<div class="mb-3">
				<label for="birth">생년월일 <span style="color: red;">*</span></label> <input
					type="date" class="form-control" name="birth" id="birth" required>
			</div>

			<div class="mb-3">
				<label for="tel">전화번호 <span style="color: red;">*</span></label>
				<div class="d-flex">
					<input type="tel" class="form-control me-2" name="tel1" id="tel"
						maxlength="3" placeholder="xxx" required> <input
						type="tel" class="form-control me-2" name="tel2" id="tel"
						maxlength="4" placeholder="xxxx" required> <input
						type="tel" class="form-control me-2" name="tel3" id="tel"
						maxlength="4" placeholder="xxxx" required>
				</div>
			</div>

			<div class="mb-3">
				<label for="email">이메일 <span style="color: red;">*</span></label>
				<div class="d-flex">
					<input type="email" class="form-control me-2" name="email1"
						id="email" placeholder="이메일 앞부분" style="flex: 2;" required>

					<span class="me-2" style="line-height: 2.3;">@</span> <select
						class="form-select" name="email2" id="email"
						onchange="handleDomainChange()" style="flex: 2;">
						<option value="">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.com">daum.com</option>
						<option value="hanmail.com">hanmail.com</option>
						<option value="google.com">google.com</option>
						<option value="custom">직접 입력</option>
					</select>
					<!-- 직접 입력시 -->
					<input type="text" class="form-control" id="customDomain"
						placeholder="직접 입력" style="display: none; flex: 2;"
						onchange="updateEmail()"> <input type="hidden"
						name="email2" id="emailFull">
				</div>
			</div>

			<div class="mb-3">
				<label for="address">주소 <span style="color: red;">*</span></label>
				<div class="d-flex">
					<input type="text" class="form-control me-2" name="addr1"
						id="address" style="width: 950px;" placeholder="주소 찾기를 해주세요"
						required readonly> <input type="text"
						class="form-control me-2" name="postCode" id="postCode"
						style="width: 100px;" placeholder="우편번호" required readonly>
					<button type="button" class="btn btn-primary"
						onclick="daumPostcode()"
						style="width: 230px; background-color: #b2cc85; color: white; font-size: 1rem;">주소찾기</button>
				</div>
			</div>

			<div class="mb-3">
				<label for="detailAddress">상세주소 <span style="color: red;">*</span></label>
				<input type="text" class="form-control" name="addr2"
					id="detailAddress" placeholder="상세 주소를 입력하세요" required>
			</div>

			<div class="mb-3">
				<label>선호 카테고리</label>
				<div class="category-container">
					<div class="category-item" data-value="1">가전</div>
					<div class="category-item" data-value="2">패션</div>
					<div class="category-item" data-value="3">뷰티</div>
					<div class="category-item" data-value="4">홈·리빙</div>
					<div class="category-item" data-value="5">푸드</div>
					<div class="category-item" data-value="6">도서</div>
					<div class="category-item" data-value="7">캐릭터·굿즈</div>
					<div class="category-item" data-value="8">영화·음악</div>
					<div class="category-item" data-value="9">반려동물</div>
					<input type="hidden" name="category1" id="category1" value="0" />
					<input type="hidden" name="category2" id="category2" value="0" />
					<input type="hidden" name="category3" id="category3" value="0" />
				</div>
				<small style="color: #B63122;">선호 카테고리는 최대 3개까지 가능합니다.</small>
			</div>

			<div class="mb-3">
				<label>성별 <span style="color: red;">*</span></label>
				<div>
					<input type="radio" name="gender" id="male" value="1"> <label
						for="male" class="gender-label">남자</label> <input type="radio"
						name="gender" id="female" value="2"> <label for="female"
						class="gender-label">여자</label>
				</div>
				<div class="gender-divider"></div>
			</div>

			<div class="mb-3 terms">
				<p>이용약관</p>
				<div>
					<input type="checkbox" id="agreeAll"> <label for="agreeAll"
						style="font-size: 1.2rem; font-weight: bold; margin-bottom: 3px;">
						전체 동의합니다.</label>
				</div>
				<div>
					<input type="checkbox" id="terms" required> <label
						for="terms"> 이용약관 동의 (필수)
						<button type="button" class="btn btn-link p-0"
							data-bs-toggle="modal" data-bs-target="#modalTerms">보기</button>
					</label>
				</div>
				<div>
					<input type="checkbox" id="privacy" required> <label
						for="privacy"> 개인정보 수집 이용 동의 (필수)
						<button type="button" class="btn btn-link p-0"
							data-bs-toggle="modal" data-bs-target="#modalPrivacy">보기</button>
					</label>
				</div>
				<div>
					<input type="checkbox" id="marketing"> <label
						for="marketing"> 무료배송, 할인쿠폰 등 혜택/정보 수신 동의 (선택)
						<button type="button" class="btn btn-link p-0"
							data-bs-toggle="modal" data-bs-target="#modalMarketing">보기</button>
					</label>
				</div>
				<div>
					<input type="checkbox" id="age" required> <label for="age">
						본인은 만 14세 이상입니다.(필수)
						<button type="button" class="btn btn-link p-0"
							data-bs-toggle="modal" data-bs-target="#modalAge">보기</button>
					</label>
				</div>
			</div>

			<!-- 이용약관 모달창에 들어가는 내용 -->
			<div class="modal fade" id="modalTerms" tabindex="-1"
				aria-labelledby="modalTermsLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalTermsLabel">이용약관</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<p>이용약관 내용이 여기에 들어갑니다. 서비스 이용 시 아래 약관을 따릅니다.</p>
							<ul>
								<li>이용자는 본 서비스의 이용 규칙을 준수해야 합니다.</li>
								<li>서비스 제공자는 이용자의 정보를 안전하게 관리합니다.</li>
								<li>기타 자세한 내용은 본 약관을 참고하세요.</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal" style="background-color: #82B10C;">닫기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="modalPrivacy" tabindex="-1"
				aria-labelledby="modalPrivacyLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalPrivacyLabel">개인정보 수집 이용 동의</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">개인정보 수집을 많이 합니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal" style="background-color: #82B10C;">닫기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="modalMarketing" tabindex="-1"
				aria-labelledby="modalMarketingLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalMarketingLabel">혜택/정보 수신 동의</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">마케팅 문자를 하루에 30통씩 보냅니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal" style="background-color: #82B10C;">닫기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="modalAge" tabindex="-1"
				aria-labelledby="modalAgeLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalAgeLabel">만 14세 이상 확인</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">14세이상입니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal" style="background-color: #82B10C;">닫기</button>
						</div>
					</div>
				</div>
			</div>

			<div class="mb-3">
				<button type="button" id="accountBtn" class="btn btn-primary"
					onclick="memberOk();">가입하기</button>
			</div>
			<div>
				<button type="button" class="btn btn-secondary"
					onclick="location.href='${pageContext.request.contextPath}/';">등록취소</button>
			</div>
		</form>
	</div>
</body>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function daumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수

				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					fullAddr = data.roadAddress;

				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					fullAddr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if (data.userSelectedType === 'R') {
					//법정동명이 있을 경우 추가한다.
					if (data.bname !== '') {
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if (data.buildingName !== '') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
					fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postCode').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('address').value = fullAddr;

				// 커서를 상세주소 필드로 이동한다.
				document.getElementById('detailAddress').focus();
			}
		}).open();
	}
	
	/* document.getElementById("accountForm").onsubmit = function(event) {
	    var password = document.getElementById("password").value;
	    var pwdCheck = document.getElementById("pwdCheck").value;

	    if (password !== pwdCheck) {
	        alert("비밀번호가 일치하지 않습니다.");
	        event.preventDefault(); // 폼 제출 방지
	    }
	}; */
</script>

</html>