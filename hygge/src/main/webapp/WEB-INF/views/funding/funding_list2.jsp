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
    // 카테고리 및 서브 카테고리 컨테이너 설정
    const categories = document.querySelectorAll(".categories div");
    const subCategoryContainer = document.createElement("div");
    subCategoryContainer.classList.add("sub-categories");

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
            
            const heading = document.createElement("h4");
            heading.innerText = categoryName + " 전체";
            heading.style.marginBottom = "30px";
            heading.style.fontSize = "20px";
            subCategoryContainer.appendChild(heading);
            
            // 하위 카테고리 목록
            const list = document.createElement("ul");
            list.style.display = "flex";
            list.style.flexWrap = "wrap";
            list.style.gap = "10px";
            list.style.padding = "0";
            list.style.margin = "0";
            list.style.listStyle = "none";

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

$(function() {
	$('input[name="kwd"]').keydown(function(evt) {
		if (evt.key === 'Enter') {
			if (!$('input[name="kwd"]').val()) {
				$('input[name="kwd"]').focus();
				return false;
			}
			const f = document.searchForm;
			f.submit();
		}
	});
});
</script>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<main>
	<form action="${pageContext.request.contextPath}/search" name="searchForm">
		<div class="search-bar">
			<input type="text" placeholder="검색어를 입력해주세요!" name="kwd" value="${keyword}">
		</div>
	</form>

	<div class="categories">
		<c:forEach var="category" items="${parentCategories}">
			<div data-categoryNum="${category.category_num}" onclick="location.href='${pageContext.request.contextPath}/funding/category0${category.category_num}'">
				<img src="/dist/images/main/category/${category.category_num}.png">
				<p>${category.name}</p>
			</div>
		</c:forEach>
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
	let url = '${pageContext.request.contextPath}/search/fundingList';
	let query = 'page=' + page + '&order=' + order + '&kwd=${keyword}';
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
		let progress = dto.progress;
		let total_amount = dto.funding_goal;

		htmlText = '<div class="funding">'
		htmlText +=	'	<div class="funding-thumbnail">'
		htmlText +=	'		<a href="${pageContext.request.contextPath}/funding/product/' + num + '">'
		htmlText +=	'			<img src="${pageContext.request.contextPath}/uploads/project/' + thumbnail + '">';
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
		htmlText += '		<span class="progress-percentage">' + progress + '%</span>';
		htmlText += '		<span class="progress-amount">' + total_amount + ' 원</span>';
		htmlText += '		<div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="height: 0.7rem">';
		htmlText += '			<div class="progress-bar" style="width: ' + progress + '%; background-color: #2F9D27;"></div>';
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
		let url = '${pageContext.request.contextPath}/search/fundingList';
		let query = 'page=1&order=' + $(this).val() + '&kwd=${keyword}';
		const fn = function(data) {
			$('.funding-list-container').empty();
			addNewContent(data);
		}
		ajaxRequest(url, 'get', query, 'json', fn);
	});
});

//좋아요버튼
$(function() {
	$('.funding-list-container').on('click', '.funding i', function() {
		let icon = $(this);
		const num = $(this).closest('div').attr('data-num');
		let liked = $(this).hasClass('bi-heart-fill');
		let url = '${pageContext.request.contextPath}/funding/userLikeProject';
		const fn = function(icon) {
			if(liked) {
				icon.removeClass('bi-heart-fill');
				icon.addClass('bi-heart');
			} else {
				icon.addClass('bi-heart-fill');
				icon.removeClass('bi-heart');
			}
		};

		ajaxRequest(url, 'post', {num: num, liked: !liked}, 'json', fn(icon));
	});
});

</script>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>