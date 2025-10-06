<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Chào Mừng</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<div class="container">
    <h2>Chào Mừng</h2>
    <div class="form-box">
    <p class="welcome">Xin chào, <%= user.getFirstName() + " " + user.getLastName() %> 🎉</p>
    <p>Vai trò của bạn: <%= user.getRole() %></p>
    <form action="logout" method="post">
        <button type="submit"  class="logout">Đăng xuất</button>
    </form>
    </div>
</div>
</body>
</html>
