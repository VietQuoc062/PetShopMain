<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Truy cập bị từ chối</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-content {
            text-align: center;
            max-width: 500px;
            padding: 2rem;
        }
        .warning-icon {
            font-size: 4rem;
            color: #ffc107;
            margin-bottom: 1rem;
        }
        .error-title {
            color: #dc3545;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        .error-message {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        .btn-back {
            background-color: #007bff;
            border-color: #007bff;
            padding: 10px 20px;
            font-size: 1rem;
        }
        .btn-back:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-content">
            <div class="warning-icon">⚠️</div>
            <h1 class="error-title">Truy cập bị từ chối</h1>
            <p class="error-message">Bạn không đủ quyền hạn để truy cập trang này.</p>
            <a href="index.jsp" class="btn btn-primary btn-back">
                ← Quay lại trang chủ
            </a>
        </div>
    </div>
</body>
</html>
