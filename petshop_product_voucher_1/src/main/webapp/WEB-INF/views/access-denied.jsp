<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Truy cập bị từ chối - Pet Shop</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
      }
      .access-denied-container {
        background: white;
        padding: 50px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        text-align: center;
        max-width: 500px;
        width: 100%;
      }
      .error-icon {
        font-size: 4em;
        color: #ff6b6b;
        margin-bottom: 20px;
        animation: shake 0.5s ease-in-out;
      }
      @keyframes shake {
        0%,
        100% {
          transform: translateX(0);
        }
        25% {
          transform: translateX(-10px);
        }
        75% {
          transform: translateX(10px);
        }
      }
      .error-title {
        color: #2c3e50;
        font-size: 2em;
        margin-bottom: 20px;
        font-weight: 600;
      }
      .error-message {
        color: #6c757d;
        font-size: 1.1em;
        line-height: 1.6;
        margin-bottom: 30px;
      }
      .error-details {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
        border-left: 4px solid #ff6b6b;
      }
      .error-details p {
        margin-bottom: 10px;
        color: #495057;
      }
      .btn-container {
        display: flex;
        gap: 15px;
        justify-content: center;
        flex-wrap: wrap;
      }
      .btn {
        padding: 15px 30px;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
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
      .btn-secondary {
        background: linear-gradient(135deg, #6c757d, #545b62);
        color: white;
        box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
      }
      .btn-secondary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
      }
      .user-info {
        background: #e3f2fd;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
        color: #1976d2;
        font-weight: 500;
      }
      .user-info i {
        margin-right: 8px;
      }
    </style>
  </head>
  <body>
    <div class="access-denied-container">
      <div class="error-icon">
        <i class="fas fa-ban"></i>
      </div>

      <h1 class="error-title">Truy cập bị từ chối</h1>

      <c:if test="${not empty sessionScope.displayName}">
        <div class="user-info">
          <i class="fas fa-user"></i>
          Đăng nhập với tài khoản: ${sessionScope.displayName}
          (${sessionScope.roleDisplay})
        </div>
      </c:if>

      <div class="error-details">
        <p><strong>❌ Bạn không có quyền truy cập chức năng này.</strong></p>
        <p>Vui lòng đăng nhập với quyền phù hợp.</p>
      </div>

      <p class="error-message">
        Khu vực quản trị chỉ dành cho <strong>Quản lý</strong> và
        <strong>Nhân viên</strong>. Tài khoản khách hàng không thể truy cập vào
        phần này.
      </p>

      <div class="btn-container">
        <a
          href="${pageContext.request.contextPath}/logout"
          class="btn btn-primary"
        >
          <i class="fas fa-sign-out-alt"></i>
          Đăng xuất và đăng nhập lại
        </a>
      </div>
    </div>
  </body>
</html>
