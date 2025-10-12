-- XÓA CÁC BẢNG THEO THỨ TỰ QUAN HỆ
DROP TABLE IF EXISTS CartItem;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS SupportRequest;
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS ProductCategory;
DROP TABLE IF EXISTS Promotion;
GO

---------------------------------------------------------------
-- 1. PRODUCTCATEGORY
---------------------------------------------------------------
CREATE TABLE ProductCategory (
    ProductCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);
GO

---------------------------------------------------------------
-- 2. PRODUCT
---------------------------------------------------------------
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Category NVARCHAR(100),
    Brand NVARCHAR(100),
    ProductCategoryID INT NOT NULL,
    FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 3. PROMOTION
---------------------------------------------------------------
CREATE TABLE Promotion (
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Code NVARCHAR(50) UNIQUE,
    DiscountPercent DECIMAL(5,2) CHECK (DiscountPercent BETWEEN 0 AND 100),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    ProductCategoryID INT NOT NULL,
    FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CK_Promotion_Date CHECK (StartDate < EndDate)
);
GO

---------------------------------------------------------------
-- 4. ITEM
---------------------------------------------------------------
CREATE TABLE Item (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) CHECK (Price >= 0),
    ImageUrl NVARCHAR(255),
    Status NVARCHAR(30) CHECK (Status IN (N'Còn hàng', N'Hết hàng', N'Ngừng kinh doanh')),
    Description NVARCHAR(MAX),
    ProductID INT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 5. PET
---------------------------------------------------------------
CREATE TABLE Pet (
    PetID INT IDENTITY(1,1) PRIMARY KEY,
    ItemID INT NOT NULL,
    Species NVARCHAR(100),
    Breed NVARCHAR(100),
    Age INT CHECK (Age >= 0),
    Gender NVARCHAR(10) CHECK (Gender IN (N'Male', N'Female')),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 6. ACCOUNT
---------------------------------------------------------------
CREATE TABLE Account (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    [Password] NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN (N'Customer', N'Staff', N'Owner')) DEFAULT N'Customer'
);
GO

---------------------------------------------------------------
-- 7. USER
---------------------------------------------------------------
CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN (N'Male', N'Female')) DEFAULT N'Male',
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 8. SUPPORTREQUEST
---------------------------------------------------------------
CREATE TABLE SupportRequest (
    SupportRequestID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN (N'Pending', N'Processing', N'Resolved', N'Closed')) DEFAULT N'Pending',
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES [User](UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 9. ORDER
---------------------------------------------------------------
CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(18,2) CHECK (Amount >= 0),
    ShippingAddress NVARCHAR(255),
    PaymentMethod NVARCHAR(30) CHECK (PaymentMethod IN (N'Bank_Transfer', N'Cash', N'Ewallet')),
    PaymentStatus NVARCHAR(30) CHECK (PaymentStatus IN (N'Pending', N'Paid', N'Failed', N'Refunded', N'Cancelled')) DEFAULT N'Pending',
    FOREIGN KEY (CustomerID) REFERENCES [User](UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 10. ORDERDETAIL
---------------------------------------------------------------
CREATE TABLE OrderDetail (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(18,2) CHECK (Price >= 0),
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 11. REVIEW
---------------------------------------------------------------
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ItemID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 12. CART
---------------------------------------------------------------
CREATE TABLE Cart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES [User](UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 13. CARTITEM
---------------------------------------------------------------
CREATE TABLE CartItem (
    CartItemID INT IDENTITY(1,1) PRIMARY KEY,
    CartID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    FOREIGN KEY (CartID) REFERENCES Cart(CartID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

