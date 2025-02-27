<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험단 신청</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/tester/testForm.css"
	type="text/css">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function daumPostcode() {
		new daum.Postcode(
				{
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
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('postCode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('addr1').value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('addr2').focus();
					}
				}).open();
	}

	// 폼 제출 처리
	function submitTesterForm() {
		// 폼 유효성 검사
		var f = document.testerForm;

		if (!f.name.value.trim()) {
			alert("닉네임을 입력해주세요.");
			f.name.focus();
			return;
		}

		if (!f.age.value.trim()) {
			alert("나이를 입력해주세요.");
			f.age.focus();
			return;
		}

		if (!f.tel1.value.trim() || !f.tel2.value.trim()
				|| !f.tel3.value.trim()) {
			alert("전화번호를 모두 입력해주세요.");
			f.tel1.focus();
			return;
		}

		if (!f.gender.value) {
			alert("성별을 선택해주세요.");
			return;
		}

		if (!f.addr1.value.trim() || !f.postCode.value.trim()
				|| !f.addr2.value.trim()) {
			alert("주소를 모두 입력해주세요.");
			if (!f.addr1.value.trim() || !f.postCode.value.trim()) {
				alert("주소찾기를 통해 주소를 입력해주세요.");
			} else {
				f.addr2.focus();
			}
			return;
		}

		if (!f.agreement.checked) {
			alert("개인정보 수집 및 이용에 동의해주세요.");
			f.agreement.focus();
			return;
		}

		// 폼 제출 전 확인
		if (confirm("체험단에 신청하시겠습니까?")) {
			document.getElementById("modalOverlay").style.display = "flex";
			setTimeout(function() {
				f.submit();
			}, 1000); // 1초 후 폼 제출
		}
	}
</script>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="form-container">
		<h1 class="main-title">${testBoard.title}</h1>

		<img
			src="${pageContext.request.contextPath}/uploads/project/${testBoard.thumbnail}"
			class="slider-image">

		<div class="product-info">
			<div class="detail-box">
				<!-- 줄바꿈으로 한줄씩 포맷하기 -->
				<p>${testBoard.content}</p>
			</div>
		</div>

		<br> <br>

		<!-- 신청 폼 -->
		<div class="application-form">
			<h2 style="margin-bottom: 40px;">신청하기</h2>
			<form name="testerForm"
				action="${pageContext.request.contextPath}/tester/testForm"
				method="post">
				<input type="hidden" name="num" value="${testBoard.num}"> 
				<input type="hidden" name="tester_num" value="${testBoard.tester_num}">
				<!-- 회원 번호 hidden으로 전송 -->
				<input type="hidden" name="memberIdx" value="${member.memberidx}">

				<div class="form-group">
					<label for="name">닉네임</label> 
					<input type="text" id="name" name="name" class="form-input" required>
				</div>

				<div class="form-group">
					<label for="age">나이</label> 
					<input type="text" id="age" name="age" class="form-input" required>
				</div>

				<div class="form-group">
					<label for="tel">전화번호</label>
					<div class="tel-group">
						<input type="text" id="tel1" name="tel1" class="form-input tel"
							maxlength="3" required> <span class="tel-dash">-</span> <input
							type="text" id="tel2" name="tel2" class="form-input tel"
							maxlength="4" required> <span class="tel-dash">-</span> <input
							type="text" id="tel3" name="tel3" class="form-input tel"
							maxlength="4" required>
					</div>
				</div>

				<div class="form-group">
					<label>성별</label>
					<div class="radio-group">
						<input type="radio" id="male" name="gender" value="1"
							class="gender-radio"> <label for="male">남</label> <input
							type="radio" id="female" name="gender" value="2"
							class="gender-radio"> <label for="female">여</label>
					</div>
				</div>

				<div class="form-group">
					<label for="address">주소</label>
					<div class="address-row">
						<input type="text" id="addr1" name="addr1" class="form-input"
							placeholder="주소를 입력해주세요." readonly required> <input
							type="text" id="postCode" name="postCode" class="form-input"
							placeholder="우편번호" readonly required>
						<button type="button" onclick="daumPostcode()" class="address-btn">주소찾기</button>
					</div>
					<input type="text" id="addr2" name="addr2" class="form-input"
						placeholder="상세주소를 입력해주세요." required style="margin-top: 10px;">
				</div>

				<div class="agreement-box">
					<label class="checkbox-label"> <input type="checkbox"
						name="agreement" id="agreement" required> 개인정보 수집 및 이용에
						동의합니다
					</label>
				</div>

				<button type="button" class="submit-button"
					onclick="submitTesterForm()">신청</button>
			</form>
		</div>
	</div>

	<!-- 신청 완료 모달 -->
	<div id="modalOverlay" class="modal-overlay">
		<div class="modal-content">
			<div class="modal-icon">✓</div>
			<h3>신청이 완료되었습니다!</h3>
			<p>체험단 심사 후 결과를 알려드립니다.</p>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>
</body>
</html>