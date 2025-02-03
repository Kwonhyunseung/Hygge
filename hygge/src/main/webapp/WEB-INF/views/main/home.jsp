<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>

<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.body-container {
    max-width: 1200px; /* 중앙 정렬 및 여백 조절 */
    margin: 0 auto; /* 좌우 여백 균등 */
}

h3 { margin-top: 30px; color: #333; }
h5 { color: #555; }

.row { display: flex; flex-wrap: wrap; margin-bottom: 20px; }
.col { flex: 1; padding: 10px; }
.col-3 { flex: 0 0 calc(25% - 20px); margin: 0 10px; box-sizing: border-box; }
.col-4 { flex: 0 0 calc(33.33% - 20px); margin: 0 10px; box-sizing: border-box; }
.col-8 { flex: 0 0 calc(66.66% - 20px); margin: 0 10px; box-sizing: border-box; }

.search-bar {
    display: flex;
    justify-content: center;
    padding: 10px 0;
}

.search-bar input {
    width: 50%;
    padding: 10px;
    border: 5px solid #82B10C;
    border-radius: 25px;
}

.categories {
    display: flex;
    justify-content: center;
   gap: 15px;
    margin: 20px 0;
}

.categories div {
    cursor: pointer;
    padding: 10px 20px;
    border-radius: 50px;
    transition: background-color 0.4s;
}

.categories div > img {
   width: 80px;
}

.categories div > p {
    display: flex;
   justify-content: center;
}

.categories div:hover {
    background-color: #ddd;
}

.lanking-bar {
    background-color: #fafafa;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.lanking-bar p {
    margin: 10px 0;
    font-size: 14px;
}

.new-project .row {
    justify-content: space-around;
}

.new-project .col {
    background-color: #f9f9f9;
    text-align: center;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s;
}

.new-project .col:hover {
    transform: translateY(-5px);
}

.popular-project img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.localstorage-project .col {
    text-align: center;
    background-color: #f9f9f9;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.deadline-project {
    background-color: #fff3cd;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.deadline-project img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 10px;
}

.release-project img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}


/* 하위 카테고리 스타일 */
.hr {
    margin: 0; /* <hr> 위아래 공백 제거 */
    padding: 0;
}

.sub-categories {
    display: none; /* 초기 숨김 */
    background-color: #f8f9fa; /* 배경색 (원하는 색상으로 변경 가능) */
    padding: 10px 15px;
    border-top: 1px solid #ddd; /* 구분선 */
}

.sub-categories h4 {
    margin: 0 0 8px 0;
    font-size: 16px;
    font-weight: bold;
}

.sub-categories ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex; /* 가로 정렬 */
    flex-wrap: wrap; /* 너무 길면 자동 줄바꿈 */
}

.sub-categories li {
    margin-right: 15px;
    font-size: 14px;
    cursor: pointer;
}

.sub-categories li:hover {
    text-decoration: underline;
}

</style>

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
         <div>패션</div>
         <div>뷰티</div>
         <div>홈▪리빙</div>
         <div>푸드</div>
         <div>도서</div>
         <div>캐릭터▪굿즈</div>
         <div>문화</div>
         <div>반려동물</div>
      </div>

      <hr class="hr">

      <div class="body-container">
         <div class="row">
            <div class="col-8">
               <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
                  <div class="carousel-inner">
                     <div class="carousel-item active">
                        <img src="/dist/images/main/ad1.jpg" class="d-block w-100" style="width: 80%; height: 400px;" alt="AD">
                     </div>
                     <div class="carousel-item">
                        <img src="/dist/images/main/ad2.jpg" class="d-block w-100" style="width: 80%; height: 400px;" alt="AD">
                     </div>
                     <div class="carousel-item">
                        <img src="/dist/images/main/ad3.png" class="d-block w-100" style="width: 80%; height: 400px;" alt="AD">
                     </div>
                  </div>
                  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
                     <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                     <span class="visually-hidden">Previous</span>
                  </button>
                  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
                     <span class="carousel-control-next-icon" aria-hidden="true"></span>
                     <span class="visually-hidden">Next</span>
                  </button>
               </div>
               <br><br><br>
               <div class="new-project">
                  <h3>신규 프로젝트</h3>
                  <div class="row">
                     <div class="col">
                        <!-- <img src="/dist/images/"> -->
                        프로젝트 1
                     </div>
                     <div class="col">
                        프로젝트 2
                     </div>
                     <div class="col">
                        프로젝트 3
                     </div>
                     <div class="col">
                        프로젝트 4
                     </div>
                  </div>
               </div>
            </div>
            
            <div class="col-4">
               <div class="lanking-bar">
                  <h3>실시간 랭킹</h3>
                  <div class="col">
                     <div class="">
                        <p>1. 매일 한 잔으로 어깨 깡패되는<br>새해 필수템</p>
                        <!-- <img src="/dist/images/"> -->
                     </div>
                  </div>
                  <div class="col">
                     <div class="">
                        <p>2. 실시간 프로젝트</p>
                     </div>
                  </div>
                  <div class="col">
                     <div class="">
                        <p>3. 실시간 프로젝트</p>
                     </div>
                  </div>
                  <div class="col">
                     <div class="">
                        <p>4. 실시간 프로젝트</p>
                     </div>
                  </div>
                  <div class="col">
                     <div class="">
                        <p>5. 실시간 프로젝트</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         
         <div class="popular-project">
            <h3>인기 프로젝트</h3>
            <div class="row">
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
            </div>
         </div>
         
         <div class="localstorage-project">
            <h3>최근 본 프로젝트</h3>
            <div class="row">
               <div class="col">
                  <div class="">
                     <!-- <img src="/dist/images/"> -->
                     최근 본 1
                  </div>
               </div>
               <div class="col">
                  <div class="">
                     최근 본 2
                  </div>
               </div>
               <div class="col">
                  <div class="">
                     최근 본 3
                  </div>
               </div>
            </div>
         </div>
                  
         <div class="deadline-project">
            <h3>마감임박! 마지막 기회</h3>
            <h5>06:15:16 남았어요</h5>
            <div class="row">
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
            </div>
         </div>
         
         <div class="release-project">
            <h3>공개예정 프로젝트</h3>
            <div class="row">
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
               <div class="col-3">
                  <div class="">
                     <img src="/dist/images/main/p.jpg">
                  </div>
               </div>
            </div>
         </div>
         
      </div>
   </main>

   <footer>
      <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
   </footer>

</body>
</html>