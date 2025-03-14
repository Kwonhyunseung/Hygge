<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .mcontent-wrapper {
            padding: 20px;
            background-color: #f9f9f9;
        }

        .mcontainer {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: 1px solid black;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .btn-primary {
            background-color: #FF7F50 !important;
            border-color: #FF7F50 !important;
            color: white !important;
        }

        .btn-primary:hover {
            background-color: #FF7F50 !important;
            border-color: #FF7F50 !important;
        }

        .btn-custom {
            width: 100px;
        }

        label {
            margin-bottom: 20px;
        }

        .select-wrapper {
            position: relative;
        }

        .select-wrapper select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-color: white;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2382B10C'%3E%3Cpath d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 32px;
            padding-right: 10px;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    </header>

    <div class="mcontent-wrapper">
        <div class="mcontainer">
            <h2>게시판 작성</h2>
            <form action="${pageContext.request.contextPath}/makerPage/medit" method="post" enctype="multipart/form-data">
                <!-- 유저 정보 표시 (작성자명 자동 입력) -->
                <c:if test="${not empty dto}">
                    <input type="hidden" name="mkboard_Num" value="${dto.mkboard_Num}" />
                    <div class="form-group">
                        <label for="userName">${dto.name}</label>
                    </div>
                </c:if>

                <!-- 제목 입력 -->
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" class="form-control" id="title" name="Title" value="${dto.title}"required>
                </div>

                <!-- 카테고리 선택 -->
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <select class="form-control" id="category" name="category" required>
                        <option value="" disabled selected>카테고리를 선택하세요</option>
                        <option value="가전" ${dto.category == '가전'? 'selected' : ''}>가전</option>
                        <option value="패션" ${dto.category == '패션'? 'selected' : ''}>패션</option>
                        <option value="뷰티" ${dto.category == '뷰티'? 'selected' : ''}>뷰티</option>
                        <option value="홈▪리빙" ${dto.category == '홈▪리빙'? 'selected' : ''}>홈▪리빙</option>
                        <option value="푸드" ${dto.category == '푸드'? 'selected' : ''}>푸드</option>
                        <option value="도서" ${dto.category == '도서'? 'selected' : ''}>도서</option>
                        <option value="캐릭터▪굿즈" ${dto.category == '캐릭터▪굿즈'? 'selected' : ''}>캐릭터▪굿즈</option>
                        <option value="문화" ${dto.category == '문화'? 'selected' : ''}>문화</option>
                        <option value="반려동물" ${dto.category == '반려동물'? 'selected' : ''}>반려동물</option>
                        <option value="기타" ${dto.category == '기타'? 'selected' : ''}>기타</option>
                    </select>
                </div>

                <!-- 내용 입력 -->
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea class="form-control" id="Content" name="Content" rows="5" required>${dto.content}</textarea>
                </div>

                <!-- 파일 업로드 -->
                <div class="form-group">
                    <label for="file">파일 업로드</label>
                    <input type="file" class="form-control" id="file" name="selectFile" multiple="multiple">
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary btn-custom" style="height: 40px; border-radius: 7px;">등록</button>
                    <a href="${pageContext.request.contextPath}/makerPage/projectManager" class="btn btn-secondary btn-custom">취소</a>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</body>
</html>
