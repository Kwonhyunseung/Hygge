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
    
    
    setupProjectNavigation();
    
});

//프로젝트 카드 클릭 시 상세 페이지로 이동
function setupProjectNavigation() {
    const projectItems = document.querySelectorAll(".newP, .popularP, .deadlineP, .releaseP");
    
    projectItems.forEach(function(item) {
        const img = item.querySelector(".image-container img");
        const title = item.querySelector("p:last-child");
        const likeBtn = item.querySelector(".project-like-btn");
        
        // 프로젝트 번호 가져오기 (좋아요 버튼 또는 컨테이너의 data-num 속성에서)
        let projectNum = null;
        if (likeBtn) {
            projectNum = likeBtn.getAttribute("data-num");
        } else if (item.hasAttribute("data-num")) {
            projectNum = item.getAttribute("data-num");
        }
        
        if (projectNum) {
            // 이미지에 클릭 이벤트 추가
            if (img) {
                img.style.cursor = "pointer";
                img.addEventListener("click", function(e) {
                    // 좋아요 버튼이 클릭된 경우는 무시
                    if (!e.target.closest(".project-like-btn")) {
                        window.location.href = "${pageContext.request.contextPath}/funding/product/" + projectNum;
                    }
                });
            }
            
            // 제목에 클릭 이벤트 추가
            if (title) {
                title.style.cursor = "pointer";
                title.addEventListener("click", function() {
                    window.location.href = "${pageContext.request.contextPath}/funding/product/" + projectNum;
                });
            }
            
            item.style.cursor = "pointer";
            item.addEventListener("click", function(e) {
                // 좋아요 버튼이나 이미 처리된 요소가 아닌 경우만 이동
                if ((!likeBtn || !e.target.closest(".project-like-btn")) && 
                    e.target !== img && 
                    e.target !== title) {
                    window.location.href = "${pageContext.request.contextPath}/funding/product/" + projectNum;
                }
            });
        }
    });
    
    // 랭킹 프로젝트에도 클릭 이벤트
    const rankingRows = document.querySelectorAll(".lanking-bar .row");
    rankingRows.forEach(function(row) {
        const titleElement = row.querySelector(".col-6 p");
        const imgElement = row.querySelector(".lankImg img");
        const likeBtn = row.querySelector(".project-like-btn");
        
        let projectNum = null;
        if (likeBtn) {
            projectNum = likeBtn.getAttribute("data-num");
        } else if (row.hasAttribute("data-num")) {
            projectNum = row.getAttribute("data-num");
        }
        
        if (projectNum) {
            // 이미지와 제목에 클릭 이벤트 추가
            if (imgElement) {
                imgElement.style.cursor = "pointer";
                imgElement.addEventListener("click", function(e) {
                    if (!likeBtn || !e.target.closest(".project-like-btn")) {
                        window.location.href = "${pageContext.request.contextPath}/funding/product/" + projectNum;
                    }
                });
            }
            
            if (titleElement) {
                titleElement.style.cursor = "pointer";
                titleElement.addEventListener("click", function() {
                    window.location.href = "${pageContext.request.contextPath}/funding/product/" + projectNum;
                });
            }
            
            // 행 전체에 클릭 이벤트 추가
            row.style.cursor = "pointer";
            row.addEventListener("click", function(e) {
                if ((!likeBtn || !e.target.closest(".project-like-btn")) && 
                    e.target !== imgElement && 
                    e.target !== titleElement) {
                    window.location.href = "${pageContext.request.contextPath}/funding/product/" + projectNum;
                }
            });
        }
    });
}

// 좋아요 기능
$(function() {
    // 페이지 로드 시 서버에서 받은 좋아요 상태 초기화
    function initializeLikeStatus() {
    	
        $(".project-like-btn").each(function() {
            const projectNum = $(this).data("num");
            
            // 서버에서 설정한 초기 상태
            const serverLiked = $(this).hasClass("bi-heart-fill");
            
            // 실제 표시될 상태 결정
            if (serverLiked) {
                $(this).removeClass("bi-heart").addClass("bi-heart-fill text-danger");
            } else {
                $(this).removeClass("bi-heart-fill text-danger").addClass("bi-heart");
            }
        });
    }

    // 페이지 로드 시 좋아요 상태 초기화
    initializeLikeStatus();

    // 좋아요 버튼 클릭 이벤트
    $(".project-like-btn").click(function(e) {
        e.preventDefault();
        e.stopPropagation();  //이벤트 전파 중지
        
        const $btn = $(this);
        const num = $btn.data("num");
        const isLiked = $btn.hasClass("bi-heart-fill");
        
        $.ajax({
            url: "${pageContext.request.contextPath}/funding/userFundingLiked",
            type: "POST",
            data: { 
                num: num,
                userLiked: isLiked
            },
            dataType: "json",
            success: function(data) {
                if (data.state === "true") {
                    $(".like-count-" + num).text(data.likeCount);
                    
                    // 클릭한 버튼만 업데이트
                    if (data.isLiked) {
                        $btn.removeClass("bi-heart").addClass("bi-heart-fill text-danger");
                    } else {
                        $btn.removeClass("bi-heart-fill text-danger").addClass("bi-heart");
                    }
                } else {
                    alert(data.message || "좋아요 처리 중 오류가 발생했습니다.");
                }
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    if (confirm("로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?")) {
                        location.href = "${pageContext.request.contextPath}/member/login";
                    }
                } else {
                    alert("서버 오류가 발생했습니다.");
                }
            }
        });
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
				<input type="text" placeholder="검색어를 입력해주세요!" name="kwd">
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
			<!-- 광고이미지, 신규프젝, 실시간랭킹 -->
			<div class="row">
				<div class="col-8">
					<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="/dist/images/main/ad1.png" class="d-block w-100" style="width: 80%; height: 400px; margin-top: 30px;">
							</div>
							<div class="carousel-item">
								<img src="/dist/images/main/ad2.png" class="d-block w-100" style="width: 80%; height: 400px; margin-top: 30px;">
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
					    <c:choose>
					        <c:when test="${not empty newProjects}">
					            <c:forEach var="project" items="${newProjects}" varStatus="status">
					                <div class="col-4 newP">
					                    <div class="image-container">
										    <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}">
										    <i class="bi ${project.userLiked ? 'bi-heart-fill text-danger' : 'bi-heart'} project-like-btn" 
										       data-num="${project.num}"></i>
										</div>
										<div class="goal">
			                       			<p><fmt:formatNumber value="${project.funding_goal}" pattern="#,###" />% 달성</p>
					                    </div>
										<p>${project.title}</p>
					                </div>
					            </c:forEach>
					        </c:when>
					        <c:otherwise>
					            <div class="col-12 text-center">
					                <p>현재 신규 프로젝트가 없습니다.</p>
					            </div>
					        </c:otherwise>
					    </c:choose>
					</div>
				</div>

				<div class="col-4">
					<div class="lanking-bar">
					    <h3>실시간 랭킹</h3>
					    <div class="col">
					        <c:choose>
					            <c:when test="${not empty rankingProjects}">
					                <c:forEach var="project" items="${rankingProjects}" varStatus="status">
					                    <div class="row" data-num="${project.num}">
					                        <div class="col-1">
					                            <strong>${status.count}</strong>
					                        </div>
					                        <div class="col-6">
					                            <p>${project.title}</p>
					                        </div>
					                        <div class="col lankImg">
					                            <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}">
					                            <!-- 좋아요 버튼 추가 (선택사항) -->
					                            <%-- <i class="bi ${project.userLiked ? 'bi-heart-fill text-danger' : 'bi-heart'} project-like-btn" data-num="${project.num}"></i> --%>
					                        </div>
					                    </div>
					                    <br>
					                </c:forEach>
					            </c:when>
					            <c:otherwise>
					                <div class="text-center">
					                    <p>실시간 랭킹 프로젝트가 없습니다.</p>
					                </div>
					            </c:otherwise>
					        </c:choose>
					    </div>
					</div>

					<div class="special">
						<img src="/dist/images/main/s1.png">
						<img src="/dist/images/main/s2.png">
						<!-- <div id="carouselExampleFade" class="carousel slide carousel-fade"
							data-bs-ride="carousel">
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img src="/dist/images/main/s1.png" class="d-block w-100">
								</div>
								<div class="carousel-item">
									<img src="/dist/images/main/s2.png" class="d-block w-100">
								</div>
							</div>
						</div> -->
					</div>
				</div>
			</div>

			<div class="localstorage-project">
				<h3>최근 본 프로젝트</h3>
				<div class="row">
					<div class="row">
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/dish.jpg">
								<i class="bi bi-heart"></i>
							</div>
							<div class="goal">
								<p>52% 달성
							</div>
							<p>평범한 일상 속 가장 소중한 순간, 식사 시간을 더욱 특별하게 만들어줄 접시 프로젝트입니다</p>
						</div>
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/fresh.png">
								<i class="bi bi-heart"></i>
							</div>
							<div class="goal">
								<p>25% 달성
							</div>
							<p>🍋클린 디톡스 ⁝ 자연의 신선함을 담은 그린 주스</p>
						</div>
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/pet.jpg">
								<i class="bi bi-heart"></i>
							</div>
							<div class="goal">
								<p>70% 달성
							</div>
							<p>"바크티비티" 반려견이 직접 선택한 No.1 친환경 장난감</p>
						</div>
						<div class="col-3 localP">
							<div class="image-container">
								<img src="/dist/images/main/cup.png">
								<i class="bi bi-heart"></i>
							</div>
							<div class="goal">
								<p>81% 달성
							</div>
							<p>자연의 속삭임: 💜보랏빛 정원에서 피어나는 도자기 이야기</p>
						</div>
					</div>
				</div>
			</div>

			<div class="popular-project">
			    <h3>인기 프로젝트</h3>
			    <div class="row">
			        <c:forEach var="project" items="${popularProjects}">
			            <div class="col-3 popularP">
			                <div class="image-container">
			                    <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}">
			                    <i class="bi ${project.userLiked ? 'bi-heart-fill text-danger' : 'bi-heart'} project-like-btn" data-num="${project.num}"></i>
			                </div>
		                    <div class="goal">
                       			<p><fmt:formatNumber value="${project.funding_goal}" pattern="#,###" />% 달성</p>
		                    </div>
			                <p>${project.title}</p>
			            </div>
			        </c:forEach>
			    </div>
			</div>

			<div class="deadline-project">
			    <h3>마감임박! 마지막 기회</h3>
			    <div class="row">
			        <c:choose>
			            <c:when test="${not empty deadlineProjects}">
			                <c:forEach var="project" items="${deadlineProjects}">
			                    <div class="col-3 deadlineP">
			                        <div class="image-container">
			                            <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}">
			                            <i class="bi ${project.userLiked ? 'bi-heart-fill text-danger' : 'bi-heart'} project-like-btn" 
			                                data-num="${project.num}"></i>
			                        </div>
		                            <div class="goal">
                       					<p><fmt:formatNumber value="${project.funding_goal}" pattern="#,###" />% 달성</p>
                       					<span> ~ ${project.end_date}</span>
		                            </div>
			                        <p>${project.title}</p>
			                    </div>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
			                <div class="col-12 text-center">
			                    <p>현재 마감임박 프로젝트가 없습니다.</p>
			                </div>
			            </c:otherwise>
			        </c:choose>
			    </div>
			</div>

			<div class="release-project">
			    <h3>공개예정 프로젝트</h3>
			    <div class="row">
			        <c:choose>
			            <c:when test="${not empty comingProjects}">
			                <c:forEach var="project" items="${comingProjects}">
			                    <div class="col-3 releaseP" data-num="${project.num}">
			                        <div class="image-container">
			                            <img src="${pageContext.request.contextPath}/uploads/project/${project.thumbnail}">
			                        </div>
		                            <div class="goal">
										<p style="color: #878787;">개시까지 <span class="highlight-days" style="color: red;">${project.remained_date}</span> 남음</p>
									</div>
			                        <p>${project.title}</p>
			                    </div>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
			                <div class="col-12 text-center">
			                    <p>현재 공개 예정인 프로젝트가 없습니다.</p>
			                </div>
			            </c:otherwise>
			        </c:choose>
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