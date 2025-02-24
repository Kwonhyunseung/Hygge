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

// 수량 선택
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
        
        // AJAX로 상품 정보 가져오기
        let url = "${pageContext.request.contextPath}/buy/product/" + productNum;
        
        ajaxFun(url, "get", null, "json", function(res){
            const productInfo = {
                price: res.price,
                shippingFee: res.shipping_fee,
                stock: res.stock,
                title: res.title
            };
            
            let out = "";
            out += '<div class="selected-product-info">';
            out += '    <span class="close-btn"><i class="bi bi-x-square"></i></span>';
            out += '    <h4>' + productInfo.title + '</h4>';
            out += '    <div class="quantity-control">';
            out += '        <i class="bi bi-dash-circle minus"></i>';
            out += '        	<input type="text" name="quantity" value="1" readonly data-price="' + productInfo.price + '" data-shipping="' + productInfo.shippingFee + '" data-stock="' + productInfo.stock + '">';
            out += '        <i class="bi bi-plus-circle plus"></i>';
            out += '    </div>';
            out += '    <div class="price-info">';
            out += '        <p class="base-price">가격: ' + numberComma(productInfo.price) + '원</p>';
            out += '        <p class="shipping-fee">배송비: ' + numberComma(productInfo.shippingFee) + '원</p>';
            out += '        <p class="total">총 금액: ' + numberComma(productInfo.price + productInfo.shippingFee) + '원</p>';
            out += '    </div>';
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
    });

    $(document).on('click', '.close-btn', function(e) {
        e.stopPropagation();
        $(this).closest('.quantity-selector').hide();
    });
});

// 총 금액 계산 함수
function calculateTotal($input) {
    const quantity = parseInt($input.val());
    const price = parseInt($input.data('price'));
    const shippingFee = parseInt($input.data('shipping'));
    const total = (price * quantity) + shippingFee;
    
    const $priceInfo = $input.closest('.selected-product-info').find('.price-info');
    $priceInfo.find('.total').text('총 금액: ' + numberComma(total) + '원');
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
		
		<div class="listProduct">
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
		                    배송비 <fmt:formatNumber value="${product.shipping_fee}" pattern="#,###"/>원
		                </p>
		            </div>
		            <!-- 각 상품마다 수량 선택 - AJAX처리 -->
		            <div class="quantity-selector"></div>
		        </div>
		        <hr>
		    </c:forEach>
		</div>

		<button type="button" class="buyBtn" onclick="stepOne()">다음 단계</button>
	</form>
	
	</div>

</body>
</html>