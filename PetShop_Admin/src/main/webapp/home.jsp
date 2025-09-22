<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.petshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - PetShop Admin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #333; }
        nav a { margin-right: 15px; text-decoration: none; color: #0066cc; }
        nav a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>Xin chào, <%= user.getUsername() %>!</h1>
    <p>Chào mừng bạn đến với trang quản trị PetShop.</p>
    <nav>
        <a href="users">Quản lý Users</a> |
        <a href="store">Quản lý Store</a> |
        <a href="roles">Quản lý Roles</a> |
        <a href="logout">Đăng xuất</a>
    </nav>
</body>
</html>
