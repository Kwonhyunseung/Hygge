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
                <input type="text" id="name" name="name" class="form-control" value="김선용">
            </div>
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" class="form-control" value="스프링">
            </div>
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" class="form-control" value="010-1234-5678">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" value="spring@naver.com">
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" class="form-control" value="서울 마포구 월드컵북로21 풍성빌딩">
            </div>
            <div class="form-group">
                <label for="category">선호 카테고리</label>
                <select id="category" name="category" class="form-control">
                    <option>가전</option>
                    <option>패션</option>
                    <option>뷰티</option>
                    <option>스포츠</option>
                    <option>음식</option>
                </select>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-success" style="background-color: #82B10C;  border: none;">저장</button>
                <a href="mypage.jsp" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
</body>
</html>
