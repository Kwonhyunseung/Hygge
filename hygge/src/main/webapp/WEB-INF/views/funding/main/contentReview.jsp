<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style type="text/css">
.content {
	max-width: 650px;
	font-size: 22px;
}

.rating {
    text-align: center; /* 전체 요소 가운데 정렬 */
}
.rating p {
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 세로 정렬 */
    gap: 15px;
}
h6 {
	font-size: 25px;
	font-weight: bold;
	margin-bottom: 15px;
}
.bi-star-fill {
	color: #FCCB38;
	font-size: 33px;
}
.avg { font-size: 25px; }
.starAvg { font-size: 40px; }

.user-profile { padding: 12px 0; }
.user-profile > img {
	width: 55px;
	height: 55px;
	border-radius: 50%;
	border: 1px solid #878787;
}
.uProfile {
	font-size: 20px;
	font-weight: bold;
	margin-left: 7px;
}

.picture {
    border-radius: 5px;
    margin-top: 20px;
}
.picture img {
    width: 220px;
    height: 150px;
    border-radius: 10px;
}

.review-content {
	border: 1px solid #C8C8C8;
	border-radius: 7px;
	padding: 20px;
	margin-top: 30px;
	font-size: 19px;
}

.regDate-like {
	font-size: 19px;
	padding: 10px 15px;
}
.bi-hearts {
	margin-left: 470px;
	margin-right: 7px;
	cursor: pointer;
}
.bi-hearts:hover {
	color: red;
}

/* 페이징 처리 */
.paging {
	margin: 150px 0;
}
</style>

<h4></h4>

<div class="content">
	<div class="rating">
		<h6>상품 만족도</h6>
		<p>
			<i class="bi bi-star-fill"></i>
			<span class="avg"><strong class="starAvg">4.7</strong> / 5.0</span>
		</p>
	</div>
	
	<hr style="margin: 80px 0;">
	
	<div class="userReview">
		<div class="user-profile">
			<img src="/dist/images/funding/main/review/profile.png">
			<span class="uProfile">난쟁이 선웅씨</span>
		</div>	
		<div class="row picture">
			<img class="col-4" src="/dist/images/funding/main/review/review1.jpg">
			<img class="col-4" src="/dist/images/funding/main/review/review1.jpg">
			<img class="col-4" src="/dist/images/funding/main/review/review1.jpg">
		</div>
		<div class="review-content">
			<p>냄새가 너무 좋아요!</p>
		</div>
		<div class="regDate-like">
			<p>
				2025.02.10
				<span><i class="bi bi-hearts"></i>50</span>
			</p>
		</div>
	</div>
	<hr style="margin: 60px 0;">
	<div class="userReview">
		<div class="user-profile">
			<img src="/dist/images/funding/main/review/profile.png">
			<span class="uProfile">꼼화 아가씨</span>
		</div>	
		<div class="row picture">
			<img class="col-4" src="/dist/images/funding/main/review/review1.jpg">
			<img class="col-4" src="/dist/images/funding/main/review/review1.jpg">
		</div>
		<div class="review-content">
			<p>냄새가 너무 좋아요!</p>
		</div>
		<div class="regDate-like">
			<p>
				2025.02.10
				<span><i class="bi bi-hearts"></i>50</span>
			</p>
		</div>
	</div>
	<hr style="margin: 60px 0;">
	<div class="userReview">
		<div class="user-profile">
			<img src="/dist/images/funding/main/review/profile.png">
			<span class="uProfile">닭찌 아저씨</span>
		</div>	
		<div class="review-content">
			<p>냄새가 너무 좋아요!</p>
		</div>
		<div class="regDate-like">
			<p>
				2025.02.10
				<span><i class="bi bi-hearts"></i>50</span>
			</p>
		</div>
	</div>
	<hr style="margin: 60px 0;">
	<div class="userReview">
		<div class="user-profile">
			<img src="/dist/images/funding/main/review/profile.png">
			<span class="uProfile">욕쟁이 할머니</span>
		</div>	
		<div class="row picture">
			<img class="col-4" src="/dist/images/funding/main/review/review1.jpg">
		</div>
		<div class="review-content">
			<p>냄새가 너무 좋아요!</p>
		</div>
		<div class="regDate-like">
			<p>
				2025.02.10
				<span><i class="bi bi-hearts" style="font-size: 25px;"></i>50</span>
			</p>
		</div>
	</div>
	
	<div class="paging" style="border: 1px solid #000; text-align: center;">
		<p>페이징 처리하시유</p>
	</div>
	
</div>