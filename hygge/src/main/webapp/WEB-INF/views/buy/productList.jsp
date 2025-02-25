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

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/buy/productList.css" type="text/css">

<style type="text/css">
.buy-now-btn {
    display: block;
    width: 100%;
    padding: 10px;
    margin-top: 15px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

.buy-now-btn:hover {
    background-color: #0056b3;
}
</style>

<script type="text/javascript">
function stepOne() {
    const selectedProduct = $(".selected-product-info");
    if (selectedProduct.length === 0) {
        alert("상품을 선택해주세요.");
        return;
    }
    
    const productNum = selectedProduct.closest(".select-product").data("product-num");
    $("#selectedProductNum").val(productNum);
    $("#productForm").submit();
}


// AJAX 정의
function ajaxFun(url, method, formData, dataType, fn, file = false) {
    const settings = {
        type: method,
        data: formData,
        dataType: dataType,
        success: function(data) {
            fn(data);
        },
        beforeSend: function(jqXHR) {
        },
        complete: function() {
        },
        error: function(jqXHR) {
            console.log(jqXHR.responseText);
        }
    };

    if(file) {
        settings.processData = false;
        settings.contentType = false;
    }

    $.ajax(url, settings);
}

//수량 선택
$(function(){
    $(".select-product").click(function(e){
        const productNum = $(this).data("product-num");
        // 다른 상품들의 수량 선택기 닫기
        $(".quantity-selector").not($(this).find(".quantity-selector")).hide();
        
        // 현재 클릭한 상품의 수량 선택기
        const $quantitySelector = $(this).find(".quantity-selector");
        
        // 이미 내용이 있다면 보여주기만 하고 return
        if ($quantitySelector.html().trim() !== '') {
            $quantitySelector.show();
            return;
        }
        
        // 현재 상품 정보를 DOM에서 직접 가져오기
        const $productInfo = $(this).find('.product-info');
        const title = $productInfo.find('.title').contents().filter(function() {
            return this.nodeType === 3; // Text 노드만 필터링
        }).text().trim();
        
        const price = parseInt($productInfo.find('.price').text().replace(/[^0-9]/g, ''));
        const deliveryFee = parseInt($productInfo.find('.deliveryFee').text().replace(/[^0-9]/g, ''));
        const stock = parseInt($productInfo.find('.stock').text().replace(/[^0-9]/g, ''));
        
        let out = "";
        out += '<div class="selected-product-info">';
        out += '    <span class="close-btn"><i class="bi bi-x-square"></i></span>';
        out += '    <h4>' + title + '</h4>';
        out += '    <div class="quantity-control">';
        out += '        <i class="bi bi-dash-circle minus"></i>';
        out += '        <input type="text" name="quantity" value="1" readonly data-price="' + price + '" data-delivery-fee="' + deliveryFee + '" data-stock="' + stock + '">';
        out += '        <i class="bi bi-plus-circle plus"></i>';
        out += '    </div>';
        out += '    <div class="price-info">';
        out += '        <p class="base-price">가격: ' + numberComma(price) + '원</p>';
        out += '        <p class="delivery-fee">배송비: ' + numberComma(deliveryFee) + '원</p>';
        out += '        <p class="total">총 금액: ' + numberComma(price + deliveryFee) + '원</p>';
        out += '    </div>';
        out += '    <button type="button" class="buy-now-btn" onclick="buyNow(' + productNum + ')">선택하기</button>';
        out += '</div>';
        
        $quantitySelector.html(out).show();
        
        // 수량 증가
        $quantitySelector.find('.bi-plus-circle').click(function(e) {
            e.stopPropagation();
            const $input = $(this).siblings('input[name="quantity"]');
            const currentVal = parseInt($input.val());
            const maxStock = parseInt($input.data('stock'));
            
            if (currentVal < maxStock) {
                $input.val(currentVal + 1);
                calculateTotal($input);
            }
        });
        
        // 수량 감소
        $quantitySelector.find('.bi-dash-circle').click(function(e) {
            e.stopPropagation();
            const $input = $(this).siblings('input[name="quantity"]');
            const currentVal = parseInt($input.val());
            
            if (currentVal > 1) {
                $input.val(currentVal - 1);
                calculateTotal($input);
            }
        });
    });

    $(document).on('click', '.close-btn', function(e) {
        e.stopPropagation();
        $(this).closest('.quantity-selector').hide();
    });
});

//총 금액 계산 함수
function calculateTotal($input) {
    const quantity = parseInt($input.val());
    const price = parseInt($input.data('price'));
    const deliveryFee = parseInt($input.data('delivery-fee')); // 수정된 부분
    const total = (price * quantity) + deliveryFee;
    
    const $priceInfo = $input.closest('.selected-product-info').find('.price-info');
    $priceInfo.find('.total').text('총 금액: ' + numberComma(total) + '원');
}

/* function buyNow(productNum) {
    const $quantityInput = $(`.select-product[data-product-num="${productNum}"]`).find('input[name="quantity"]');
    let quantity = 1; // 기본값 설정
    
    // 수량 입력란이 존재하고 유효한 값인 경우에만 해당 값 사용
    if ($quantityInput.length > 0) {
        const inputValue = parseInt($quantityInput.val());
        if (!isNaN(inputValue) && inputValue > 0) {
            quantity = inputValue;
        }
    }
    
    // 수량 정보도 함께 전송하기 위한 폼 생성
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '${pageContext.request.contextPath}/buy/productChoice';
    
    const productNumInput = document.createElement('input');
    productNumInput.type = 'hidden';
    productNumInput.name = 'product_num';
    productNumInput.value = productNum;
    
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = quantity;
    
    form.appendChild(productNumInput);
    form.appendChild(quantityInput);
    document.body.appendChild(form);
    form.submit();
} */
function buyNow(productNum) {
    console.log("buyNow 함수 호출됨: 상품번호 = " + productNum);
    
    // 수량 입력란 찾기
    const $quantityInput = $(`.select-product[data-product-num="${productNum}"]`).find('input[name="quantity"]');
    console.log("수량 입력란 찾음:", $quantityInput.length > 0 ? "성공" : "실패");
    
    let quantity = 1; // 기본값 설정
    
    // 수량 입력란이 존재하고 유효한 값인 경우에만 해당 값 사용
    if ($quantityInput.length > 0) {
        const inputValue = parseInt($quantityInput.val());
        console.log("입력된 수량 값:", $quantityInput.val(), "파싱된 값:", inputValue);
        
        if (!isNaN(inputValue) && inputValue > 0) {
            quantity = inputValue;
        }
    }
    
    console.log("최종 수량:", quantity);
    
    // 수량 정보도 함께 전송하기 위한 폼 생성
    try {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/buy/productChoice';
        
        const productNumInput = document.createElement('input');
        productNumInput.type = 'hidden';
        productNumInput.name = 'product_num';
        productNumInput.value = productNum;
        
        const quantityInput = document.createElement('input');
        quantityInput.type = 'hidden';
        quantityInput.name = 'quantity'; // 'quantity'로 이름 유지
        quantityInput.value = quantity;
        
        form.appendChild(productNumInput);
        form.appendChild(quantityInput);
        
        console.log("폼 생성 완료: product_num =", productNum, "quantity =", quantity);
        
        document.body.appendChild(form);
        form.submit();
    } catch (e) {
        console.error("폼 생성 및 제출 중 오류 발생:", e);
        alert("오류가 발생했습니다: " + e.message);
    }
}

// 숫자 콤마 포맷팅
function numberComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
			리워드 선택
			<img src="${pageContext.request.contextPath}/dist/images/buy/1.png" alt="온라인 상점 아이콘">
		</h3>
		
		<form id="productForm" method="post" action="${pageContext.request.contextPath}/buy/productChoice">
		<input type="hidden" name="product_num" id="selectedProductNum">
		
		<div class="listProduct" style="margin-bottom: 100px;">
		    <c:forEach var="product" items="${list}">
		        <div class="select-product" data-product-num="${product.product_num}">
		            <div class="product-info">
		                <p class="price">
		                    <fmt:formatNumber value="${product.price}" pattern="#,###"/>원
		                </p>
		                <p class="title">
		                    ${product.title}
		                    <span class="stock">${product.stock}개 남음</span>
		                    <span class="origin">원산지 : ${product.origin}</span>
		                </p>
		                <p class="content">
		                    <c:forEach var="details" items="${fn:split(product.detail, '💚')}">
		                        <c:if test="${!empty details}">
		                            <p>💚${details}</p>
		                        </c:if>
		                    </c:forEach>
		                </p>
		                <p class="deliveryDay">배송 일정: ${product.delivery_info}</p>
		                <p class="deliveryFee">
		                    <i class="bi bi-truck"></i> 
		                    배송비 <fmt:formatNumber value="${product.delivery_fee}" pattern="#,###"/>원
		                </p>
		            </div>
		            <!-- 각 상품마다 수량 선택 - AJAX처리 -->
		            <div class="quantity-selector"></div>
		        </div>
		        <hr>
		    </c:forEach>
		</div>
		

	</form>
	
	</div>

</body>
</html>