<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pet Project Test</title>
</head>
<body>
    <h1>🎉 Pet Project Deploy Test</h1>
    <p>Thời gian: <%= new java.util.Date() %></p>
    <p>✅ JSP hoạt động bình thường!</p>
    
    <hr>
    
    <h2>Test Links:</h2>
    <ul>
        <li><a href="petDetail.jsp">Pet Detail Page</a></li>
        <li><a href="pet-detail?id=1">Pet Detail Servlet</a></li>
    </ul>
    
    <hr>
    
    <h2>Debug Info:</h2>
    <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
    <p><strong>Server Info:</strong> <%= application.getServerInfo() %></p>
    <p><strong>Servlet Context:</strong> <%= application.getServletContextName() %></p>
</body>
</html>