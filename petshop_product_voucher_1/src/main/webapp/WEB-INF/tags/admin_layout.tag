<%-- WEB-INF/tags/admin_layout.tag --%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="title" required="true" type="java.lang.String"%>
<%@ attribute name="pageHeader" required="true" type="java.lang.String"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pet Shop Admin - ${title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Pet Shop Admin CSS */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .admin-container { display: flex; min-height: 100vh; }
        
        /* Sidebar styling */
        .sidebar { 
            width: 280px; 
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            color: white; 
            padding: 0;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
            position: relative;
        }
        .sidebar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4);
        }
        .sidebar h2 { 
            color: #fff; 
            text-align: center; 
            padding: 25px 20px;
            margin: 0;
            background: rgba(255,255,255,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
            font-size: 1.4em;
        }
        .sidebar h2 i { 
            color: #4ecdc4; 
            margin-right: 10px;
            font-size: 1.2em;
        }
        .sidebar ul { list-style: none; padding: 20px 0; }
        .sidebar ul li { margin-bottom: 5px; }
        .sidebar ul li a { 
            color: #bdc3c7; 
            text-decoration: none; 
            display: flex;
            align-items: center;
            padding: 15px 25px; 
            border-radius: 0;
            transition: all 0.3s ease;
            position: relative;
        }
        .sidebar ul li a i {
            width: 20px;
            margin-right: 15px;
            text-align: center;
        }
        .sidebar ul li a:hover { 
            background: linear-gradient(90deg, rgba(255,255,255,0.1), transparent);
            color: #fff;
            padding-left: 30px;
        }
        .sidebar ul li a.active { 
            background: linear-gradient(90deg, #4ecdc4, rgba(78, 205, 196, 0.3));
            color: #fff;
            border-left: 4px solid #4ecdc4;
        }
        
        /* Main content styling */
        .main-content { 
            flex-grow: 1; 
            background: #f8f9fa;
            min-height: 100vh;
        }
        .header { 
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            padding: 20px 30px; 
            border-bottom: 1px solid #e9ecef;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex; 
            justify-content: space-between; 
            align-items: center;
        }
        .header h1 { 
            margin: 0; 
            font-size: 2em; 
            color: #2c3e50;
            font-weight: 600;
        }
        .header .user-info {
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 500;
        }
        .header .user-info i {
            margin-right: 8px;
        }
        
        .content-area { 
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        /* Button styling */
        .btn { 
            padding: 12px 24px; 
            border-radius: 8px; 
            cursor: pointer; 
            text-decoration: none; 
            display: inline-block;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            font-size: 14px;
        }
        .btn-primary { 
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            color: white;
            box-shadow: 0 4px 15px rgba(78, 205, 196, 0.3);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(78, 205, 196, 0.4);
        }
        .btn-danger { 
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        }
        .btn-warning { 
            background: linear-gradient(135deg, #feca57, #ff9ff3);
            color: white;
            box-shadow: 0 4px 15px rgba(254, 202, 87, 0.3);
        }
        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(254, 202, 87, 0.4);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        /* Table styling */
        .table-admin { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .table-admin th { 
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .table-admin td { 
            padding: 15px;
            border-bottom: 1px solid #f1f3f4;
            vertical-align: middle;
        }
        .table-admin tr:hover {
            background-color: #f8f9fa;
        }
        .table-admin tr:last-child td {
            border-bottom: none;
        }
        
        /* Form styling */
        .form-group { 
            margin-bottom: 25px;
        }
        .form-group label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group input[type="url"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: white;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #4ecdc4;
            box-shadow: 0 0 0 3px rgba(78, 205, 196, 0.1);
        }
        .form-group textarea { 
            resize: vertical; 
            min-height: 100px;
        }
        
        /* Alert styling */
        .alert-success { 
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724; 
            border: 1px solid #c3e6cb; 
            padding: 15px 20px; 
            border-radius: 8px; 
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }
        .alert-error { 
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24; 
            border: 1px solid #f5c6cb; 
            padding: 15px 20px; 
            border-radius: 8px; 
            margin-bottom: 20px;
            border-left: 4px solid #dc3545;
        }
        .alert-info { 
            background: linear-gradient(135deg, #d1ecf1, #bee5eb);
            color: #0c5460; 
            border: 1px solid #bee5eb; 
            padding: 15px 20px; 
            border-radius: 8px; 
            margin-bottom: 20px;
            border-left: 4px solid #17a2b8;
        }
        
        /* Pagination styling */
        .pagination-container { 
            margin-top: 30px; 
            text-align: center;
        }
        .pagination-info {
            margin-bottom: 15px;
            color: #6c757d;
            font-weight: 500;
        }
        .pagination { 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            gap: 8px;
        }
        .pagination .btn { 
            padding: 10px 15px; 
            text-decoration: none; 
            border: 2px solid #e9ecef; 
            color: #495057; 
            display: inline-block;
            border-radius: 8px;
            min-width: 45px;
            text-align: center;
        }
        .pagination .btn:hover { 
            background: #4ecdc4;
            color: white;
            border-color: #4ecdc4;
        }
        .pagination .btn-primary {
            background: #4ecdc4;
            color: white;
            border-color: #4ecdc4;
        }
        .pagination span { 
            padding: 10px 15px;
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .admin-container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                order: 2;
            }
            .main-content {
                order: 1;
            }
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="sidebar">
            <h2><i class="fas fa-paw"></i>Pet Shop</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/products/list" class="${requestScope.currentPage == 'products' ? 'active' : ''}">
                    <i class="fas fa-box"></i>Quản lý Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/items/list" class="${requestScope.currentPage == 'items' ? 'active' : ''}">
                    <i class="fas fa-shopping-bag"></i>Quản lý Mặt hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/vouchers/list" class="${requestScope.currentPage == 'vouchers' ? 'active' : ''}">
                    <i class="fas fa-tags"></i>Quản lý Khuyến mãi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/pets/list" class="${requestScope.currentPage == 'pets' ? 'active' : ''}">
                    <i class="fas fa-heart"></i>Quản lý Thú cưng</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i>Đăng xuất</a></li>
            </ul>
        </div>
        <div class="main-content">
            <div class="header">
                <h1>${pageHeader}</h1>
                <div class="user-info">
                    <i class="fas fa-user-shield"></i>
                    Xin chào, ${sessionScope.displayName} (${sessionScope.roleDisplay})
                </div>
            </div>
            <div class="content-area">
                <!-- Add role-based info -->
                <c:if test="${sessionScope.role == 'Staff'}">
                    <div class="alert-info">
                        <i class="fas fa-info-circle"></i>
                        Bạn đang ở chế độ chỉ xem. Không thể thêm, sửa, xóa dữ liệu.
                    </div>
                </c:if>
                <jsp:doBody/>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>