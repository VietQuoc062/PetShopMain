-- Script tạo database và bảng cho PetProject
-- Chạy script này trong SQL Server Management Studio

-- Tạo database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PetProjectDB')
BEGIN
    CREATE DATABASE PetProjectDB;
    PRINT 'Database PetProjectDB created successfully.';
END
ELSE
BEGIN
    PRINT 'Database PetProjectDB already exists.';
END

-- Sử dụng database
USE PetProjectDB;

-- Tạo bảng Reviews
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reviews' AND xtype='U')
BEGIN
    CREATE TABLE Reviews (
        id INT IDENTITY(1,1) PRIMARY KEY,
        pet_id INT NOT NULL,
        full_name NVARCHAR(100) NOT NULL,
        email NVARCHAR(100) NOT NULL,
        phone NVARCHAR(20),
        comment NVARCHAR(MAX) NOT NULL,
        rating INT DEFAULT 5,
        created_date DATETIME DEFAULT GETDATE()
    );
    PRINT 'Table Reviews created successfully.';
END
ELSE
BEGIN
    PRINT 'Table Reviews already exists.';
END

-- Kiểm tra bảng đã tạo
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Reviews'
ORDER BY ORDINAL_POSITION;

PRINT 'Database setup completed!';
