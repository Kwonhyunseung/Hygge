<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<title>프로필 수정</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
.container {
    max-width: 600px;
    margin-top: 50px;
    margin-bottom: 50px;
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
}
h2 {
    text-align: center;
    margin-bottom: 20px;
}
.form-group {
    margin-bottom: 15px;
}
.form-group label {
    font-weight: bold;
}
.profile-img-wrapper {
  display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}
.profile-img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background-color: #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40px;
    color: #777;
    cursor: pointer;
}
.btn-group {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    border: none;
}
.category-container {
	margin-top: 8px;
	margin-bottom: 8px;
    display: flex;
    flex-wrap: wrap;
    gap: 22px;
}

.category-item {
    background-color: #e0e0e0;
    padding: 12px 25px;
    border-radius: 50px;
    cursor: pointer;
    font-size: 1rem; /* 글씨 크기 일정하게 설정 */
    display: flex; /* 플렉스박스로 설정하여 내용 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: center; /* 수평 중앙 정렬 */
    transition: background-color 0.3s ease; /* 색상 변화에 부드러운 전환 효과 추가 */
    min-width: 80px; /* 최소 너비 설정 */
}

.category-item span {
    padding-left: 4px; /* 글씨와 아이콘 사이에 여백 추가 */
    display: inline-block;
    text-align: center; /* 텍스트 중앙 정렬 */
}

/* 체크박스 숨기기 */
.hidden-checkbox {
    display: none;
}

/* 체크박스가 선택되었을 때, 해당 category-item의 색상 변경 */
.hidden-checkbox:checked + span {
    background-color: #b2cc85;
    color: white;
}

/* Hover 효과 */
.category-item:hover {
    background-color: #b2cc85;
    color: white;
}

/* 체크된 상태에서 hover 시 효과 */
.hidden-checkbox:checked:hover {
    background-color: #a5b76e;
}


</style>
</head>
<body>
    <div class="container">
        <h2>프로필 수정</h2>
        <div class="profile-img-wrapper">
            <div class="profile-img" onclick="document.getElementById('profileUpload').click()">
                <i class="bi bi-person"></i>
            </div>
            <input type="file" id="profileUpload" accept="image/*" style="display: none;">
        </div>

        <form action="profileUpdate.jsp" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" class="form-control" value="${myPage.name}">
            </div>
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" class="form-control" value="${myPage.nickName}">
            </div>
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" class="form-control" value="${myPage.tel1}-${myPage.tel2}-${myPage.tel3}">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" value="${myPage.email1}@${myPage.email2}">
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" class="form-control" value="${myPage.addr1}">
            </div>
             <div class="form-group">
                <label for="address">상세주소</label>
                <input type="text" id="address2" name="address2" class="form-control" value="${myPage.addr2}">
            </div>
<div class="mb-3">
    <label>선호 카테고리 *</label>
    <div class="category-container" id="category-container">
        <label class="category-item">
            <input type="checkbox" name="category" value="가전" class="hidden-checkbox"> <span>가전</span>
        </label>
        <label class="category-item">
            <input type="checkbox" name="category" value="패션" class="hidden-checkbox"> <span>패션</span>
        </label>
        <label class="category-item">
            <input type="checkbox" name="category" value="뷰티" class="hidden-checkbox"> <span>뷰티</span>
        </label>
        <label class="category-item">
            <input type="checkbox" name="category" value="홈·리빙" class="hidden-checkbox"> <span>홈·리빙</span>
        </label>
        <label class="category-item">
            <input type="checkbox" name="category" value="푸드" class="hidden-checkbox"> <span>푸드</span>
        </label>
    </div>
</div>


            <div class="btn-group">
                <button type="submit" class="btn btn-success" style="background-color: #82B10C;  border: none;">저장</button>
                <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
</body>
<script type="text/javascript">
//모든 체크박스 요소들
const checkboxes = document.querySelectorAll('.hidden-checkbox');
const categoryItems = document.querySelectorAll('.category-item');

checkboxes.forEach((checkbox, index) => {
    checkbox.addEventListener('change', () => {
        if (checkbox.checked) {
            categoryItems[index].style.backgroundColor = '#b2cc85'; // 선택된 항목 색상 변경
            categoryItems[index].style.color = 'white';
        } else {
            categoryItems[index].style.backgroundColor = '#e0e0e0'; // 선택 해제 시 원래 색으로 복원
            categoryItems[index].style.color = 'black';
        }
    });
});


</script>
</html>
