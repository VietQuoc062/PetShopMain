<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User, model.Account" %>
<%
    User user = (User) session.getAttribute("user");
    Account acc = (Account) session.getAttribute("account");
    if (user == null || acc == null) {
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
        <p>Vai trò của bạn: <%= acc.getRole() %></p>
        <p>Email: <%= user.getEmail() %></p>
        <p>Số điện thoại: <%= user.getPhone() %></p>
        <p>Địa chỉ: <%= user.getAddress() %></p>

        <form action="logout" method="post">
            <button type="submit" class="logout">Đăng xuất</button>
        </form>
    </div>
</div>
</body>
</html>