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

</script>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>
	<div class="search-bar">
		<input type="text" placeholder=" 검색어를 입력해주세요!" value="${keyword}">
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
			<div class="body-header">
				<div class="body-header-dataCount">
					<span class="dataCount-span">0</span>개의 프로젝트가 있습니다.
				</div>
				<div class="order-select-container">
					<select class="order-select">
						<option value="latest">최신순</option>
						<option value="popular">인기순</option>
						<option value="deadline">마감임박순</option>
					</select>
				</div>
			</div>
			<div class="funding-list-container"></div>
			<div class="sentinel" data-loading="false"></div>
		</div>
	</div>
</main>

<script type="text/javascript">
const listNode = document.querySelector('.funding-list-container');
const sentinelNode = document.querySelector('.sentinel');

function loadContent(page, order) {
	let url = '${pageContext.request.contextPath}/funding/${menu}/fundingList';
	let query = 'page=' + page + '&order=' + order;
	const fn = function(data) {
		addNewContent(data);
	};
	ajaxRequest(url, 'get', query, 'json', fn);
}

function addNewContent(data) {
	let dataCount = parseInt(data.dataCount);
	let pageNo = parseInt(data.page);
	let total_page = parseInt(data.total_page);

	const itemCount = document.querySelector('.dataCount-span');

	listNode.setAttribute('data-pageNo', pageNo);
	listNode.setAttribute('data-totalPage', total_page);

	itemCount.innerHTML = dataCount;
	sentinelNode.style.display = 'none';

	if (dataCount === 0) {
		listNode.innerHTML = '';
		return;
	}

	let htmlText;
	for (let dto of data.list) {
		let num = dto.num;
		let icon = dto.userLiked ? 'bi-heart-fill' : 'bi-heart';
		let thumbnail = dto.thumbnail;
		let title = dto.title;
		let project_info = dto.project_info;

		htmlText = '<div class="funding">'
		htmlText +=	'	<div class="funding-thumbnail">'
		htmlText +=	'		<a href="#">'
		htmlText +=	'			<img src="${pageContext.request.contextPath}/uploads/Funding/' + thumbnail + '">';
		htmlText += '		</a>';
		htmlText += '		<div class="like-btn" data-num="' + num + '">';
		htmlText += '			<i class="bi ' + icon + '" style="color: red;"></i>';
		htmlText += '		</div>';
		htmlText += '	</div>';
		htmlText += '	<div class="funding-title-div">';
		htmlText += '		<a href="#">' + title + '</a>';
		htmlText += '	</div>';
		htmlText += '	<div class="funding-detail-div">';
		htmlText += '		<span>' + project_info + '</span>';
		htmlText += '	</div>';
		htmlText += '	<div class="funding-progress-div">';
		htmlText += '		<span class="progress-percentage">76%</span>';
		htmlText += '		<span class="progress-amount">760,000원</span>';
		htmlText += '		<div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="height: 0.7rem">';
		htmlText += '			<div class="progress-bar" style="width: 76%; background-color: #2F9D27;"></div>';
		htmlText += '		</div>';
		htmlText += '	</div>';
		htmlText += '</div>';

		listNode.insertAdjacentHTML('beforeend', htmlText);
	}

	if (pageNo < total_page) {
		sentinelNode.setAttribute('data-loading', 'false');
		sentinelNode.style.display = 'block';
		io.observe(sentinelNode); // 관찰 대상(요소) 등록
	}

}

// 인터 섹션 옵저버를 이용한 무한 스크롤
const ioCallback = (entries, io) => {
	entries.forEach((entry) => {
		if (entry.isIntersecting) {
			// 관찰 대상의 교차(겹치는) 상태: 화면에 보이는 상태
			let loading = sentinelNode.getAttribute('data-loading');
			if (loading !== 'false') {
				return;
			}

			io.unobserve(entry.target); // 기존 관찰하던 요소는 더이상 관찰하지 않음

			let pageNo = parseInt(listNode.getAttribute('data-pageNo'));
			let total_page = parseInt(listNode.getAttribute('data-totalPage'));
			let order = $('.order-select option:selected').val();


			if (pageNo === 0 || pageNo < total_page) {
				pageNo++;
				loadContent(pageNo, order);
			}
		}
	});
}

const io = new IntersectionObserver(ioCallback); // 관찰자 초기화

$(function() {
	let order = $('.order-select option:selected').val();
	loadContent(1, order);
	// select onchange 이벤트 등록
	$('.order-select').change(function() {
		$('.funding-list-container').empty();
		let url = '${pageContext.request.contextPath}/funding/${menu}/fundingList';
		let query = 'page=1&order=' + $(this).val();
		const fn = function(data) {
			$('.funding-list-container').empty();
			addNewContent(data);
		}
		ajaxRequest(url, 'get', query, 'json', fn);
	});
});

//좋아요버튼
$(function() {
	$('.funding-list-container').on('mouseover', '.funding', function() {
		let $icon = $(this).find('i');
		$icon.mouseover(function() {
			let liked = $(this).hasClass('bi-heart-fill');
			if (!liked) {
				$icon.removeClass('bi-heart');
				$icon.addClass('bi-heart-fill');
			} else {
				$icon.removeClass('bi-heart-fill');
				$icon.addClass('bi-heart');
			}
		});
	});
	$('.funding-list-container').on('mouseout', '.funding', function() {
		let $icon = $(this).find('i');
		let liked = $icon.hasClass('bi-heart-fill');
		$icon.mouseout(function() {
			if (!liked) {
				$icon.removeClass('bi-heart-fill');
				$icon.addClass('bi-heart');
				
			} else {
				$icon.removeClass('bi-heart');
				$icon.addClass('bi-heart-fill');
			}
		});
	});
	$('.funding-list-container').on('click', '.funding i', function() {
		const num = $(this).closest('div').attr('data-num');
		let liked = $(this).hasClass('bi-heart-fill');
		let url = '${pageContext.request.contextPath}/funding/userLikeProject';
		const fn = function() {
			if(liked) {
				$(this).innerHTML = '<i class="bi bi-heart" style="color: red;"></i>';
			} else {
				$(this).innerHTML = '<i class="bi bi-heart" style="color: red;"></i>';
			}
		};

		ajaxRequest(url, 'post', {num: num, liked: !liked}, 'json', fn);
	});
});
/*
window.addEventListener('load', function() {
		// 좋아요 버튼 클릭
		const num = icon.closest('div').getAttribute('data-num'); // 좋아요 누른 프로젝트 번호
		icon.addEventListener('click', function() {
			liked = !liked;
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
			ajaxRequest(url, 'post', {num: num, liked: !liked}, 'json', fn);
		});
	}
});
 */

</script>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>