<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYGGE결제창</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/buy/productChoice.css" type="text/css">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script type="text/javascript">
//숫자 포맷팅 함수
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(function() {
    // 페이지 로드 시 라디오 버튼 기본 선택
    $('#card').prop('checked', true);
    
    // 약관 동의 체크박스 연동
    $('#agreeAll').change(function() {
        const isChecked = $(this).is(':checked');
        $('#agree1, #agree2').prop('checked', isChecked);
    });
    
    $('#agree1, #agree2').change(function() {
        const allChecked = $('#agree1').is(':checked') && $('#agree2').is(':checked');
        $('#agreeAll').prop('checked', allChecked);
    });
    
    // 페이지 로드 시 우편번호 찾기 버튼 숨기기
    $('#postFind').hide();
    
    // 상품 금액과 배송비
    const productSum = ${product.sum};
    const deliveryFee = ${product.delivery_fee};
    
    // 쿠폰 선택 시 이벤트
    $('#couponSelect').change(function() {
        calculateTotalWithCoupon();
    });
    
    // 쿠폰 적용하여 총 금액 계산
    function calculateTotalWithCoupon() {
        const $selectedOption = $('#couponSelect option:selected');
        const couponNum = $selectedOption.val();
        const discountRate = parseFloat($selectedOption.data('rate') || 0);
        const maxDiscount = parseInt($selectedOption.data('discount') || 0);
        
        let discountAmount = 0;
        
        // 할인율이 있는 경우
        if (discountRate > 0) {
            discountAmount = Math.floor(productSum * (discountRate / 100));
            // 최대 할인 금액 제한이 있는 경우
            if (maxDiscount > 0 && discountAmount > maxDiscount) {
                discountAmount = maxDiscount;
            }
        } 
        else if (maxDiscount > 0) {
            discountAmount = maxDiscount;
        }
        
        if (discountAmount > productSum) {
            discountAmount = productSum;
        }
        
        // 최종 결제 금액 계산 (상품 금액 - 할인 금액 + 배송비)
        const finalAmount = productSum - discountAmount + deliveryFee;
        
        $('#couponDiscount').text(numberWithCommas(discountAmount) + '원');
        $('#totalPrice').text(numberWithCommas(finalAmount) + '원');
        
        // hidden 필드에 값 설정
        $('#selectedCouponNum').val(couponNum);
        $('#discountAmount').val(discountAmount);
        $('#finalPaymentAmount').val(finalAmount);
    }
    
    
    // 상품 구성 레이아웃 조정
    const detailItems = $('.detail-item').length;
    const detailsContainer = $('.product-details-container');
    const stockInfo = $('.stock');
    
    // 상품 구성이 3개 이하인 경우 처리
    if (detailItems <= 3) {
        detailsContainer.css({
            'max-height': 'none',
            'overflow-y': 'visible',
            'margin-bottom': '10px'
        });
        
        // 구분선 추가
        detailsContainer.after('<div class="stock-divider"></div>');
        
        // 클래스 추가
        stockInfo.addClass('stock-below');
    }
    else {
        const itemHeight = 45; // 각 항목의 높이 (픽셀)
        const visibleItems = 3; // 보이는 항목 수
        const height = (itemHeight * visibleItems) + 10; // 여유 추가
        
        detailsContainer.css({
            'max-height': height + 'px',
            'overflow-y': 'auto'
        });
        
        stockInfo.addClass('stock-inline');
    }
});

// 신규 배송지
function newAddr() {
    const $addrBtn = $('#addrBtn');
    const $receiver = $('#receiver');
    const $address = $('#address');
    const $detailAddr = $('#detailAddr');
    const $postCode = $('#postCode');
    const $postFind = $('#postFind');
    
    if($addrBtn.val() === "신규 배송지 입력") {
        $receiver.val('').removeAttr('readonly');
        $address.val('');
        $detailAddr.val('').removeAttr('readonly');
        $postCode.val('');
        $postFind.show(); // 우편번호 찾기 버튼 표시
        
        // 버튼 텍스트 변경
        $addrBtn.val("기본 배송지로 돌아가기");
    } else {
        // 원래 정보로 복원
        $receiver.val('${member.name}').attr('readonly', true);
        $address.val('${member.addr1}').attr('readonly', true);
        $detailAddr.val('${member.addr2}').attr('readonly', true);
        $postCode.val('${member.postCode}').attr('readonly', true);
        $postFind.hide(); // 우편번호 찾기 버튼 숨기기
        
        // 버튼 텍스트 복원
        $addrBtn.val("신규 배송지 입력");
    }
}

// 다음주소 API
function daumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
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

//결제 처리
function finalBuy() {
    if(!$('#agreeAll').is(':checked')) {
        alert('필수 약관에 동의해주세요.');
        return;
    }
    
    if(!$('input[name="payMethod"]:checked').val()) {
        alert('결제 수단을 선택해주세요.');
        return;
    }
    
    if(!$('#receiver').val().trim()) {
        alert('받는 사람 이름을 입력해주세요.');
        $('#receiver').focus();
        return;
    }
    
    if(!$('#address').val().trim() || !$('#postCode').val().trim()) {
        alert('주소를 입력해주세요.');
        if($('#postFind').is(':visible')) {
            $('#postFind').focus();
        }
        return;
    }
    
    // 폼 데이터 수집
    const paymentData = {
        product_num: ${product.product_num},
        amount: ${product.amount},
        sum: ${product.sum},
        couponNum: $('#selectedCouponNum').val(),
        discountAmount: $('#discountAmount').val(),
        finalAmount: $('#finalPaymentAmount').val(),
        deliveryFee: ${product.delivery_fee},
        receiver: $('#receiver').val().trim(),
        addr1: $('#address').val().trim(),
        addr2: $('#detailAddr').val().trim(),
        postCode: $('#postCode').val().trim(),
        request: $('#aInfo').val().trim(),
        pay_way: $('input[name="payMethod"]:checked').val() || '1'
    };
    
    // 결제 API 파라미터 설정
    let memberIdx = ${sessionScope.member.memberidx};
    let merchant_uid = 'ORDER_' + new Date().getTime();
    let amount = Number(paymentData.finalAmount); // 문자열을 숫자로 변환
    let pay_method = $('input[name="payMethod"]:checked').val() === '1' ? 'card' : 'trans';
    
    // 구매자 정보
    let buyer_email = '${member.email1}@${member.email2}';
    let buyer_name = '${member.name}';
    let buyer_tel = '${member.tel1}' + '${member.tel2}' + '${member.tel3}'.replace(/ /g, '');
    let buyer_addr = '${member.addr1} ${member.addr2}';
    let buyer_postcode = '${member.postCode}';
    
    // IMP 초기화
    var IMP = window.IMP;
    IMP.init("imp25337544");
    
    //
    console.log("결제 정보:", {
        pay_method: pay_method,
        merchant_uid: merchant_uid,
        name: '${product.title}',
        amount: amount,
        buyer_email: buyer_email,
        buyer_name: buyer_name,
        buyer_tel: buyer_tel,
        buyer_addr: buyer_addr,
        buyer_postcode: buyer_postcode
    });
 
    // 결제 요청
    IMP.request_pay({
    	channelKey: "channel-key-1f19b1f6-fa6e-400f-8745-355b6c86cb30",
        pay_method: pay_method,
        merchant_uid: merchant_uid,
        name: '${product.title}',
        amount: 10, // 실제 결제 금액
        buyer_email: buyer_email,
        buyer_name: buyer_name,
        buyer_tel: buyer_tel,
        buyer_addr: buyer_addr,
        buyer_postcode: buyer_postcode
    }, function(resp) {
        if(resp.success) {
            console.log("결제 성공:", resp);
            
            // 결제 정보 추가
            paymentData.imp_uid = resp.imp_uid;
            paymentData.merchant_uid = resp.merchant_uid;
            paymentData.paid_amount = resp.paid_amount;
            paymentData.pay_method = resp.pay_method;
            paymentData.pg_provider = resp.pg_provider;
            paymentData.paid_at = resp.paid_at;
            
            // 서버에 결제 정보 전송
            $.ajax({
                url: "${pageContext.request.contextPath}/buy/processPayment",
                type: "POST",
                data: paymentData,
                success: function(response) {
                    try {
                        if(typeof response === 'string') {
                            response = JSON.parse(response);
                        }
                        
                        if(response.success) {
                            alert('결제가 완료되었습니다.');
                            location.href = "${pageContext.request.contextPath}/buy/complete";
                        } else {
                            alert(response.message || '결제 처리 중 오류가 발생했습니다.');
                        }
                    } catch(e) {
                    }
                },
                error: function(xhr, status, error) {
                    console.error("결제 처리 오류:", error);
                    console.log("응답 내용:", xhr.responseText);
                }
            });
        } else {
            alert('결제에 실패했습니다: ' + resp.error_msg);
            console.log("결제 실패:", resp);
        }
    });
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
				<p>
					리워드<br>선택
				</p>
			</div>
			<div class="connecting-line" style="width: 63px;"></div>
			<div class="col-2 circle">
				<p>
					결제<br>예약
				</p>
			</div>
		</div>

		<h3>
			리워드 결제 <img
				src="${pageContext.request.contextPath}/dist/images/buy/2.png"
				alt="온라인 상점 아이콘">
		</h3>

		<div class="choicedProduct">

			<div class="row mainInfo">
				<div class="col-5 thumbnail">
					<img
						src="${pageContext.request.contextPath}/uploads/project/${product.thumbnail}">
				</div>
				<div class="col-7 productInfo">
					<h4>상품 정보</h4>
					<br>
					<div class="product-title-container">
						<div class="product-title">${product.title}</div>
						<div class="product-price">
							<fmt:formatNumber value="${product.price}" pattern="#,###" />
							원
						</div>
					</div>
					<div class="product-details-container">
						<c:forEach var="details" items="${fn:split(product.detail, '💚')}">
							<c:if test="${!empty details}">
								<p class="detail-item">💚${details}</p>
							</c:if>
						</c:forEach>
					</div>
					<p class="stock">
						구매 수량 <span class="stock">${product.amount}개</span>
					</p>
				</div>
			</div>

			<div class="supporterInfo">
				<h4>서포터 정보</h4>
				<p class="name">
					이름 <span class="name">${member.name}</span>
				</p>
				<p class="email">
					이메일 <span class="email">${member.email1}@${member.email2}</span>
				</p>
				<p class="phone">
					핸드폰 번호 <span class="phone">${member.tel1}-${member.tel2}-${member.tel3}</span>
				</p>
			</div>

			<div class="deliveryInfo">
				<h4>배송 정보</h4>
				<!-- 디폴트는 자동으로 정보 기입 -->
				<!-- 신규배송지 누를경우, readonly풀리면서 받는사람, 주소 새로 입력할거임-->
				<input type="button" id="addrBtn" value="신규 배송지 입력"
					onclick="newAddr();"> <input type="text" id="receiver"
					value="${member.name}" placeholder="받는 사람" readonly>
				<div>
					<input type="text" id="address" value="${member.addr1}"
						placeholder="주소" readonly> <input type="text"
						id="postCode" value="${member.postCode}" placeholder="우편번호"
						readonly> <input type="button" onclick="daumPostcode();"
						value="주소 찾기" id="postFind">
				</div>
				<input type="text" id="detailAddr" value="${member.addr2}"
					placeholder="상세주소를 입력해주세요" readonly> <input type="text"
					id="aInfo" placeholder="주문 요청 사항을 입력해주세요(선택)">
			</div>


			<div class="coupon">
				<h4>쿠폰</h4>
				<c:choose>
					<c:when test="${empty coupons}">
						<div class="no-coupon-message">
							<i class="bi bi-ticket-perforated"></i> 사용 가능한 쿠폰이 없습니다.
						</div>
					</c:when>
					<c:otherwise>
						<select id="couponSelect" class="couponSelect">
							<option value="0" data-discount="0" data-rate="0">쿠폰을
								선택해주세요</option>
							<c:forEach var="coupon" items="${coupons}">
								<option value="${coupon.num}" data-discount="${coupon.discount}"
									data-rate="${coupon.discount_Rate}">${coupon.title}
									<c:if test="${coupon.discount_Rate > 0}">
		                                (${coupon.discount_Rate}% 할인
		                                <c:if test="${coupon.discount > 0}">
		                                    , 최대 <fmt:formatNumber
												value="${coupon.discount}" pattern="#,###" />원
		                                </c:if>)
		                            </c:if>
									<c:if
										test="${coupon.discount_Rate == 0 && coupon.discount > 0}">
		                                (<fmt:formatNumber
											value="${coupon.discount}" pattern="#,###" />원 정액 할인)
		                            </c:if> - ~
									<fmt:formatDate value="${coupon.exp_date}" pattern="yyyy-MM-dd" />
								</option>
							</c:forEach>
							<option value="0" data-discount="0" data-rate="0">쿠폰 선택
								안함</option>
						</select>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="col paymentMethod">
				<h4>
					결제 수단 <span class="required-mark">*</span>
				</h4>
				<div class="payment-methods">
					<div class="payment-method-item">
						<input id="card" name="payMethod" type="radio" value="1" checked>
						<label for="card">신용카드 / 체크카드</label>
					</div>
					<!-- 다른 결제 수단? -->
					<!-- <div class="payment-method-item">
			            <input id="cash" name="payMethod" type="radio" value="2">
			            <label for="cash">계좌이체</label>
			        </div> -->
				</div>
			</div>

			<div class="finalPayment">
				<h4>결제 금액</h4>
				<p class="productPrice">
					리워드 금액 <span class="productPrice"><fmt:formatNumber
							value="${product.sum}" pattern="#,###" />원</span>
				</p>
				<p class="couponPrice">
					쿠폰 금액 <span class="couponPrice" id="couponDiscount">0원</span>
				</p>
				<p class="deliveryFee">
					배송비 <span class="deliveryFee"><fmt:formatNumber
							value="${product.delivery_fee}" pattern="#,###" />원</span>
				</p>
				<hr>
				<p class="totalPrice">
					총 결제 금액 <span class="totalPrice" id="totalPrice"><fmt:formatNumber
							value="${product.sum + product.delivery_fee}" pattern="#,###" />원</span>
				</p>
				<!-- 실제 form 제출 시 사용할 hidden 필드 -->
				<input type="hidden" id="selectedCouponNum" name="couponNum"
					value="0"> <input type="hidden" id="discountAmount"
					name="discountAmount" value="0"> <input type="hidden"
					id="finalPaymentAmount" name="finalPaymentAmount"
					value="${product.sum + product.delivery_fee}">
			</div>

			<div class="payNote">
				<h4>결제 유의사항</h4>
				<p>예약 결제의 경우 결제 실행일에 결제자 귀책사유(한도초과, 이용정지 등)로 인하여 결제가 실패할 수 있으니,
					결제수단이 유효한지 확인해주세요.</p>
				<p>결제 정보를 변경하려면 마이페이지 > 참여 내역 상세에서 결제 정보를 변경해주세요.</p>
				<p>지금 결제를 한 경우에도 프로젝트가 종료되기 전까지 언제든 결제를 취소할 수 있어요.</p>
			</div>

			<div class="payAgree">
				<h4>
					약관 동의 <span class="required-mark">*</span>
				</h4>
				<div class="agreeAll">
					<input type="checkbox" id="agreeAll" required> <label
						for="agreeAll">결제 진행 필수 동의</label>
				</div>
				<hr>
				<div class="agree">
					<input type="checkbox" id="agree1" required> <label
						for="agree1">구매조건, 결제 진행 및 결제 대행 서비스 동의</label>
				</div>
				<div class="agree">
					<input type="checkbox" id="agree2" required> <label
						for="agree2">개인정보 제3자 제공 동의</label>
				</div>
			</div>

		</div>

		<button type="button" class="buyBtn" onclick="finalBuy()">결제하기</button>

	</div>

</body>
</html>