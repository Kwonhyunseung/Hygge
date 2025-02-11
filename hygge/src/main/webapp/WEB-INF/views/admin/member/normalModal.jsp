<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
   
<%-- 모달 창 디자인 --%>   
<div class="modal" id="memberModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>회원 상세 정보</h2>
        <div class="modal-body">
            <p>
                <strong>회원번호</strong>
                <span id="modalMemberIdx"></span>
            </p>
            <p>
                <strong>이름</strong>
                <span id="modalName"></span>
            </p>
            <p>
                <strong>생년월일</strong>
                <span id="modalBirth"></span>
            </p>
            <p>
                <strong>전화번호</strong>
                <span id="modalTel"></span>
            </p>
            <p>
                <strong>닉네임</strong>
                <span id="modalNickName"></span>
            </p>
            <p>
                <strong>성별</strong>
                <span id="modalGender"></span>
            </p>
            <p>
                <strong>주소</strong>
                <span id="modalAddr"></span>
            </p>
            <p>
                <strong>이메일</strong>
                <span id="modalEmail"></span>
            </p>
            <p>
                <strong>가입일</strong>
                <span id="modalRegDate"></span>
            </p>
            <p>
                <strong>마지막 수정 날짜</strong>
                <span id="modalModDate"></span>
            </p>
            <p>
                <strong>마지막 로그인 날짜</strong>
                <span id="modalLastLogin"></span>
            </p>
            <p>
                <strong>신고횟수</strong>
                <span id="modalReportCount"></span>
            </p>
            <p>
                <strong>상태</strong>
                <span id="modalStatus"></span>
            </p>
        </div>
    </div>
</div>
</body>
</html>