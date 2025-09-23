<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Vai trò & Quyền - PetShop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .admin-badge { background-color: #dc3545; }
        .manager-badge { background-color: #198754; }
        .form-container {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3><i class="bi bi-people-fill"></i> Quản lý Vai trò & Quyền</h3>
            <div>
                <span class="badge bg-primary">Người dùng: ${sessionScope.user.username}</span>
                <a href="index.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-house"></i> Trang chủ
                </a>
            </div>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show">
                <i class="bi bi-check-circle"></i> ${param.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="bi bi-exclamation-triangle"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="table-container">
            <h5 class="mb-3"><i class="bi bi-table"></i> Danh sách người dùng</h5>
            
            <c:choose>
                <c:when test="${not empty users}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Tên đăng nhập</th>
                                    <th>Vai trò</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}" varStatus="status">
                                    <tr>
                                        <td>${status.count}</td>
                                        <td>
                                            <i class="bi bi-person-circle"></i> 
                                            <strong>${fn:escapeXml(user.username)}</strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.role eq 'ADMIN'}">
                                                    <span class="badge admin-badge">
                                                        <i class="bi bi-shield-check"></i> ADMIN
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge manager-badge">
                                                        <i class="bi bi-person-badge"></i> MANAGER
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">
                                                <i class="bi bi-check-circle"></i> Hoạt động
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${user.username ne sessionScope.user.username}">
                                                <form action="roles" method="post" style="display:inline;" 
                                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa người dùng ${fn:escapeXml(user.username)}?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="username" value="${fn:escapeXml(user.username)}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash"></i> Xóa
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${user.username eq sessionScope.user.username}">
                                                <span class="text-muted small">
                                                    <i class="bi bi-info-circle"></i> Tài khoản hiện tại
                                                </span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="bi bi-inbox" style="font-size: 3rem; color: #6c757d;"></i>
                        <p class="text-muted mt-2">Không có người dùng nào.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="form-container">
            <h5 class="mb-3"><i class="bi bi-person-plus"></i> Thêm người dùng mới</h5>
            <form action="roles" method="post">
                <input type="hidden" name="action" value="add">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label for="username" class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" name="username" id="username" class="form-control" 
                                   placeholder="Nhập tên đăng nhập" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" name="password" id="password" class="form-control" 
                                   placeholder="Nhập mật khẩu" required>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label for="role" class="form-label">Vai trò <span class="text-danger">*</span></label>
                        <select name="role" id="role" class="form-select" required>
                            <option value="">Chọn vai trò</option>
                            <option value="ADMIN">ADMIN</option>
                            <option value="MANAGER">MANAGER</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-success d-block w-100">
                            <i class="bi bi-plus-circle"></i> Thêm
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
