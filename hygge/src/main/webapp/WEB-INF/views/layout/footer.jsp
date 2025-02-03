<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style type="text/css">
body {
	margin: 0;
	font-family: Arial, sans-serif;
}

footer {
	background-color: #f9f9f9;
	border-top: 1px solid #e5e5e5;
	padding: 20px 40px;
	font-size: 14px;
	color: #333;
}

footer .container {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	max-width: 1200px;
	margin: 0 auto;
}

footer .section {
	margin-bottom: 20px;
}

footer h4 {
	font-weight: bold;
	margin-bottom: 10px;
}

footer a {
	color: #333;
	text-decoration: none;
	display: block;
	margin: 5px 0;
}

footer a:hover {
	text-decoration: underline;
}

footer .notice {
	font-size: 12px;
	color: #666;
	line-height: 1.5;
	margin-top: 20px;
}

footer .highlight {
	background-color: #e7f7d5;
	padding: 10px;
	border-radius: 5px;
}
</style>

<footer>
	<div class="container">
		<div class="main-section">
			<h4>HYGGE 고객센터</h4>
			<a href="#">채팅 상담하기</a>
			<a href="#">문의 등록하기</a>
			<br>
			<p>고객지원<br>평일 10:00 ~ 17:00 (12:00 ~ 14:00 제외)</p>
		</div>
		<div class="sub-section">
			<h4>HYGGE</h4>
			<a href="#">공지사항</a> <a href="#">서비스 소개</a> <a href="#">채용</a> <a
				href="#">HYGGE 광고센터</a>
		</div>
		<div class="sub-section">
			<h4>이용안내</h4>
			<a href="#">첫 후원 가이드</a> <a href="#">창작자 가이드</a> <a href="#">수수료
				안내</a> <a href="#">제휴•협력</a>
		</div>
		<div class="sub-section">
			<h4>정책</h4>
			<a href="#">이용약관</a> <a href="#">개인정보처리방침</a> <a href="#">프로젝트 심사
				기준</a>
		</div>
	</div>
	<div class="container">
		<div class="seconde-section">
			<pre>
				<strong>회사명:</strong> HYGGE(주) | <strong>사업자등록번호:</strong>98-9999-0000 | <strong>서비스사업자:</strong> HYGGE(주)
				<strong>이메일:</strong> rainbow@hygge.kr | <strong>주소:</strong> 서울 무지개구 판타스틱로 2층   |   ©HYGGE.Inc.
			</pre>>
		</div>
	</div>
	<div class="container highlight">
		<p class="notice">HYGGE는 창작자와 프로젝트의 성공을 돕는 플랫폼일 뿐이며, 직접적인 심사와 관여를
			하지 않습니다. 프로젝트 내용 및 진행 과정은 해당 프로젝트 창작자의 책임 하에 진행되며, 플랫폼은 책임을 지지 않습니다.
			후원 전 모든 내용을 신중히 검토하시기 바랍니다.</p>
	</div>
</footer>
