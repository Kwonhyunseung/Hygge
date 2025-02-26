<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style type="text/css">
h4 {
	font-size: 27px;
	font-weight: bold;
	margin-bottom: 60px;
}

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
.rating .bi-star-fill {
	color: #FCCB38;
	font-size: 33px;
}
.avg { font-size: 25px; }
.starAvg { font-size: 40px; }

.user-profile { padding: 12px 0; display: flex; flex-direction: row; justify-content: space-between; }
.user-profile img {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	border: 1px solid #E3E3E3;
}
.uProfile {
	font-size: 20px;
	font-weight: bold;
	margin-left: 7px;
}

.picture {
    border-radius: 5px;
}
.picture img {
    width: 220px;
    height: 150px;
    border-radius: 10px;
}

.review-content {
	border: 1px solid #C8C8C8;
	border-radius: 7px;
	padding: 10px;
	font-size: 16px;
}

.regDate-like {
	font-size: 15px;
	padding: 10px 15px;
}

.user-rating {
	margin: 15px 0px;
}

.user-rating .bi {
	color: #FCCB38;
}

/* 후기 좋아요 아이콘
.bi-hearts {
	margin-left: 470px;
	margin-right: 7px;
	cursor: pointer;
}
.bi-hearts:hover {
	color: red;
}
*/

/* 페이징 처리 */
.paging {
	margin: 150px 0;
}
</style>

<h4></h4>

<div class="content">
	<c:if test="${not empty list}">
	<div class="rating">
		<h6>상품 만족도</h6>
		<p>
			<i class="bi bi-star-fill"></i>
			<span class="avg"><strong class="starAvg">${gradeAvg}</strong> / 5.0</span>
		</p>
	</div>
	
	<hr style="margin: 80px 0;">
	<c:forEach var="dto" items="${list}">
		<div class="userReview" data-num="${dto.review_num}">
			<div class="user-profile">
				<div>
					<c:choose>
						<c:when test="${not empty dto.profile_img}">
							<img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_img}">
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/dist/images/person.png">
						</c:otherwise>
					</c:choose>
					<span class="uProfile">${dto.nickName}</span>
				</div>
				<div>
					<div class="regDate-like">
						<p>
							작성일 | ${dto.reg_date}
							<!-- <span><i class="bi bi-hearts"></i>50</span> -->
						</p>
					</div>
				</div>
			</div>	
			<div class="row picture">
				<c:forEach var="img" items="${dto.sfileName}">
					<img class="col-4" src="${pageContext.request.contextPath}/uploads/review/${img}">
				</c:forEach>
			</div>
			<div class="user-rating">
				<c:choose>
					<c:when test="${dto.grade == 5}">
						<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
					</c:when>
					<c:when test="${dto.grade == 4}">
						<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
					</c:when>
					<c:when test="${dto.grade == 3}">
						<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
					</c:when>
					<c:when test="${dto.grade == 2}">
						<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
					</c:when>
					<c:otherwise>
						<i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="review-content">
				<p>${dto.content}</p>
			</div>
		</div>
		<hr>
	</c:forEach>

	</c:if>
	<c:if test="${empty list}">
		<div>
			아직 등록된 후기가 없습니다.
		</div>
	</c:if>
	
</div>