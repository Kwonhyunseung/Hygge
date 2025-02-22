<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 ${mode=='update'?'수정':'작성'}</title>
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
               <h2>공지사항 ${mode=='update'?'수정':'작성'}</h2>
           </div>
       </div>

       <div class="content-body">
           <form name="noticeForm" method="post" enctype="multipart/form-data"
               action="${pageContext.request.contextPath}/admin/notice/${mode}">
               
               <c:if test="${mode=='update'}">
                   <input type="hidden" name="num" value="${dto.num}">
                   <input type="hidden" name="page" value="${page}">
               </c:if>
               
               <div class="form-grid">
                   <div class="form-row full-width">
                       <label>제목</label>
                       <input type="text" name="title" class="form-input" 
                           value="${dto.title}" placeholder="제목을 입력하세요">
                   </div>

                   <div class="form-row full-width">
                       <label>내용</label>
                       <textarea id="summernote" name="content">${dto.content}</textarea>
                   </div>

                   <div class="form-row full-width">
                       <label>첨부파일</label>
                       <div class="file-upload">
                           <input type="file" name="attachFiles" multiple>
                           <p class="help-text">최대 5개까지 첨부 가능</p>
                       </div>
                   </div>
                   
                   <c:if test="${mode=='update' && not empty files}">
                       <div class="form-row full-width">
                           <label>첨부된 파일</label>
                           <div class="attached-files">
                               <c:forEach var="file" items="${files}">
                                   <div class="file-item">
                                       <span>${file.s_FileName}</span>
                                       <button type="button" class="delete-file" 
                                           onclick="deleteFile('${file.num}');">삭제</button>
                                   </div>
                               </c:forEach>
                           </div>
                       </div>
                   </c:if>
               </div>

               <div class="button-group">
                   <button type="button" class="cancel-btn" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list?page=${page}';">취소</button>
                   <button type="submit" class="submit-btn">${mode=="write"?"등록하기":"수정하기"}</button>
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

function deleteFile(fileNum) {
   if(confirm('파일을 삭제하시겠습니까?')) {
       let url = '${pageContext.request.contextPath}/admin/notice/deleteFile';
       let query = 'num=' + fileNum + '&page=${page}';
       
       fetch(url + '?' + query)
       .then(response => response.json())
       .then(data => {
           if(data.state === 'success') {
               document.querySelector('.file-item button[onclick*="' + fileNum + '"]')
                   .closest('.file-item').remove();
           }
       })
       .catch(error => {
           console.error('Error:', error);
       });
   }
}
</script>
</body>
</html>