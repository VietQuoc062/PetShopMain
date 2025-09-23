<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petshop.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f7fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background-color: white;
            border-bottom: 1px solid #ddd;
        }
        .navbar-brand img {
            height: 40px;
            margin-right: 10px;
        }
        .user-info img {
            height: 35px;
            width: 35px;
            border-radius: 50%;
            margin-left: 10px;
        }
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar px-4">
    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
        <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="Logo">
        <strong>User Management</strong>
    </a>
    <div class="user-info ms-auto d-flex align-items-center">
        Xin chào, <b><%= currentUser.getUsername() %></b> (<%= currentUser.getRole() %>)
        <img src="https://i.pravatar.cc/50" alt="Avatar">
        <a href="logout" class="btn btn-sm btn-outline-danger ms-3">Đăng xuất</a>
    </div>
</nav>

<!-- Menu -->
<div class="container mt-3 text-center">
    <a href="index.jsp" class="btn btn-outline-dark mx-2">Trang chủ</a>
    <a href="users" class="btn btn-dark mx-2">Quản lý người dùng</a>
    <% if ("ADMIN".equals(currentUser.getRole())) { %>
        <a href="roles" class="btn btn-outline-dark mx-2">Quản lý vai trò & quyền</a>
    <% } %>
</div>

<!-- User Table -->
<div class="container table-container">
    <h4 class="mb-3">👥 Danh sách người dùng</h4>
    <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Tài khoản</th>
            <th scope="col">Vai trò</th>
        </tr>
        </thead>
        <tbody>
        <% int i = 1;
           for (User u : users) { %>
            <tr>
                <th scope="row"><%= i++ %></th>
                <td><%= u.getUsername() %></td>
                <td>
                    <% if ("ADMIN".equals(u.getRole())) { %>
                        <span class="badge bg-danger">ADMIN</span>
                    <% } else if ("MANAGER".equals(u.getRole())) { %>
                        <span class="badge bg-primary">MANAGER</span>
                    <% } else { %>
                        <span class="badge bg-secondary"><%= u.getRole() %></span>
                    <% } %>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
