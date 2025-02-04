<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/main.css"
	type="text/css">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const categories = document.querySelectorAll(".categories div");
    const subCategoryContainer = document.createElement("div");
    subCategoryContainer.classList.add("sub-categories");
    subCategoryContainer.style.display = "none";
    document.querySelector(".hr").prepend(subCategoryContainer);
    
    const subCategories = {
        "가전": ["TV", "냉장고", "세탁기", "에어컨", "청소기/건조기", "공기청정기", "전자레인지", "안마물품", "가습기"],
        "패션": ["남성 의류", "여성 의류", "신발", "가방"],
        "뷰티": ["스킨케어", "메이크업", "향수", "헤어"],
        "홈▪리빙": ["가구", "침구", "주방용품", "데코"],
        "푸드": ["과자", "음료", "냉동식품", "건강식품"],
        "도서": ["소설", "에세이", "자기계발", "만화"],
        "캐릭터▪굿즈": ["피규어", "문구", "의류", "악세서리"],
        "문화": ["공연 티켓", "전시", "음악", "영화"],
        "반려동물": ["사료", "용품", "장난감", "건강 관리"]
    };

    categories.forEach(category => {
        category.addEventListener("click", function (event) {
            let categoryName = event.currentTarget.textContent.trim();
            
            if (subCategories[categoryName]) {
                subCategoryContainer.innerHTML = '';
                const heading = document.createElement("h4");
                heading.textContent = `${categoryName} 상세 카테고리`;
                subCategoryContainer.appendChild(heading);
                
                const list = document.createElement("ul");
                subCategories[categoryName].forEach(sub => {
                    const li = document.createElement("li");
                    li.textContent = sub;
                    list.appendChild(li);
                });
                subCategoryContainer.appendChild(list);

                subCategoryContainer.style.display = subCategoryContainer.style.display === "none" ? "block" : "none";
            }
        });
    });
});
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="search-bar">
			<input type="text" placeholder=" 검색어를 입력해주세요!">
		</div>

		<div class="categories">
			<div>
				<img src="/dist/images/main/category/a.png">
				<p>가전</p>
			</div>
			<div>
				<img src="/dist/images/main/category/b.png">
				<p>패션</p>
			</div>
			<div>
				<img src="/dist/images/main/category/c.png">
				<p>뷰티</p>
			</div>
			<div>
				<img src="/dist/images/main/category/d.png">
				<p>홈▪리빙</p>
			</div>
			<div>
				<img src="/dist/images/main/category/e.png">
				<p>푸드</p>
			</div>
			<div>
				<img src="/dist/images/main/category/f.png">
				<p>도서</p>
			</div>
			<div>
				<img src="/dist/images/main/category/g.png">
				<p>캐릭터▪굿즈</p>
			</div>
			<div>
				<img src="/dist/images/main/category/h.png">
				<p>문화</p>
			</div>
			<div>
				<img src="/dist/images/main/category/i.png">
				<p>반려동물</p>
			</div>
		</div>

		<hr class="hr">

		<div class="body-container">
			<!-- 광고이미지, 신규프젝, 실시간랭킹 -->
			<div class="row">
				<div class="col-8">
					<div id="carouselExampleFade" class="carousel slide carousel-fade"
						data-bs-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="/dist/images/main/ad1.jpg" class="d-block w-100"
									style="width: 80%; height: 400px; margin-top: 30px;" alt="AD">
							</div>
							<div class="carousel-item">
								<img src="/dist/images/main/ad2.jpg" class="d-block w-100"
									style="width: 80%; height: 400px; margin-top: 30px;" alt="AD">
							</div>
							<div class="carousel-item">
								<img src="/dist/images/main/ad3.png" class="d-block w-100"
									style="width: 80%; height: 400px; margin-top: 30px;" alt="AD">
							</div>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleFade" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleFade" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
					<br> <br> <br>
					<div class="new-project">
						<h3>신규 프로젝트</h3>
						<div class="row">
							<div class="col-4 newP">
								<img src="/dist/images/main/p.jpg">
								<div class="pundingBtn">
									<p class="reserve">예약구매</p>
								</div>
								<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
							</div>
							<div class="col-4 newP">
								<img src="/dist/images/main/p.jpg">
								<div class="pundingBtn">
									<p>펀딩</p>
								</div>
								<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
							</div>
							<div class="col-4 newP">
								<img src="/dist/images/main/p.jpg">
								<div class="pundingBtn">
									<p>펀딩</p>
								</div>
								<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
							</div>
							<div class="col-4 newP">
								<img src="/dist/images/main/p.jpg">
								<div class="pundingBtn">
									<p>펀딩</p>
								</div>
								<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
							</div>
							<div class="col-4 newP">
								<img src="/dist/images/main/p.jpg">
								<div class="pundingBtn">
									<p>펀딩</p>
								</div>
								<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
							</div>
							<div class="col-4 newP">
								<img src="/dist/images/main/p.jpg">
								<div class="pundingBtn">
									<p>펀딩</p>
								</div>
								<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
							</div>
						</div>
					</div>
				</div>

				<div class="col-4">
					<div class="lanking-bar">
						<h3>실시간 랭킹</h3>
						<div class="col">
							<div class="row">
								<div class="col-7">
									<strong>1</strong> &nbsp;&nbsp;&nbsp;[발렌타인 전 도착!] 용량 두 배!, 더
									뚱뚱해진 '오예스 보조배터리'
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-7">
									<strong>2</strong> &nbsp;&nbsp;&nbsp;매일 한 잔으로 어깨 깡패되는 새해 필수템
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-7">
									<strong>3</strong> &nbsp;&nbsp;&nbsp;매일 한 잔으로 어깨 깡패되는 새해 필수템
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-7">
									<strong>4</strong> &nbsp;&nbsp;&nbsp;매일 한 잔으로 어깨 깡패되는 새해 필수템
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-7">
									<strong>5</strong> &nbsp;&nbsp;&nbsp;매일 한 잔으로 어깨 깡패되는 새해 필수템
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
						</div>

					</div>
					<div class="special">
						<img src="/dist/images/main/special.png">
						<img src="/dist/images/main/special.png">
					</div>
				</div>
			</div>

			<div class="localstorage-project">
				<h3>최근 본 프로젝트</h3>
				<div class="row">
					<div class="row">
						<div class="col-3 popularP">
							<img src="/dist/images/main/p.jpg">
							<div class="pundingBtn">
								<p>펀딩</p>
								<div class="goal">
									<p>30,012% 달성
								</div>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-3 popularP">
							<img src="/dist/images/main/p.jpg">
							<div class="pundingBtn">
								<p>펀딩</p>
								<div class="goal">
									<p>30,012% 달성
								</div>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-3 popularP">
							<img src="/dist/images/main/p.jpg">
							<div class="pundingBtn">
								<p>펀딩</p>
								<div class="goal">
									<p>30,012% 달성
								</div>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-3 popularP">
							<img src="/dist/images/main/p.jpg">
							<div class="pundingBtn">
								<p>펀딩</p>
								<div class="goal">
									<p>30,012% 달성
								</div>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
					</div>
				</div>
			</div>

			<div class="popular-project">
				<h3>인기 프로젝트</h3>
				<div class="row">
					<div class="col-3 popularP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 popularP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 popularP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 popularP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
				</div>
			</div>


			<div class="deadline-project">
				<h3>마감임박! 마지막 기회</h3>
				<h5 style="font-size: 22px;">
					<strong style="color: #ED2323;">06:15:16 </strong>남았어요
				</h5>
				<div class="row">
					<div class="col-3 deadlineP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 deadlineP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 deadlineP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 deadlineP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
				</div>
			</div>

			<div class="release-project">
				<h3>공개예정 프로젝트</h3>
				<div class="row">
					<div class="col-3 releaseP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 releaseP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 releaseP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 releaseP">
						<img src="/dist/images/main/p.jpg">
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
				</div>
			</div>

			<div class="pundingImg">
				<img src="/dist/images/main/punding.png">
			</div>

		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>