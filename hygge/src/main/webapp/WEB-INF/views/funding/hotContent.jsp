<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/funding_list/list.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const categories = document.querySelectorAll(".categories div");
    const subCategoryContainer = document.createElement("div");
    subCategoryContainer.classList.add("sub-categories");

    // 스타일 수정
    subCategoryContainer.style.display = "none";
    subCategoryContainer.style.position = "absolute"; // 기존 내용 위에 덮기
    subCategoryContainer.style.width = "100%"; // 가로 전체 차지
    subCategoryContainer.style.maxWidth = "1300px"; // 가로 최대 1200px
    subCategoryContainer.style.backgroundColor = "#ffff"; // 배경색 변경
    subCategoryContainer.style.padding = "20px"; // 내부 패딩 증가
    subCategoryContainer.style.zIndex = "10"; // 제일 위로 배치
    subCategoryContainer.style.minHeight = "150px"; // 세로 길이 증가
    subCategoryContainer.style.left = "50%"; // 가운데 배치
    subCategoryContainer.style.transform = "translateX(-50%)"; // 정확히 가운데로 위치 조정

    // hr 아래에 추가
    const hrElement = document.querySelector(".hr");
    hrElement.insertAdjacentElement("afterend", subCategoryContainer);
    
    const mainContent = document.querySelector("main"); // 상세카테고리 아래 내용

    const subCategories = {
        "가전": ["TV", "냉장고", "세탁기", "에어컨", "청소기/건조기", "공기청정기", "전자레인지", "안마물품", "가습기"],
        "패션": ["의류", "신발", "가방", "언더웨어", "잡화"],
        "뷰티": ["스킨케어", "바디케어", "헤어케어"],
        "홈▪리빙": ["침실", "인테리어", "주방", "욕실"],
        "푸드": ["음료", "과자", "간편식", "밀키트", "비건", "건강식품"],
        "도서": ["소설", "에세이", "자기계발", "만화", "인문"],
        "캐릭터▪굿즈": ["피규어", "포스터", "연예인", "애니메이션"],
        "문화": ["공연 티켓", "전시", "콘서트", "음악", "영화"],
        "반려동물": ["사료", "용품", "장난감", "건강 관리"]
    };

    function showSubCategory(categoryName) {
        if (subCategories[categoryName]) {
            subCategoryContainer.innerHTML = ''; // 기존 내용 초기화
            
            const heading = document.createElement("h4");
            heading.textContent = `${categoryName} 상세 카테고리`;
            heading.style.marginBottom = "30px"; // 제목 아래 여백 추가
            heading.style.fontSize = "20px"; // 제목 글씨 크기 설정
            subCategoryContainer.appendChild(heading);

            const list = document.createElement("ul");
            list.style.display = "flex";
            list.style.flexWrap = "wrap";
            list.style.gap = "10px";

            subCategories[categoryName].forEach(sub => {
                const li = document.createElement("li");
                li.textContent = sub;
                li.style.borderRadius = "5px";
                li.style.fontSize = "20px"; // 항목 글씨 크기 (기존보다 크게)
                li.style.textAlign = "center"; // 글씨 가운데 정렬
                li.style.padding = "20px";
                li.style.marginBottom = "10px"; // 항목 간 간격 추가
                li.style.textDecoration = "none"; // 밑줄 제거
                list.appendChild(li);
                
             	// 호버시 색상 변경
                li.addEventListener("mouseenter", function () {
                    li.style.color = "green"; // 글씨 색상 변경
                });

                li.addEventListener("mouseleave", function () {
                    li.style.color = "#000"; // 기본 글씨 색상으로 복원
                });
            });
            subCategoryContainer.appendChild(list);

            // 상세 카테고리 보이기
            subCategoryContainer.style.display = "block";
        }
    }

    categories.forEach(category => {
        category.addEventListener("mouseenter", function () {
            let categoryName = category.querySelector("p").textContent.trim();
            showSubCategory(categoryName);
        });

        category.addEventListener("mouseleave", function () {
            // 카테고리에서 마우스를 빼면 상세 카테고리도 숨김
            setTimeout(() => {
                if (!subCategoryContainer.matches(':hover')) {
                    subCategoryContainer.style.display = "none";
                }
            }, 100);
        });
    });

    // 상세 카테고리 호버 시에도 숨기지 않음
    subCategoryContainer.addEventListener("mouseenter", function () {
        subCategoryContainer.style.display = "block";
    });

    // 상세 카테고리에서 마우스를 빼면 숨김
    subCategoryContainer.addEventListener("mouseleave", function () {
        subCategoryContainer.style.display = "none";
    });
});

// 좋아요버튼 hover 반응
window.addEventListener('load', function() {
	const likeicons = document.querySelectorAll('.like-btn i');
	for(let icon of likeicons) {
		if (icon.classList.contains('bi-heart')) {
			icon.addEventListener('mouseover', function() {
				icon.classList.remove('bi-heart');
				icon.classList.add('bi-heart-fill');
			});
			icon.addEventListener('mouseout', function() {
				icon.classList.remove('bi-heart-fill');
				icon.classList.add('bi-heart');
			});
		}
		if (icon.classList.contains('bi-heart-fill')) {
			icon.addEventListener('mouseover', function() {
				icon.classList.remove('bi-heart-fill');
				icon.classList.add('bi-heart');
			});
			icon.addEventListener('mouseout', function() {
				icon.classList.remove('bi-heart');
				icon.classList.add('bi-heart-fill');
			});
		}
	}

	// 좋아요 버튼 클릭
	for (let icon of likeicons) {
		const num = icon.closest('div').getAttribute('data-num'); // 좋아요 누른 프로젝트 번호
		let liked = icon.classList.contains('bi-heart-fill');
		icon.addEventListener('click', function() {
			let url = '${pageContext.request.contextPath}/funding/userLikeProject';
			const fn = function() {
				if(liked) {
					icon.classList.remove('bi-heart-fill');
					icon.classList.add('bi-heart');
				} else {
					icon.classList.add('bi-heart-fill');
					icon.classList.remove('bi-heart');
				}
			};
			ajaxRequest(url, 'post', {num: num, liked: liked}, 'json', fn);
		});
	}
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
		<div class="body-main">
			<div class="funding-list-container">
				<c:forEach var="dto" items="${list}">
					<div class="funding">
						<div class="funding-thumbnail">
							<a href="#">
								<img src="${pageContext.request.contextPath}/uploads/Funding/${dto.thumbnail}">
							</a>
							<div class="like-btn" data-num="${dto.num}">
								<i class="bi ${dto.userLiked ? 'bi-heart-fill' : 'bi-heart'}" style="color: red;"></i>
							</div>
						</div>
						<div class="funding-title-div">
							<a href="#">${dto.title}</a>
						</div>
						<div class="funding-detail-div">
							<span>${dto.project_info}</span>
						</div>
						<div class="funding-progress-div">
							<span class="progress-percentage">76%</span>
							<span class="progress-amount">760,000원</span>
							<div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="height: 0.7rem">
								<div class="progress-bar" style="width: 76%; background-color: #2F9D27;"></div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>