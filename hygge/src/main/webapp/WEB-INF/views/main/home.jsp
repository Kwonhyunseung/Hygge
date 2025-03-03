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
    // 카테고리 및 서브 카테고리 컨테이너 설정
    const categories = document.querySelectorAll(".categories div");
    const subCategoryContainer = document.createElement("div");
    subCategoryContainer.classList.add("sub-categories");

    // 서브 카테고리 컨테이너 스타일
	subCategoryContainer.style.display = "none";
	subCategoryContainer.style.position = "absolute";
	subCategoryContainer.style.width = "100%";
	subCategoryContainer.style.maxWidth = "1300px";
	subCategoryContainer.style.backgroundColor = "#f7f7f7";
	subCategoryContainer.style.padding = "22px";
	subCategoryContainer.style.zIndex = "10";
	subCategoryContainer.style.minHeight = "150px";
	subCategoryContainer.style.left = "50%";
	subCategoryContainer.style.transform = "translateX(-50%)";
	
	subCategoryContainer.style.borderRadius = "5px";
	subCategoryContainer.style.boxShadow = "rgba(50, 50, 93, 0.25) 0px 13px 27px -5px, rgba(0, 0, 0, 0.3) 0px 8px 16px -8px";
	subCategoryContainer.style.borderTop = "1px solid rgba(255, 255, 255, 0.5)";
	subCategoryContainer.style.borderLeft = "1px solid rgba(255, 255, 255, 0.5)";
	subCategoryContainer.style.backdropFilter = "blur(5px)";
	subCategoryContainer.style.transition = "opacity 0.3s ease, transform 0.3s ease";
	subCategoryContainer.style.opacity = "0";

    // hr 아래에 추가
    const hrElement = document.querySelector(".hr");
    hrElement.insertAdjacentElement("afterend", subCategoryContainer);

    // 서브 카테고리 데이터 설정
    const subCategories = {};
    
    <c:forEach var="parentCategory" items="${parentCategories}">
        subCategories["${parentCategory.name}"] = [];
        
        <c:forEach var="subCategory" items="${subCategoriesMap[parentCategory.name]}">
            subCategories["${parentCategory.name}"].push("${subCategory.name}");
        </c:forEach>
    </c:forEach>

    let activeCategory = null;
    let isOverSubCategory = false;
    let hideTimeout = null;

    function showSubCategory(categoryName) {
        if (subCategories[categoryName] && subCategories[categoryName].length > 0) {
            // 이전 타임아웃 취소
            if (hideTimeout) {
                clearTimeout(hideTimeout);
                hideTimeout = null;
            }

            subCategoryContainer.innerHTML = '';
            
            // 제목 추가 - 카테고리명 + "전체"
            const heading = document.createElement("h4");
            heading.innerText = categoryName + " 전체";
            heading.style.marginBottom = "30px";
            heading.style.fontSize = "20px";
            subCategoryContainer.appendChild(heading);
            
            // 하위 카테고리 목록 생성
            const list = document.createElement("ul");
            list.style.display = "flex";
            list.style.flexWrap = "wrap";
            list.style.gap = "10px";
            list.style.padding = "0";
            list.style.margin = "0";
            list.style.listStyle = "none";

            // 각 하위 카테고리 항목 추가
            subCategories[categoryName].forEach(subCategoryName => {
                const li = document.createElement("li");
                li.innerText = subCategoryName;
                li.style.borderRadius = "5px";
                li.style.fontSize = "20px";
                li.style.textAlign = "center";
                li.style.textDecoration = "none";
                li.style.padding = "20px";
                li.style.marginBottom = "10px";
                li.style.cursor = "pointer";
                
                li.addEventListener("mouseenter", function() {
                    this.style.color = "green";
                });
                
                li.addEventListener("mouseleave", function() {
                    this.style.color = "#000";
                });
                
                list.appendChild(li);
            });
            
            subCategoryContainer.appendChild(list);
            
            // 상세 카테고리 보이기
            subCategoryContainer.style.display = "block";
            setTimeout(() => {
                subCategoryContainer.style.opacity = "1";
            }, 10);
            
            activeCategory = categoryName;
        }
    }

    // 서브 카테고리 숨김
    function scheduleHideSubCategory() {
        if (hideTimeout) {
            clearTimeout(hideTimeout);
        }
        
        hideTimeout = setTimeout(() => {
            if (!isOverSubCategory && !activeCategory) {
                subCategoryContainer.style.opacity = "0";
                setTimeout(() => {
                    if (subCategoryContainer.style.opacity === "0") {
                        subCategoryContainer.style.display = "none";
                    }
                }, 200);
            }
        }, 150);
    }

    // 카테고리 마우스 이벤트
    categories.forEach(category => {
        category.addEventListener("mouseenter", function() {
            const categoryName = this.querySelector("p").textContent.trim();
            activeCategory = categoryName;
            showSubCategory(categoryName);
        });

        category.addEventListener("mouseleave", function() {
            activeCategory = null;
            scheduleHideSubCategory();
        });
    });

    // 서브 카테고리 마우스 이벤트
    subCategoryContainer.addEventListener("mouseenter", function() {
        isOverSubCategory = true;
        if (hideTimeout) {
            clearTimeout(hideTimeout);
            hideTimeout = null;
        }
    });

    subCategoryContainer.addEventListener("mouseleave", function() {
        isOverSubCategory = false;
        scheduleHideSubCategory();
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
			<c:forEach var="category" items="${parentCategories}">
				<div data-categoryNum="${category.category_num}">
					<img src="/dist/images/main/category/${category.category_num}.png">
					<p>${category.name}</p>
				</div>
			</c:forEach>
		</div>

		<hr class="hr">

		<div class="body-container">
			<!-- 광고이미지, 신규프젝, 실시간랭킹 -->
			<div class="row">
				<div class="col-8">
					<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="/dist/images/main/ad1.jpg" class="d-block w-100" style="width: 80%; height: 400px; margin-top: 30px;">
							</div>
							<div class="carousel-item">
								<img src="/dist/images/main/ad2.jpg" class="d-block w-100" style="width: 80%; height: 400px; margin-top: 30px;">
							</div>
							<div class="carousel-item">
								<img src="/dist/images/main/ad3.png" class="d-block w-100" style="width: 80%; height: 400px; margin-top: 30px;">
							</div>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
					<br> <br> <br>
					<div class="row new-project">
						<h3>신규 프로젝트</h3>
						<div class="col-4 newP">
							<div class="image-newP">
								<img src="/dist/images/main/p.jpg"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p class="reserve">예약구매</p>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-4 newP">
							<div class="image-newP">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p>펀딩</p>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-4 newP">
							<div class="image-newP">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p>펀딩</p>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-4 newP">
							<div class="image-newP">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p>펀딩</p>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-4 newP">
							<div class="image-newP">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p class="reserve">예약구매</p>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-4 newP">
							<div class="image-newP">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p class="reserve">예약구매</p>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
					</div>
				</div>

				<div class="col-4">
					<div class="lanking-bar">
						<h3>실시간 랭킹</h3>
						<div class="col">
							<div class="row">
								<div class="col-1">
									<strong>1</strong>
								</div>
								<div class="col-6">
									<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-1">
									<strong>2</strong>
								</div>
								<div class="col-6">
									<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-1">
									<strong>3</strong>
								</div>
								<div class="col-6">
									<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-1">
									<strong>4</strong>
								</div>
								<div class="col-6">
									<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col-1">
									<strong>5</strong>
								</div>
								<div class="col-6">
									<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
								</div>
								<div class="col lankImg">
									<img src="/dist/images/main/p.jpg">
								</div>
							</div>
						</div>
					</div>

					<div class="special">
						<img src="/dist/images/main/s1.png">
						<div id="carouselExampleFade" class="carousel slide carousel-fade"
							data-bs-ride="carousel">
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img src="/dist/images/main/s1.png" class="d-block w-100">
								</div>
								<div class="carousel-item">
									<img src="/dist/images/main/s2.png" class="d-block w-100">
								</div>
							</div>
						</div>
					</div>




				</div>
			</div>

			<div class="localstorage-project">
				<h3>최근 본 프로젝트</h3>
				<div class="row">
					<div class="row">
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p>펀딩</p>
								<div class="goal">
									<p>30,012% 달성
								</div>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
							<div class="pundingBtn">
								<p>펀딩</p>
								<div class="goal">
									<p>30,012% 달성
								</div>
							</div>
							<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
						</div>
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/p.jpg" alt="이미지"> <i
									class="bi bi-suit-heart"></i>
							</div>
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
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 popularP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 popularP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 popularP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
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
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 deadlineP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 deadlineP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 deadlineP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
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
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 releaseP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 releaseP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
						<div class="pundingBtn">
							<p>펀딩</p>
							<div class="goal">
								<p>30,012% 달성
							</div>
						</div>
						<p>[발렌타인 전 도착!] 용량 두 배!, 더 뚱뚱해진 '오예스 보조배터리'</p>
					</div>
					<div class="col-3 releaseP">
						<div class="image-container">
							<img src="/dist/images/main/p.jpg" alt="이미지"> <i
								class="bi bi-suit-heart"></i>
						</div>
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