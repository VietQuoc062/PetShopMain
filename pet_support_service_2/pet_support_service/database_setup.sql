-- =============================================
-- SCRIPT TẠO DATABASE CHO PET SHOP SUPPORT SERVICE
-- =============================================

-- Tạo database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'supportservice')
BEGIN
    CREATE DATABASE supportservice;
END
GO

-- Sử dụng database
USE supportservice;
GO

-- Tạo bảng support_requests
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='support_requests' AND xtype='U')
BEGIN
    CREATE TABLE support_requests (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(255) NOT NULL,
        email NVARCHAR(255) NOT NULL,
        message NTEXT NOT NULL,
        status NVARCHAR(50) DEFAULT 'Pending',
        created_at DATETIME2 DEFAULT GETDATE()
    );
END
GO

-- Tạo bảng notifications  
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='notifications' AND xtype='U')
BEGIN
    CREATE TABLE notifications (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        title NVARCHAR(255) NOT NULL,
        message NTEXT NOT NULL,
        type NVARCHAR(50) DEFAULT 'INFO',
        created_at DATETIME2 DEFAULT GETDATE()
    );
END
GO

-- Thêm dữ liệu mẫu cho notifications
IF NOT EXISTS (SELECT * FROM notifications)
BEGIN
    INSERT INTO notifications (title, message, type) VALUES
    ('Khuyến mãi đặc biệt', 'Giảm 20% tất cả thức ăn cho chó mèo trong tuần này!', 'PROMOTION'),
    ('Thông báo bảo trì', 'Hệ thống sẽ bảo trì vào 2h sáng ngày mai', 'MAINTENANCE'),
    ('Sản phẩm mới', 'Đã có mặt các loại đồ chơi mới cho thú cưng!', 'NEW_PRODUCT');
END
GO

-- Kiểm tra dữ liệu
SELECT 'Tables created successfully' AS Result;
SELECT COUNT(*) AS notification_count FROM notifications;
SELECT COUNT(*) AS support_request_count FROM support_requests;
GO

PRINT 'Database setup completed successfully!';