<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트 등록</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/event/write.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Summernote 에디터 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs4.min.css" rel="stylesheet">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        
        <div class="main-content">
            <div class="content-header">
                <div class="content-title">
				</div>
            </div>

            <form name="eventForm" method="post" enctype="multipart/form-data" onsubmit="return sendOk();">
                <c:if test="${mode=='update'}">
			        <input type="hidden" name="num" value="${dto.num}">
			    </c:if>
                <div class="write-container">
                    <div class="form-group">
                        <label for="event-title">이벤트 제목</label>
                        <input type="text" id="event-title" name="title" placeholder="${mode=='update' ? dto.title : ''}" required>
                    </div>

                    <div class="form-group">
                        <label>이벤트 이미지</label>
                        <div class="image-upload" onclick="document.getElementById('photoFiles').click();">
                            <input type="file" id="photoFiles" name="photoFiles" style="display: none;">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <p>이미지를 업로드하려면 클릭하세요</p>
                        </div>
                        <div class="image-preview" style="${mode=='update' && not empty dto.photo ? 'display:block' : 'display:none'}">
						    <img id="preview" src="${mode=='update' && not empty dto.photo ? '/uploads/event/'.concat(dto.photo) : '#'}" alt="이미지 미리보기">
						</div>
                    </div>

					<div class="form-group">
					    <label>이벤트 기간</label>
					    <div class="date-container">
					        <c:if test="${mode=='update'}">
					            <fmt:formatDate var="formattedEvtDate" value="${dto.evt_date}" pattern="yyyy-MM-dd"/>
					            <fmt:formatDate var="formattedExpDate" value="${dto.exp_date}" pattern="yyyy-MM-dd"/>
					        </c:if>
					        <input type="date" name="evt_date" value="${mode=='update' ? formattedEvtDate : ''}" required>
					        <span>~</span>
					        <input type="date" name="exp_date" value="${mode=='update' ? formattedExpDate : ''}" required>
					    </div>
					</div>
					
					<%-- 
                    <div class="form-group">
                        <label>이벤트 상태</label>
                        <select name="status" class="status-select">
                            <option value="active">진행중</option>
                            <option value="upcoming">진행예정</option>
                            <option value="ended">종료</option>
                        </select>
                    </div>
					--%>
                    <div class="form-group">
                        <label for="event-content">이벤트 내용</label>
                        <div class="editor-container">
                            <textarea name="content" id="event-content" style="width: 100%; height: 400px;">${mode=='update' ? dto.content : ''}</textarea>
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn btn-cancel" onclick="location.href='${pageContext.request.contextPath}/admin/event/list';">취소</button>
                        <button type="submit" class="btn btn-primary">${mode== 'update' ? '수정' : '등록'}</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    <!-- Bootstrap 4 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
    
    <!-- Summernote 에디터 JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/lang/summernote-ko-KR.min.js"></script>

    <script>
        // Summernote 에디터 초기화
        $(document).ready(function() {
            $('#event-content').summernote({
                lang: 'ko-KR',                  // 한국어 설정
                height: 400,                    // 에디터 높이
                minHeight: null,                // 최소 높이
                maxHeight: null,                // 최대 높이
                focus: false,                   // 에디터 로드 후 포커스 설정
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ],
                callbacks: {
                    onImageUpload: function(files) {
                        // 이미지 업로드 처리 (필요시 구현)
                        // 서버에 이미지를 업로드하고 URL을 받아와 에디터에 삽입하는 로직
                    }
                }
            });
        });

        // 이미지 미리보기 함수
        document.getElementById('photoFiles').addEventListener('change', function(e) {
            const preview = document.getElementById('preview');
            const previewContainer = document.querySelector('.image-preview');
            const file = e.target.files[0];
            
            if(file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    previewContainer.style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        });
        
function sendOk() {
    const f = document.eventForm;
    
    if(!f.title.value.trim()) {
        alert("제목을 입력하세요.");
        f.title.focus();
        return false;
    }
    
    if(!$('#event-content').summernote('isEmpty')) {
        // Summernote 내용 가져오기
        var content = $('#event-content').summernote('code');
        // 내용이 비어있지 않으면 내용을 설정
        f.content.value = content;
    } else {
        alert("내용을 입력하세요.");
        $('#event-content').summernote('focus');
        return false;
    }
    
    if(!f.evt_date.value) {
        alert("시작일을 선택하세요.");
        f.evt_date.focus();
        return false;
    }
    
    if(!f.exp_date.value) {
        alert("종료일을 선택하세요.");
        f.exp_date.focus();
        return false;
    }
    
    if('${mode}' === 'update') {
        f.action = "${pageContext.request.contextPath}/admin/event/update";
    } else {
        f.action = "${pageContext.request.contextPath}/admin/event/write";
    }
    
    f.submit();
}
    </script>
</body>
</html>