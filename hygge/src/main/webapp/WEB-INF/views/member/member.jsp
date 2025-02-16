<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #fff;
}

.container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	border: none; /* 테두리 제거 */
	border-radius: 10px;
}

h2 {
	text-align: center;
	font-size: 2rem;
	font-weight: bold;
	margin-bottom: 20px;
	color: #333;
}

label {
	font-weight: bold;
	font-size: 1rem;
	margin-bottom: 5px;
}

.form-control, .form-select {
	border-radius: 5px;
	border: 1px solid #ccc;
	padding: 8px;
	font-size: 1rem;
}

.btn-check {
	display: inline-block;
	padding: 5px 10px;
	background-color: #b2cc85;
	border: none;
	border-radius: 5px;
	color: #fff;
	cursor: pointer;
}

.btn-check:hover {
	background-color: #9ab370;
}

.category-container label {
	display: inline-block;
	background-color: #e0e0e0;
	padding: 8px 12px;
	border-radius: 5px;
	margin: 5px;
	cursor: pointer;
}

.category-container input:checked+label {
	background-color: #b2cc85;
	color: white;
}

.terms {
	font-size: 0.9rem;
}

.btn-primary {
	background-color: #b2cc85;
	border: none;
	padding: 10px;
	width: 100%;
	font-size: 1.2rem;
	border-radius: 5px;
}

.btn-primary:hover {
	background-color: #9ab370;
}

.btn-secondary {
	background-color: #d6d6d6;
	border: none;
	padding: 10px;
	width: 100%;
	font-size: 1.2rem;
	border-radius: 5px;
}

.btn-secondary:hover {
	background-color: #b5b5b5;
}

.line {
	border-bottom: 2.5px solid #000; /* 원하는 색상 */
	width: 100%;
	margin-top: 3px;
	margin-bottom: 10px;
}

.category-container {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.category-item {
	background-color: #e0e0e0;
	padding: 12px 25px;
	border-radius: 50px;
	cursor: pointer;
	font-size: 1rem;
}

.category-item:hover {
	background-color: #b2cc85;
	color: white;
}

.gender-label {
	margin-right: 20px;
	font-size: 1rem;
}

.gender-divider {
	border-top: 1.5px solid #82B10C;
	margin-top: 10px;
	width: 100%;
}

.terms p {
	font-size: 1.2rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.terms div {
	margin-bottom: 10px; /* 각 항목 사이에 간격을 추가 */
	font-size: 0.9rem; /* 항목 텍스트 폰트 사이즈 작게 */
}

.terms label {
	margin-left: 10px; /* 체크박스와 텍스트 간의 간격 */
	font-weight: normal; /* 텍스트 굵기 제거 */
}

</style>
</head>
<body>

	<div class="container">
		<div class="text-center">
			<img
				src="${pageContext.request.contextPath}/dist/images/main/main_logo.png"
				alt="Hygge Logo" width="150">
		</div>

		<h2 class="text-start"
			style="font-size: 20px; margin-top: 30px; margin-bottom: 1px;">
			<i class="bi bi-person-fill"></i> 회원가입
		</h2>

		<div class="line"></div>


		<form id="signupForm">
			<div class="mb-3">
				<label for="username">아이디 *</label>
				<div class="d-flex">
					<input type="text" class="form-control me-2" id="username" placeholder="아이디를 입력하세요" required>
					<button type="button" class="btn btn-secondary"
						onclick="checkUsername()" style="width: 120px; background-color: #b2cc85; color: white; font-size: 1rem;">중복확인</button>

				</div>
				<span id="usernameStatus"></span>
				<!-- 아이디 중복 여부 표시 -->
			</div>

			<div class="mb-3">
				<label for="name">이름 *</label> <input type="text"
					class="form-control" id="name" placeholder="이름을 입력하세요" required>
					
			</div>

			<div class="mb-3">
				<label for="nickname">닉네임 *</label> <input type="text"
					class="form-control" id="nickname" placeholder="닉네임을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="password">비밀번호 *</label> <input type="password"
					class="form-control" id="password" placeholder="비밀번호를 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="passwordConfirm">비밀번호 확인 *</label> <input
					type="password" class="form-control" id="passwordConfirm" placeholder="비밀번호 확인" required>
			</div>

			<div class="mb-3">
				<label for="birthdate">생년월일 *</label> <input type="date"
					class="form-control" id="birthdate" required>
			</div>

			<div class="mb-3">
				<label for="phone">전화번호 *</label>
				<div class="d-flex">
					<input type="tel" class="form-control me-2" id="phone1"
						maxlength="3" placeholder="xxx" required> <input
						type="tel" class="form-control me-2" id="phone2" maxlength="4"
						placeholder="xxxx" required> <input type="tel"
						class="form-control" id="phone3" maxlength="4" placeholder="xxxx"
						required>
				</div>
			</div>

			<div class="mb-3">
				<label for="email">이메일 *</label>
				<div class="d-flex">
					<!-- 이메일 앞부분 입력란 -->
					<input type="email" class="form-control me-2" id="emailPrefix"
						placeholder="이메일 앞부분" style="flex: 2;" required>

					<!-- @ 기호 고정 -->
					<span class="me-2" style="line-height: 2.3;">@</span>

					<!-- 도메인 선택 또는 직접 입력란 -->
					<select class="form-select" id="emailDomain"
						onchange="handleDomainChange()" style="flex: 2;">
						<option value="">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.com">daum.com</option>
						<option value="hanmail.com">hanmail.com</option>
						<option value="google.com">google.com</option>
						<option value="custom">직접 입력</option>
					</select>

					<!-- 직접 입력 옵션을 위한 추가 입력란 -->
					<input type="text" class="form-control" id="customDomain"
						placeholder="직접 입력" style="display: none; flex: 2;"
						onchange="updateEmail()">
				</div>
			</div>

			<div class="mb-3">
				<label for="address">주소 *</label>
				<div class="d-flex">
					<input type="text" class="form-control me-2" id="address"
						placeholder="주소를 입력하세요" required readonly>
					<input type="text" class="form-control me-2" id="postCode" placeholder="우편번호" required readonly>
					<button type="button" class="btn btn-primary"
						onclick="daumPostcode()"style="width: 120px; background-color: #b2cc85; color: white; font-size: 1rem;">주소찾기</button>
				</div>
			</div>

			<div class="mb-3">
				<label for="detailAddress">상세주소 *</label> <input type="text"
					class="form-control" id="detailAddress" placeholder="상세 주소를 입력하세요"
					required>
			</div>

			<div class="mb-3">
				<label>선호 카테고리 *</label>
				<div class="category-container">
					<div class="category-item">가전</div>
					<div class="category-item">패션</div>
					<div class="category-item">뷰티</div>
					<div class="category-item">홈·리빙</div>
					<div class="category-item">푸드</div>
				</div>
			</div>


			<div class="mb-3">
				<label>성별 *</label>
				<div>
					<input type="radio" id="male" name="gender" value="남자"> <label
						for="male" class="gender-label">남자</label> <input type="radio"
						id="female" name="gender" value="여자"> <label for="female"
						class="gender-label">여자</label>
				</div>
				<div class="gender-divider"></div>
			</div>

		<div class="mb-3 terms">
    <p>이용약관</p>
    <div>
        <input type="checkbox" id="agreeAll" required>
        <label for="agreeAll" style="font-size: 1.2rem; font-weight: bold; margin-bottom:1px;">전체 동의합니다.</label>
    </div>
    <div>
        <input type="checkbox" id="terms" required>
        <label for="terms">
            이용약관 동의 (필수) 
            <button type="button" class="btn btn-link p-0" data-bs-toggle="modal" data-bs-target="#modalTerms">보기</button>
        </label>
    </div>
    <div>
        <input type="checkbox" id="privacy" required>
        <label for="privacy">
            개인정보 수집 이용 동의 (필수)
            <button type="button" class="btn btn-link p-0" data-bs-toggle="modal" data-bs-target="#modalPrivacy">보기</button>
        </label>
    </div>
    <div>
        <input type="checkbox" id="marketing">
        <label for="marketing">
            무료배송, 할인쿠폰 등 혜택/정보 수신 동의 (선택)
            <button type="button" class="btn btn-link p-0" data-bs-toggle="modal" data-bs-target="#modalMarketing">보기</button>
        </label>
    </div>
    <div>
        <input type="checkbox" id="age" required>
        <label for="age">
            본인은 만 14세 이상입니다.(필수)
            <button type="button" class="btn btn-link p-0" data-bs-toggle="modal" data-bs-target="#modalAge">보기</button>
        </label>
    </div>
</div>

<div class="modal fade" id="modalTerms" tabindex="-1" aria-labelledby="modalTermsLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTermsLabel">이용약관</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                이용약관 내용이 여기에 들어갑니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color:#82B10C; ">닫기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalPrivacy" tabindex="-1" aria-labelledby="modalPrivacyLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalPrivacyLabel">개인정보 수집 이용 동의</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                개인정보 수집을 많이 합니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color:#82B10C; ">닫기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalMarketing" tabindex="-1" aria-labelledby="modalMarketingLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalMarketingLabel">혜택/정보 수신 동의</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                마케팅 문자를 하루에 30통씩 보냅니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color:#82B10C; ">닫기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalAge" tabindex="-1" aria-labelledby="modalAgeLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAgeLabel">만 14세 이상 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                14세이상입니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color:#82B10C; ">닫기</button>
            </div>
        </div>
    </div>
</div>

			<div class="mb-3">
				<button type="submit" class="btn btn-primary">가입하기</button>
			</div>

			<div>
				<button type="reset" class="btn btn-secondary">등록취소</button>
			</div>
		</form>
	</div>



	<script>
		// 아이디 중복 확인 함수
		function checkUsername() {
			const username = document.getElementById('username').value;
			const usernameStatus = document.getElementById('usernameStatus');

			if (username) {
				// 실제 서버 요청을 보내는 로직이 필요함
				// 아래는 임시로 '사용가능' 메시지 처리
				usernameStatus.style.color = '#82B10C';
				usernameStatus.innerText = '사용가능';
			} else {
				usernameStatus.style.color = 'red';
				usernameStatus.innerText = '아이디를 입력해 주세요.';
			}
		}

		function handleDomainChange() {
			var emailPrefix = document.getElementById('emailPrefix').value;
			var emailDomain = document.getElementById('emailDomain').value;
			var customDomain = document.getElementById('customDomain').value;

			if (emailDomain === "custom") {
				// "직접 입력"을 선택한 경우 도메인 입력란을 보이게 함
				document.getElementById('customDomain').style.display = "inline-block";
			} else {
				// "직접 입력"을 선택하지 않으면 도메인 입력란 숨김
				document.getElementById('customDomain').style.display = "none";
				if (emailPrefix && emailDomain) {
					// 선택된 도메인을 이메일 앞부분에 추가
					document.getElementById('emailPrefix').value = emailPrefix
							+ '@' + emailDomain;
				}
			}
		}

		function updateEmail() {
			var emailPrefix = document.getElementById('emailPrefix').value;
			var customDomain = document.getElementById('customDomain').value;

			if (customDomain) {
				// "직접 입력"한 도메인과 이메일 앞부분을 합침
				document.getElementById('emailPrefix').value = emailPrefix
						+ '@' + customDomain;
			}
		}

		// 폼 제출 시 비밀번호 확인
		document.getElementById("signupForm").onsubmit = function(event) {
			const password = document.getElementById('password').value;
			const passwordConfirm = document.getElementById('passwordConfirm').value;

			if (password !== passwordConfirm) {
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				event.preventDefault(); // 폼 제출 방지
			}
		}
		
	    document.getElementById("agreeAll").addEventListener("change", function () {
	        let isChecked = this.checked;
	        let checkboxes = document.querySelectorAll(".terms input[type='checkbox']");
	        
	        checkboxes.forEach((checkbox) => {
	            checkbox.checked = isChecked;
	        });
	    });

	    document.querySelectorAll(".terms input[type='checkbox']").forEach((checkbox) => {
	        checkbox.addEventListener("change", function () {
	            let allChecked = document.querySelectorAll(".terms input[type='checkbox']:not(#agreeAll)").length === 
	                             document.querySelectorAll(".terms input[type='checkbox']:not(#agreeAll):checked").length;
	            
	            document.getElementById("agreeAll").checked = allChecked;
	        });
	    });
		
	</script>
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
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')'
								: '');
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postCode').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('address').value = fullAddr;

					// 커서를 상세주소 필드로 이동한다.
					document.getElementById('detailAddress').focus();
				}
			}).open();
		}
		document.getElementById("signupForm").onsubmit = function(event) {
		    var password = document.getElementById("password").value;
		    var passwordConfirm = document.getElementById("passwordConfirm").value;

		    if (password !== passwordConfirm) {
		        alert("비밀번호가 일치하지 않습니다.");
		        event.preventDefault(); // 폼 제출 방지
		    }
		};
	</script>
</body>
</html>
