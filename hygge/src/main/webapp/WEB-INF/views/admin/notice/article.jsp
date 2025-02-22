<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 보기</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="/dist/css/admin/notice/article.css">
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
                    <h2>공지사항 상세보기</h2>
                </div>
            </div>

            <div class="content-body">
                <table class="article-table">
                    <tbody>
                        <tr>
                            <td class="title" colspan="2">${dto.title}</td>
                        </tr>
                        <tr>
                            <td class="writer">작성자: ${dto.name}</td>
                            <td class="date"><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        <tr>
                            <td class="content" colspan="2">
                                ${dto.content}
						        <c:if test="${not empty files}">
						            <c:forEach var="file" items="${files}">
						                    <img alt="" src="/uploads/notice/${file.s_FileName}">
						            </c:forEach>
						        </c:if>                                
                            </td>
                        </tr>
                        
                        
                        <c:if test="${not empty files}">
                            <tr>
                                <td class="files" colspan="2">
                                    <span class="label">첨부파일:</span>
                                    <c:forEach var="file" items="${files}">
                                        <div class="file-item">
                                            <a href="${pageContext.request.contextPath}/admin/notice/download?num=${file.num}">${file.s_FileName}</a>
                                        </div>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:if>
                        
                        <tr>
                            <td colspan="2">
                                <div class="prev-next">
                                    <div class="item">
                                        <c:if test="${not empty prevDto}">
                                            <span class="label">이전글:</span>
                                            <a href="${pageContext.request.contextPath}/admin/notice/article?${query}&num=${prevDto.num}">${prevDto.title}</a>
                                        </c:if>
                                    </div>
                                    <div class="item">
                                        <c:if test="${not empty nextDto}">
                                            <span class="label">다음글:</span>
                                            <a href="${pageContext.request.contextPath}/admin/notice/article?${query}&num=${nextDto.num}">${nextDto.title}</a>
                                        </c:if>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="button-group">
                    <button type="button" class="btn update-btn" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}';">수정</button>
                    <button type="button" class="btn delete-btn" onclick="deleteNotice();">삭제</button>
                    <button type="button" class="btn list-btn" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list?${query}';">목록</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function deleteNotice() {
            if(confirm('게시글을 삭제하시겠습니까?')) {
                location.href='${pageContext.request.contextPath}/admin/notice/delete?num=${dto.num}&page=${page}';
            }
        }
    </script>
</body>
</html>