-- 1. Bảng user_roles (giả lập enum)
CREATE TABLE user_roles (
    id INT IDENTITY(1,1) PRIMARY KEY,
    role_name NVARCHAR(20) UNIQUE NOT NULL
);

-- 2. Bảng accounts (thông tin đăng nhập)
CREATE TABLE accounts (
    id NVARCHAR(20) PRIMARY KEY, -- kiểu chuỗi như 'CUS001'
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(100) NOT NULL,
    role NVARCHAR(20) NOT NULL,
    FOREIGN KEY (role) REFERENCES user_roles(role_name)
);

-- 3. Bảng users (thông tin cá nhân)
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    account_id NVARCHAR(20) NOT NULL,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    gender NVARCHAR(10),
    email NVARCHAR(100),
    phone NVARCHAR(20),
    address NVARCHAR(MAX),
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);
INSERT INTO users (account_id, first_name, last_name, gender, email, phone, address)
VALUES 
(N'CUS001', N'Quoc', N'Nguyen', N'Male', N'quoc@gmail.com', N'0123456789', N'Nha Trang'),
(N'STA001', N'An', N'Nguyen', N'Female', N'an@gmail.com', N'0987654321', N'Cam Ranh'),
(N'OWN001', N'Trum', N'Admin', N'Male', N'trum@gmail.com', N'0251616878', N'Dien Khanh');

