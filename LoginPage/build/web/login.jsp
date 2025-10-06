<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Đăng nhập</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<div class="container">
    <h2>Đăng nhập</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form action="login" method="post" class="form-box">
        <input type="text" name="identifier" placeholder="Username / Email / Phone" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Đăng nhập</button>
    </form>

    <p>Bạn chưa có tài khoản? <a href="signup.jsp">Đăng ký</a></p>
</div>
</body>
</html>