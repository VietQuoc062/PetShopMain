<%-- WEB-INF/tags/admin_layout.tag --%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="true" type="java.lang.String"%>
<%@ attribute name="pageHeader" required="true" type="java.lang.String"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - ${title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <%-- Có thể thêm Bootstrap hoặc các thư viện CSS khác ở đây --%>
    <style>
        /* Basic Admin CSS (src/main/webapp/assets/css/admin.css) */
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f4f7f6; }
        .admin-container { display: flex; min-height: 100vh; }
        .sidebar { width: 200px; background-color: #2c3e50; color: white; padding: 20px; box-shadow: 2px 0 5px rgba(0,0,0,0.1); }
        .sidebar h2 { color: #ecf0f1; text-align: center; margin-bottom: 30px; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar ul li { margin-bottom: 15px; }
        .sidebar ul li a { color: #bdc3c7; text-decoration: none; display: block; padding: 10px; border-radius: 4px; transition: background-color 0.3s; }
        .sidebar ul li a:hover, .sidebar ul li a.active { background-color: #34495e; color: #ecf0f1; }
        .main-content { flex-grow: 1; padding: 20px; }
        .header { background-color: white; padding: 15px 20px; border-bottom: 1px solid #ddd; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .header h1 { margin: 0; font-size: 1.8em; color: #333; }
        .content-area { background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-top: 20px; }
        .btn { padding: 8px 15px; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-primary { background-color: #3498db; color: white; border: none; }
        .btn-danger { background-color: #e74c3c; color: white; border: none; }
        .btn-warning { background-color: #f39c12; color: white; border: none; }
        .table-admin { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .table-admin th, .table-admin td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .table-admin th { background-color: #f2f2f2; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="url"],
        .form-group textarea {
            width: calc(100% - 22px); /* Adjust for padding and border */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea { resize: vertical; min-height: 80px; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
        .alert-danger { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 10px; border-radius: 5px; margin-bottom: 15px; }

    </style>
</head>
<body>
    <div class="admin-container">
        <div class="sidebar">
            <h2>Admin Dashboard</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/products" class="${requestScope.currentPage == 'products' ? 'active' : ''}">Quản lý Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/vouchers" class="${requestScope.currentPage == 'vouchers' ? 'active' : ''}">Quản lý Khuyến mãi</a></li>
                <%-- Thêm các menu khác ở đây --%>
                <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
            </ul>
        </div>
        <div class="main-content">
            <div class="header">
                <h1>${pageHeader}</h1>
                <%-- Có thể thêm thông tin người dùng admin ở đây --%>
                <div>Xin chào, Admin!</div>
            </div>
            <div class="content-area">
                <jsp:doBody/> <%-- Nơi nội dung của trang con sẽ được đặt vào --%>
            </div>
        </div>
    </div>
    <%-- Có thể thêm các script JS ở đây --%>
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>