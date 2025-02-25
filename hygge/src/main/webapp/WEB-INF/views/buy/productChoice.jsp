<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYGGE결제창</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/buy/productChoice.css" type="text/css">

<script type="text/javascript">
function two() {
    if(!$('#agreeAll').is(':checked')) {
        alert('필수 약관에 동의해주세요.');
        return;
    }
    alert('결제가 완료되었습니다.');
    location.href = "${pageContext.request.contextPath}/buy/complete";
}

$(function() {
    $('#agreeAll').change(function() {
        const isChecked = $(this).is(':checked');
        $('#agree1, #agree2').prop('checked', isChecked);
    });
    
    $('#agree1, #agree2').change(function() {
        const allChecked = $('#agree1').is(':checked') && $('#agree2').is(':checked');
        $('#agreeAll').prop('checked', allChecked);
    });
});


function newAddr() {
    const $addrBtn = $('#addrBtn');
    const $receiver = $('#receiver');
    const $address = $('#address');
    const $detailAddr = $('#detailAddr');
    const $postCode = $('#postCode');
    
    if($addrBtn.val() === "신규 배송지 입력") {
        // 입력 필드 초기화 및 편집 가능하게 변경
        $receiver.val('').removeAttr('readonly');
        $address.val('').removeAttr('readonly');
        $detailAddr.val('').removeAttr('readonly');
        $postCode.val('').removeAttr('readonly');
        
        // 버튼 텍스트 변경
        $addrBtn.val("기본 배송지로 돌아가기");
    } else {
        // 원래 정보로 복원
        $receiver.val('${product.receiver}').attr('readonly', true);
        $address.val('${product.address}').attr('readonly', true);
        $detailAddr.val('${product.detailAddr}').attr('readonly', true);
        $postCode.val('${product.postCode}').attr('readonly', true);
        
        // 버튼 텍스트 복원
        $addrBtn.val("신규 배송지 입력");
    }
}

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
				document.getElementById('detailAddr').focus();
			}
		}).open();
	}
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<div class="body-container">

		<div class="row tow-circle">
			<div class="col-2 circle">
				<p>리워드<br>선택</p>
			</div>
			<div class="connecting-line" style="width: 63px;"></div>
			<div class="col-2 circle">
				<p>결제<br>예약</p>
			</div>
		</div>
		
		<h3>
			리워드 결제
			<img src="${pageContext.request.contextPath}/dist/images/buy/2.png" alt="온라인 상점 아이콘">
		</h3>
		
		<div class="choicedProduct">
			
			<div class="row mainInfo">
				<div class="col-5 thumbnail">
					<img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}">
				</div>
				<div class="col-7 productInfo">
					<h4>상품 정보</h4>
					<br>
					<p class="title">${product.title}
						<span class="price"><fmt:formatNumber value="${product.price}" pattern="#,###"/>원</span>
					</p>
					<c:set var="details" value="${product.detail}" />
<p class="detail" style="margin-left: 30px;">${details}</p>
					<p class="stock">
						구매 수량
						<span class="stock">${product.amount}개</span>
					</p>
					<p class="productPrice">
						결제 금액
						<span class="productPrice"><fmt:formatNumber value="${product.sum}" pattern="#,###"/>원</span>
					</p>
				</div>
			</div>
			
			<div class="supporterInfo">
			<h4>서포터 정보</h4>
				<p class="name">
					이름
					<span class="name">멤버유저이름</span>
				</p>
				<p class="email">
					이메일
					<span class="email">멤버유저이메일</span>
				</p>
				<p class="phone">
					핸드폰 번호
					<span class="phone">멤버유저번호</span>
				</p>
			</div>
				
			<div class="deliveryInfo">
			<h4>배송 정보</h4>
				<!-- 디폴트는 자동으로 정보 기입 -->
				<!-- 신규배송지 누를경우, readonly풀리면서 받는사람, 주소 새로 입력하도록 -->
				<input type="button" id="addrBtn" value="신규 배송지 입력" onclick="newAddr();">
				<input type="text" id="receiver" placeholder="${product.receiver}" readonly>
				<div>
					<input type="text" id="address" placeholder="멤버유저주소" readonly>
					<input type="text" id="postCode" placeholder="멤버유저우편번호" readonly>
				</div>
				<input type="text" id="detailAddr" placeholder="멤버유저상세주소" readonly>
				<input type="text" id="aInfo" placeholder="주문 요청 사항을 입력해주세요(선택)">
			</div>
			
			
			<div class="coupon">
				<h4>쿠폰</h4>
				<select class="couponSelect">  
				    <option value="c1">쿠폰을 선택해주세요</option>  
				    <option value="c2">첫 구매 배송비 할인</option>  
				    <option value="c3">50,000원 할인</option>
				    <option value="c4">쿠폰 선택 안함</option>
				</select>
			</div>
			
			<div class="col paymentMethod">
				<h4>결제 수단</h4>
				<div>
				    <input id="card" name="payMethod" type="radio" id="card" value="1">
				    <label for="card">카드</label>
				</div>
				<!-- <div>
				    <input id="cash" name="payMethod" type="radio" value="cash">
				    <label for="cash">계좌이체</label>
				</div> -->
			</div>
			
			<div class="finalPayment">
			<h4>결제 금액</h4>
				<p class="productPrice">
					리워드 금액
					<span class="productPrice">1,000,000원</span>
				</p>
				<p class="couponPrice">
					쿠폰 금액
					<span class="couponPrice">50,000원</span>
				</p> 
				<p class="deliveryFee">
					배송비
					<span class="deliveryFee">${project.shipping_fee}원</span>	
				</p>
				<hr>
				<p class="totalPrice">
					총 결제 금액
					<span class="totalPrice">949,000원</span>
				</p>
			</div>
			
			<div class="payNote">
				<h4>결제 유의사항</h4>
				<p>예약 결제의 경우 결제 실행일에 결제자 귀책사유(한도초과, 이용정지 등)로 인하여 결제가 실패할 수 있으니, 결제수단이 유효한지 확인해주세요.</p>
				<p>예약 결제 이후, 결제 정보를 변경하려면 마이페이지 > 참여 내역 상세에서 결제 정보를 변경해주세요.</p>
				<p>지금 결제를 한 경우에도 프로젝트가 종료되기 전까지 언제든 결제를 취소할 수 있어요.</p>
			</div>
			
			<div class="payAgree">
			    <h4>약관 동의</h4>
			    <div class="agreeAll">
			        <input type="checkbox" id="agreeAll" required>
			        <label for="agreeAll">결제 진행 필수 동의</label>
			    </div>
			    <hr>
			    <div class="agree">
			        <input type="checkbox" id="agree1" required>
			        <label for="agree1">구매조건, 결제 진행 및 결제 대행 서비스 동의</label>
			    </div>
			    <div class="agree">
			        <input type="checkbox" id="agree2" required>
			        <label for="agree2">개인정보 제3자 제공 동의</label>
			    </div>
			</div>
			
		</div>
		
		<button type="button" class="buyBtn" onclick="two()">결제하기</button>

	</div>

</body>
</html>