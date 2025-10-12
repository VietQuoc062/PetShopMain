<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Đăng nhập - Pet Shop Admin</title>
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
      }
      .login-container {
        background: white;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        text-align: center;
      }
      .login-header {
        margin-bottom: 30px;
      }
      .login-header h1 {
        color: #2c3e50;
        margin-bottom: 10px;
        font-size: 2em;
      }
      .login-header .icon {
        font-size: 3em;
        color: #4ecdc4;
        margin-bottom: 10px;
      }
      .form-group {
        margin-bottom: 20px;
        text-align: left;
      }
      .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #2c3e50;
        font-weight: 600;
      }
      .form-group input {
        width: 100%;
        padding: 15px;
        border: 2px solid #e9ecef;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
      }
      .form-group input:focus {
        outline: none;
        border-color: #4ecdc4;
        box-shadow: 0 0 0 3px rgba(78, 205, 196, 0.1);
      }
      .btn-login {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, #4ecdc4, #44a08d);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
      }
      .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(78, 205, 196, 0.4);
      }
      .alert-error {
        background: linear-gradient(135deg, #f8d7da, #f5c6cb);
        color: #721c24;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
        border-left: 4px solid #dc3545;
      }
      .demo-accounts {
        margin-top: 30px;
        padding: 20px;
        background: #f8f9fa;
        border-radius: 10px;
        font-size: 14px;
      }
      .demo-accounts h3 {
        color: #2c3e50;
        margin-bottom: 15px;
      }
      .demo-accounts p {
        margin-bottom: 5px;
        color: #6c757d;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <div class="login-header">
        <div class="icon">
          <i class="fas fa-paw"></i>
        </div>
        <h1>Pet Shop</h1>
        <p>Đăng nhập hệ thống</p>
      </div>

      <c:if test="${not empty error}">
        <div class="alert-error">
          <i class="fas fa-exclamation-triangle"></i>
          <c:choose>
            <c:when test="${error == 'access_denied'}">
              Khách hàng không thể truy cập khu vực quản trị!
            </c:when>
            <c:otherwise> ${error} </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
          <label for="username">Tên đăng nhập:</label>
          <input type="text" id="username" name="username" required />
        </div>
        <div class="form-group">
          <label for="password">Mật khẩu:</label>
          <input type="password" id="password" name="password" required />
        </div>
        <button type="submit" class="btn-login">
          <i class="fas fa-sign-in-alt"></i>
          Đăng nhập
        </button>
      </form>

      <div class="demo-accounts">
        <!-- <h3>Tài khoản demo:</h3>
        <p><strong>Admin:</strong> owner / pass123</p>
        <p><strong>Staff:</strong> nhanvien / pass123</p>
        <p><strong>Customer:</strong> khach / pass123</p> -->
      </div>
    </div>
  </body>
</html>
