<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f9f9f9;
}
.chat-container {
    display: flex;
    max-width: 1000px;
    width: 100%;
    margin-top: 30px;
    margin-bottom: 40px;
    background: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    border: 1px solid #ddd;
    overflow: hidden;
    padding: 5px;
}
.chat-list {
    width: 24%;
    border-right: 1px solid #ddd;
    padding: 15px;
    background: #f0f0f0;
    height: 450px;
    overflow-y: auto;
    border-radius: 8px;
}
.chat-list h5 {
    text-align: center;
    margin-bottom: 15px;
    font-weight: bold;
    color: #333;
}
.chat-list ul {
    list-style: none;
    padding: 0;
    margin: 0;
}
.chat-list li {
    padding: 12px;
    border-bottom: 1px solid #ccc;
    cursor: pointer;
    transition: background 0.3s;
    font-weight: bold;
    color: #555;
    text-align: center;
    border-radius: 4px;
}
.chat-list li:hover {
    background: #d4edda;
}
.chat-window {
    flex: 1;
    display: flex;
    flex-direction: column;
    height: 450px;
    background: #fff;
    border-radius: 8px;
    padding: 6px;
}
.chat-header {
    background: #82B10C;
    color: white;
    padding: 20px;
    text-align: center;
    font-weight: bold;
    font-size: 18px;
    border-radius: 8px;
}
.chat-body {
    flex: 1;
    padding: 15px;
    overflow-y: auto;
    border-bottom: 1px solid #ddd;
    background: #fafafa;
    display: flex;
    flex-direction: column;
    gap: 10px;
    border-radius: 8px;
}
.message {
    max-width: 70%;
    padding: 10px;
    border-radius: 10px;
    word-wrap: break-word;
}
.my-message {
    align-self: flex-end;
    background: #d4edda;
    text-align: right;
}
.other-message {
    align-self: flex-start;
    background: #ffffff;
    text-align: left;
    border: 1px solid #ddd;
}
.chat-footer {
    display: flex;
    padding: 10px;
    background: #fff;
    border-radius: 8px;
}
.chat-footer input {
    flex: 1;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}
.chat-footer button {
    background: #82B10C;
    color: white;
    border: none;
    padding: 10px 15px;
    margin-left: 5px;
    cursor: pointer;
    border-radius: 4px;
    font-size: 14px;
    transition: background 0.3s;
}
.chat-footer button:hover {
    background: #6a9009;
}
.content-wrapper {
    padding: 20px;
}
</style>
</head>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<body>
    <div class="chat-container" style="max-width: 1000px;">
        <div class="chat-list">
            <h5 style="margin-bottom: 50px;">판매자 목록</h5>
            <ul>
                <li onclick="openChat('판매자1')">판매자1</li>
                <li onclick="openChat('판매자2')">판매자2</li>
                <li onclick="openChat('판매자3')">판매자3</li>
                <li onclick="openChat('판매자4')">판매자4</li>
                <li onclick="openChat('판매자5')">판매자5</li>
                <li onclick="openChat('판매자6')">판매자6</li>
            </ul>
        </div>
        <div class="chat-window">
            <div class="chat-header" id="chatHeader">채팅을 선택하세요</div>
            <div class="chat-body" id="chatBody">
                <p>판매자와의 대화를 시작하세요.</p>
            </div>
            <div class="chat-footer">
                <input type="text" id="chatInput" placeholder="메시지를 입력하세요">
                <button onclick="sendMessage()">전송</button>
            </div>
        </div>
    </div>

    <script>
        function openChat(seller) {
            document.getElementById("chatHeader").innerText = seller + "와의 채팅";
            document.getElementById("chatBody").innerHTML = "<p>" + seller + "님과 대화를 시작하세요.</p>";
        }
        function sendMessage() {
            var input = document.getElementById("chatInput");
            var message = input.value.trim();
            if (message) {
                var chatBody = document.getElementById("chatBody");
                var myMessage = document.createElement("div");
                myMessage.classList.add("message", "my-message");
                myMessage.innerText = "나: " + message;
                chatBody.appendChild(myMessage);
                input.value = "";
                chatBody.scrollTop = chatBody.scrollHeight;
            }
        }
    </script>
</body>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
</html>
