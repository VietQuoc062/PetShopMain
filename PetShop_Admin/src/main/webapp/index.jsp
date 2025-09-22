<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.petshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Pet Shop - User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f7fa; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: white; border-bottom: 1px solid #ddd; }
        .navbar-brand img { height: 40px; margin-right: 10px; }
        .user-info img { height: 35px; width: 35px; border-radius: 50%; margin-left: 10px; }
        .card { border-radius: 12px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-align: center; padding: 20px; }
        .notification { background: white; border-radius: 12px; padding: 20px; margin-top: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
<nav class="navbar px-4">
    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
        <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="Logo">
        <strong>User Management</strong>
    </a>
    <div class="user-info ms-auto d-flex align-items-center">
        Xin chào, <b><%= user.getUsername() %></b> (<%= user.getRole() %>)
        <img src="https://i.pravatar.cc/50" alt="Avatar">
        <a href="logout" class="btn btn-sm btn-outline-danger ms-3">Đăng xuất</a>
    </div>
</nav>

<div class="container mt-3 text-center">
    <a href="index.jsp" class="btn btn-dark mx-2">Trang chủ</a>
    <a href="users" class="btn btn-outline-dark mx-2">Quản lý người dùng</a>
    <a href="roles" class="btn btn-outline-dark mx-2">Quản lý vai trò & quyền</a>
</div>

<div class="container mt-4">
    <h4>🐾 Chào mừng đến với Cửa hàng Thú Cưng</h4>
    <p>Hệ thống quản lý giúp bạn theo dõi thú cưng, khách hàng, nhân viên và đơn hàng dễ dàng.</p>
    <div class="row g-3">
        <div class="col-md-3"><div class="card"><h5>🐕 Thú cưng</h5><h2>120</h2></div></div>
        <div class="col-md-3"><div class="card"><h5>👥 Khách hàng</h5><h2>85</h2></div></div>
        <div class="col-md-3"><div class="card"><h5>🛒 Đơn hàng hôm nay</h5><h2>12</h2></div></div>
        <div class="col-md-3"><div class="card"><h5>👨‍💼 Nhân viên</h5><h2>6</h2></div></div>
    </div>
    <div class="notification mt-4">
        <h5>📢 Lưu ý quan trọng</h5>
        <ul class="text-start">
            <li><strong>Quyền truy cập:</strong> Chỉ có tài khoản có quyền Admin mới vào được trang quản lý vai trò và quyền để xem và chỉnh sửa các quyền hiện tại.</li>
            <li><strong>Bảo mật:</strong> Không chia sẻ thông tin đăng nhập với người khác. Đăng xuất khi không sử dụng.</li>
            <li><strong>Sao lưu dữ liệu:</strong> Hệ thống tự động sao lưu dữ liệu hàng ngày lúc 2:00 AM.</li>
            <li><strong>Hỗ trợ:</strong> Liên hệ IT Support nếu gặp sự cố kỹ thuật hoặc cần hỗ trợ.</li>
            <li><strong>Cập nhật:</strong> Phiên bản hệ thống hiện tại: v2.1.0 (cập nhật 21/09/2025).</li>
        </ul>
    </div>
</div>
</body>
</html>
