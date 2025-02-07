<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/notice/write.css">
    <!-- 썸머노트 에디터 -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
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
                    <h2>공지사항 작성</h2>
                </div>
            </div>

            <div class="content-body">
                <form name="noticeForm" method="post">
                    <div class="form-grid">
                        <div class="form-row">
                            <label>카테고리</label>
                            <select name="category" class="form-select">
                                <option value="general">일반공지</option>
                                <option value="event">이벤트</option>
                                <option value="maintenance">투표</option>
                            </select>
                        </div>
                        
                        <div class="form-row">
                            <label>상단고정</label>
                            <div class="form-check">
                                <input type="checkbox" name="isFixed" id="isFixed">
                                <label for="isFixed">공지사항 상단에 고정</label>
                            </div>
                        </div>

                        <div class="form-row full-width">
                            <label>제목</label>
                            <input type="text" name="title" class="form-input" placeholder="제목을 입력하세요">
                        </div>

                        <div class="form-row full-width">
                            <label>내용</label>
                            <textarea id="summernote" name="content"></textarea>
                        </div>

                        <div class="form-row full-width">
                            <label>첨부파일</label>
                            <div class="file-upload">
                                <input type="file" name="attachFile" multiple>
                                <p class="help-text">최대 5개까지 첨부 가능 (파일당 최대 10MB)</p>
                            </div>
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="button" class="cancel-btn" onclick="history.back();">취소</button>
                        <button type="submit" class="submit-btn">등록하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#summernote').summernote({
                height: 400,
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ],
                callbacks: {
                    onImageUpload: function(files) {
                        // 이미지 업로드 처리
                    }
                }
            });
        });
    </script>
</body>
</html>