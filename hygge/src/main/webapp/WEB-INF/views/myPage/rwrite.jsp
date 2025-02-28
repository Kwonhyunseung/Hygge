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
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
.rcontainer {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid black;
    margin: 40px auto;
    width: 800px;
    min-height: 400px;
}
h2 {
    text-align: center;
    margin-bottom: 20px;
}
.stars {
    display: flex;
    justify-content: center;
    margin-bottom: 15px;
}
.star {
    font-size: 1.8rem;
    cursor: pointer;
    color: #ddd;
}
.star.selected {
    color: #82B10C;
}
.thumbnail-container {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 10px;
}
.thumbnail {
    position: relative;
    width: 100px;
    height: 100px;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
}
.thumbnail img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.remove-btn {
    position: absolute;
    top: 2px;
    right: 2px;
    background: rgba(255,0,0,0.7);
    color: white;
    border: none;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    padding: 0;
    cursor: pointer;
}
</style>
</head>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<body>

<main style="width: 1200px; margin: auto;">
    <div class="rcontainer">
        <h2>상품 후기 작성</h2>
        <form action="${pageContext.request.contextPath}/myPage/rwrite" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label">상품명</label>
                <input type="text" class="form-control" value="${title}" readonly>
            </div>
            <div class="stars mb-3">
                <span class="star" data-value="1">★</span>
                <span class="star" data-value="2">★</span>
                <span class="star" data-value="3">★</span>
                <span class="star" data-value="4">★</span>
                <span class="star" data-value="5">★</span>
            </div>
            <input type="hidden" name="grade" id="grade" value="5">
            
            <div class="preview" id="file-preview"></div>
            
            <div class="mb-3">
                <label for="files" class="form-label">사진</label>
                <input type="file" class="form-control" id="file" name="selectFile" multiple accept="image/*">
                <div class="thumbnail-container" id="preview-container"></div>
            </div>
            
            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
            </div>
            <div class="text-center">          
       			<input type="hidden" name="project_num" value="${project_num}" />
       			<input type="hidden" name="sales_num" value="${sales_num}" />
                <button type="submit" class="btn btn-primary" style="background-color:#82B10C; height: 41px;
    border-radius: 8px; ">등록</button>
                <a href="${pageContext.request.contextPath}/myPage/myPage" class="btn btn-secondary" style="height: 41px;
    border-radius: 8px;">취소</a>
            </div>
        </form>
    </div>
</main>

<script type="text/javascript">
$(function() {
    // 별점 기능
    $('.star').click(function() {
        let value = $(this).data('value');
        $('#grade').val(value);
        $('.star').removeClass('selected');
        $(this).prevAll().addBack().addClass('selected');
    });
});
</script>

<script type="text/javascript">
function previewFiles() {
    const fileInput = document.getElementById('file');
    const previewContainer = document.getElementById('file-preview');
    const files = fileInput.files;

    // 이전 미리보기 제거
    previewContainer.innerHTML = ''; 

    Array.from(files).forEach(file => {
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            previewContainer.appendChild(img);
        }
        reader.readAsDataURL(file);
    });
}

// 파일 입력 필드의 값 초기화 (파일 선택 후)
function resetFileInput() {
    document.getElementById('file').value = '';
}

</script>
</body>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"></jsp:include>
</html>