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
    font-size: 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease;
    min-width: 80px;
}

.category-item span {
    padding-left: 4px;
    display: inline-block;
    text-align: center;
}

.hidden-checkbox {
    display: none;
}

.hidden-checkbox:checked + span {
    background-color: #b2cc85;
    color: white;
}

.category-item:hover {
    background-color: #b2cc85;
    color: white;
}

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

        <form action="${pageContext.request.contextPath}/myPage/profileEdit" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" class="form-control" value="${myPage.name}">
            </div>
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickName" class="form-control" value="${myPage.nickName}">
            </div>
            <div class="form-group">
			    <label for="phone">전화번호</label>
			    <div class="input-group">
			        <input type="text" id="tel1" name="tel1" class="form-control" value="${myPage.tel1}" placeholder="010" maxlength="3">
			        <span class="input-group-text">-</span>
			        <input type="text" id="tel2" name="tel2" class="form-control" value="${myPage.tel2}" maxlength="4">
			        <span class="input-group-text">-</span>
			        <input type="text" id="tel3" name="tel3" class="form-control" value="${myPage.tel3}" maxlength="4">
			    </div>
			</div>
					<div class="form-group">
				    <label for="email">이메일</label>
				    <div class="input-group">
				        <input type="text" id="email1" name="email1" class="form-control" value="${myPage.email1}" placeholder="아이디" />
				        <span class="input-group-text">@</span>
				        <input type="text" id="email2" name="email2" class="form-control" value="${myPage.email2}" placeholder="도메인"/>
				    </div>
				</div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="addr1" name="addr1" class="form-control" value="${myPage.addr1}">
            </div>
            <div class="form-group">
                <label for="address">상세주소</label>
                <input type="text" id="addr2" name="addr2" class="form-control" value="${myPage.addr2}">
            </div>
            
            <div class="form-group">
                <label for="gender">성별</label><br>
                <input type="radio" name="gender" value="1" id="male" ${myPage.gender == '1' ? 'checked' : ''}> 남성
                <input type="radio" name="gender" value="2" id="female" ${myPage.gender == '2' ? 'checked' : ''}> 여성
            </div>

            <div class="mb-3">
                <label>선호 카테고리 *</label>
                <div class="category-container" id="category-container">
                    <label class="category-item">
                        <input type="checkbox" name="category" value="1" class="hidden-checkbox"> <span>가전</span>
                    </label>
                    <label class="category-item">
                        <input type="checkbox" name="category" value="2" class="hidden-checkbox"> <span>패션</span>
                    </label>
                    <label class="category-item">
                        <input type="checkbox" name="category" value="3" class="hidden-checkbox"> <span>뷰티</span>
                    </label>
                    <label class="category-item">
                        <input type="checkbox" name="category" value="4" class="hidden-checkbox"> <span>홈·리빙</span>
                    </label>
                    <label class="category-item">
                        <input type="checkbox" name="category" value="5" class="hidden-checkbox"> <span>푸드</span>
                    </label>
                </div>
            </div>

            <!-- Hidden inputs for selected categories -->
            <input type="hidden" name="category1" id="category1">
            <input type="hidden" name="category2" id="category2">
            <input type="hidden" name="category3" id="category3">

            <div class="btn-group">
                <button type="submit" class="btn btn-success" onclick="sendOk()" style="background-color: #82B10C;  border: none;">저장</button>
                <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <script type="text/javascript">
    let selectedCategories = 0;

    // 모든 체크박스 요소들
    const checkboxes = document.querySelectorAll('.hidden-checkbox');
    const categoryItems = document.querySelectorAll('.category-item');

    checkboxes.forEach((checkbox, index) => {
        checkbox.addEventListener('change', () => {
            if (checkbox.checked) {
                selectedCategories++;

                if (selectedCategories > 3) {
                    alert("최대 3개의 카테고리만 선택할 수 있습니다.");
                    checkbox.checked = false;
                    selectedCategories--;
                    return;
                }

                categoryItems[index].style.backgroundColor = '#b2cc85'; // 선택된 항목 색상 변경
                categoryItems[index].style.color = 'white';
            } else {
                selectedCategories--;
                categoryItems[index].style.backgroundColor = '#e0e0e0'; // 선택 해제 시 원래 색으로 복원
                categoryItems[index].style.color = 'black';
            }
        });
    });

    function sendOk() {
        let category1 = '';
        let category2 = '';
        let category3 = '';

        // 선택된 카테고리 값들을 category1, category2, category3에 저장
        const checkedCategories = document.querySelectorAll('.hidden-checkbox:checked');
        checkedCategories.forEach((checkbox, index) => {
            if (index == 0) category1 = checkbox.value;
            if (index == 1) category2 = checkbox.value;
            if (index == 2) category3 = checkbox.value;
        });

        // 숨겨진 input 태그에 값 입력
        document.getElementById('category1').value = category1;
        document.getElementById('category2').value = category2;
        document.getElementById('category3').value = category3;
    }
    </script>
</body>
</html>
