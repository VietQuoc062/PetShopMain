-- XÓA CÁC BẢNG THEO THỨ TỰ ĐẢM BẢO KHÓA NGOẠI
DROP TABLE IF EXISTS CartItem;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS SupportRequest;
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Promotion;              -- Promotion phải xóa trước ProductCategory
DROP TABLE IF EXISTS ProductCategory;
GO

---------------------------------------------------------------
-- 1. PRODUCTCATEGORY
---------------------------------------------------------------
CREATE TABLE ProductCategory (
    ProductCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL
);
GO

---------------------------------------------------------------
-- 2. PROMOTION
---------------------------------------------------------------
CREATE TABLE Promotion (
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Code NVARCHAR(50) NULL,
    DiscountPercent DECIMAL(5,2) CHECK (DiscountPercent BETWEEN 0 AND 100),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    ProductCategoryID INT NOT NULL,
    CONSTRAINT FK_Promotion_ProductCategory FOREIGN KEY (ProductCategoryID)
        REFERENCES ProductCategory(ProductCategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CK_Promotion_Date CHECK (StartDate < EndDate)
);
GO

---------------------------------------------------------------
-- 3. ITEM
---------------------------------------------------------------
CREATE TABLE Item (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Price DECIMAL(18,2) CHECK (Price >= 0),
    ImageUrl NVARCHAR(255) NULL,
    Status NVARCHAR(50) NULL,
    Description NVARCHAR(MAX) NULL
);
GO

---------------------------------------------------------------
-- 4. PRODUCT
---------------------------------------------------------------
CREATE TABLE Product (
    ItemID INT PRIMARY KEY,
    Category NVARCHAR(100) NULL,
    Brand NVARCHAR(100) NULL,
    ProductCategoryID INT NULL,
    CONSTRAINT FK_Product_Item FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Product_ProductCategory FOREIGN KEY (ProductCategoryID)
        REFERENCES ProductCategory(ProductCategoryID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 5. PET
---------------------------------------------------------------
CREATE TABLE Pet (
    ItemID INT PRIMARY KEY,
    Species NVARCHAR(100) NULL,
    Breed NVARCHAR(100) NULL,
    Age INT CHECK (Age >= 0) NULL,
    Gender NVARCHAR(10) CHECK (Gender IN (N'Male', N'Female')) NULL,
    CONSTRAINT FK_Pet_Item FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 6. ACCOUNT
---------------------------------------------------------------
CREATE TABLE Account (
    AccountID NVARCHAR(50) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    [Password] NVARCHAR(200) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN (N'Customer', N'Staff', N'Owner')) DEFAULT N'Customer'
);
GO

---------------------------------------------------------------
-- 7. USER
---------------------------------------------------------------
CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID NVARCHAR(50) NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN (N'Male', N'Female')) NULL,
    Email NVARCHAR(200) NULL UNIQUE,
    Phone NVARCHAR(20) NULL,
    Address NVARCHAR(255) NULL,
    CONSTRAINT FK_User_Account FOREIGN KEY (AccountID)
        REFERENCES Account(AccountID)
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
    CONSTRAINT FK_SupportRequest_User FOREIGN KEY (CustomerID)
        REFERENCES [User](UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

---------------------------------------------------------------
-- 9. [ORDER]
---------------------------------------------------------------
CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(18,2) CHECK (Amount >= 0) NULL,
    ShippingAddress NVARCHAR(255) NULL,
    PaymentMethod NVARCHAR(30) CHECK (PaymentMethod IN (N'Bank_Transfer', N'Cash', N'Ewallet')) NULL,
    PaymentStatus NVARCHAR(30) CHECK (PaymentStatus IN (N'Pending', N'Paid', N'Failed', N'Refunded', N'Cancelled')) DEFAULT N'Pending',
    CONSTRAINT FK_Order_User FOREIGN KEY (CustomerID)
        REFERENCES [User](UserID)
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
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderID)
        REFERENCES [Order](OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_OrderDetail_Item FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
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
    Comment NVARCHAR(MAX) NULL,
    ReviewDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Review_Item FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Review_User FOREIGN KEY (UserID)
        REFERENCES [User](UserID)
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
    CONSTRAINT FK_Cart_User FOREIGN KEY (CustomerID)
        REFERENCES [User](UserID)
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
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY (CartID)
        REFERENCES Cart(CartID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_CartItem_Item FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO


/* ======================================= */
/* PHẦN INSERT DATA ĐÃ SỬA LỖI */
/* ======================================= */

INSERT INTO ProductCategory (Name, Description) VALUES
(N'Thức ăn cho chó', N'Sản phẩm dinh dưỡng dành cho chó'),
(N'Thức ăn cho mèo', N'Sản phẩm dinh dưỡng dành cho mèo'),
(N'Thức ăn cho cá', N'Thức ăn dạng viên và mảnh cho cá cảnh'),
(N'Thức ăn cho chim', N'Hạt và vitamin cho chim cảnh'),
(N'Thức ăn cho thỏ', N'Thức ăn khô và rau củ dành cho thỏ cảnh'),
(N'Phụ kiện cho chó', N'Dây dắt, vòng cổ, quần áo cho chó'),
(N'Phụ kiện cho mèo', N'Cát vệ sinh, đồ chơi, nhà mèo'),
(N'Phụ kiện cho cá', N'Máy lọc, cây cảnh, hồ cá mini'),
(N'Phụ kiện cho chim', N'Lồng, cóng nước, gương treo cho chim'),
(N'Sữa tắm thú cưng', N'Sữa tắm và dưỡng lông cho chó mèo'),
(N'Thuốc và vitamin', N'Thuốc thú y và vitamin bổ sung'),
(N'Lồng nuôi', N'Lồng sắt, nhựa, gỗ dành cho thú cưng'),
(N'Đồ chơi thú cưng', N'Bóng, xương, chuột nhựa dành cho thú cưng'),
(N'Đồ ăn vặt', N'Bánh thưởng và snack cho chó mèo'),
(N'Dụng cụ chăm sóc', N'Lược chải, kéo tỉa lông, bàn chải răng cho thú cưng'),
(N'Sản phẩm vệ sinh', N'Khăn lau, nước khử mùi, dung dịch vệ sinh'),
(N'Vật dụng huấn luyện', N'Khay đi vệ sinh, còi huấn luyện, vòng cổ thông minh'),
(N'Phụ kiện thời trang', N'Quần áo, nơ, kính mát cho thú cưng'),
(N'Giường và ổ nằm', N'Đệm, giường, ổ nằm các loại cho thú cưng'),
(N'Đồ dùng di chuyển', N'Balo, giỏ xách, xe đẩy cho thú cưng');


INSERT INTO Promotion (Name, Code, DiscountPercent, StartDate, EndDate, ProductCategoryID) VALUES
(N'Giảm giá thức ăn cho chó', N'DOGFOOD10', 10.00, '2025-10-01', '2025-10-31', 1),
(N'Khuyến mãi thức ăn mèo', N'CATFOOD15', 15.00, '2025-10-01', '2025-10-31', 2),
(N'Thức ăn cá cảnh giảm 5%', N'FISH05', 5.00, '2025-10-05', '2025-10-25', 3),
(N'Ưu đãi cho chim cảnh', N'BIRD10', 10.00, '2025-09-20', '2025-10-20', 4),
(N'Giảm giá thức ăn cho thỏ', N'RABBIT12', 12.00, '2025-10-02', '2025-10-22', 5),
(N'Giảm phụ kiện cho chó', N'DOGACC20', 20.00, '2025-10-03', '2025-10-30', 6),
(N'Giảm phụ kiện cho mèo', N'CATACC10', 10.00, '2025-10-04', '2025-10-25', 7),
(N'Giảm phụ kiện hồ cá', N'FISHTANK15', 15.00, '2025-10-01', '2025-10-31', 8),
(N'Lồng chim ưu đãi', N'BIRDCAGE20', 20.00, '2025-10-06', '2025-10-26', 9),
(N'Sữa tắm thú cưng', N'SHAMPOO08', 8.00, '2025-09-28', '2025-10-18', 10),
(N'Thuốc và vitamin', N'VITAPET25', 25.00, '2025-10-01', '2025-11-01', 11),
(N'Lồng nuôi giảm 15%', N'CAGE15', 15.00, '2025-09-30', '2025-10-20', 12),
(N'Đồ chơi thú cưng', N'TOY10', 10.00, '2025-10-05', '2025-11-05', 13),
(N'Snack cho chó mèo', N'SNACK07', 7.00, '2025-10-02', '2025-10-30', 14),
(N'Dụng cụ chăm sóc', N'CARE18', 18.00, '2025-09-25', '2025-10-25', 15),
(N'Sản phẩm vệ sinh', N'CLEAN10', 10.00, '2025-10-01', '2025-10-31', 16),
(N'Vật dụng huấn luyện', N'TRAIN20', 20.00, '2025-10-01', '2025-11-01', 17),
(N'Phụ kiện thời trang', N'FASHION30', 30.00, '2025-10-03', '2025-10-31', 18),
(N'Giường ổ nằm', N'BED15', 15.00, '2025-10-04', '2025-10-24', 19),
(N'Đồ dùng di chuyển', N'TRAVEL12', 12.00, '2025-10-05', '2025-10-25', 20);

-- BẢNG ITEM: 26 dòng cho Sản phẩm & Phụ kiện
INSERT INTO Item (Name, Price, ImageUrl, Status, Description) VALUES
(N'Hạt Pedigree vị bò 1.5kg', 95000, N'/images/dogfood1.jpg', N'Còn hàng', N'Thức ăn hạt Pedigree vị bò cho chó trưởng thành'), -- ItemID 1
(N'Hạt Pedigree vị gà 3kg', 250000, N'/images/dogfood2.jpg', N'Còn hàng', N'Thức ăn hạt vị gà, bổ sung vitamin cho chó'), -- ItemID 2
(N'Thức ăn Whiskas mèo con 1.2kg', 120000, N'/images/catfood1.jpg', N'Còn hàng', N'Thức ăn ướt Whiskas vị cá ngừ cho mèo con'), -- ItemID 3
(N'Thức ăn Whiskas mèo lớn 3kg', 270000, N'/images/catfood2.jpg', N'Hết hàng', N'Thức ăn Whiskas vị cá hồi cho mèo lớn'), -- ItemID 4
(N'Viên Tetra Bits 500mg', 95000, N'/images/fishfood1.jpg', N'Còn hàng', N'Thức ăn viên nổi cho cá cảnh Tetra Bits'), -- ItemID 5
(N'Thức ăn TetraMin 100mg', 65000, N'/images/fishfood2.jpg', N'Còn hàng', N'Thức ăn dạng mảnh cho cá cảnh nhỏ'), -- ItemID 6
(N'Hạt Vitakraft cho chim', 85000, N'/images/birdfood1.jpg', N'Còn hàng', N'Hạt dinh dưỡng dành cho chim yến phụng'), -- ItemID 7
(N'Hạt Versele-Laga cho chim họa mi', 99000, N'/images/birdfood2.jpg', N'Còn hàng', N'Thức ăn cao cấp cho chim hót'), -- ItemID 8
(N'Thức ăn cho thỏ 1kg', 80000, N'/images/rabbit1.jpg', N'Còn hàng', N'Hỗn hợp rau củ khô cho thỏ cảnh'), -- ItemID 9
(N'Dây dắt cho chó nhỏ', 45000, N'/images/dogleash1.jpg', N'Còn hàng', N'Dây dắt bằng vải bền, phù hợp cho chó nhỏ'), -- ItemID 10
(N'Vòng cổ chống rụng lông', 55000, N'/images/dogcollar1.jpg', N'Còn hàng', N'Vòng cổ da mềm có thể điều chỉnh'), -- ItemID 11
(N'Cát vệ sinh khử mùi 5L', 90000, N'/images/catlitter1.jpg', N'Còn hàng', N'Cát vệ sinh hương oải hương cho mèo'), -- ItemID 12
(N'Nhà mèo mini', 250000, N'/images/cathouse1.jpg', N'Hết hàng', N'Nhà vải mềm cho mèo nằm ngủ'), -- ItemID 13
(N'Máy lọc nước hồ cá 10W', 180000, N'/images/fishfilter1.jpg', N'Còn hàng', N'Máy lọc nước mini dùng cho hồ cá nhỏ'), -- ItemID 14
(N'Lồng inox chim chào mào', 320000, N'/images/birdcage1.jpg', N'Còn hàng', N'Lồng tròn bằng inox sáng bóng, bền đẹp'), -- ItemID 15
(N'Sữa tắm dưỡng lông Shed Control 500ml', 115000, N'/images/shampoo1.jpg', N'Còn hàng', N'Sữa tắm giúp lông bóng mượt cho chó mèo'), -- ItemID 16
(N'Vitamin Nutripet 80g', 130000, N'/images/vitamin1.jpg', N'Còn hàng', N'Bổ sung vitamin và khoáng chất cho mèo'), -- ItemID 17
(N'Lồng sắt gấp gọn size M', 400000, N'/images/cage1.jpg', N'Còn hàng', N'Lồng sắt sơn tĩnh điện, dễ gấp gọn'), -- ItemID 18
(N'Bóng cao su phát sáng', 35000, N'/images/toy1.jpg', N'Còn hàng', N'Bóng cao su phát sáng, chống cắn, bền'), -- ItemID 19
(N'Snack gà sấy 100g', 55000, N'/images/snack1.jpg', N'Còn hàng', N'Snack thưởng vị gà sấy khô cho chó'), -- ItemID 20
(N'Lược chải lông thép nhỏ', 70000, N'/images/brush1.jpg', N'Còn hàng', N'Lược thép không gỉ dùng cho mèo và chó nhỏ'), -- ItemID 21
(N'Nước khử mùi chuồng 500ml', 90000, N'/images/cleaner1.jpg', N'Còn hàng', N'Dung dịch khử mùi hôi chuồng thú cưng'), -- ItemID 22
(N'Khay vệ sinh huấn luyện chó', 160000, N'/images/tray1.jpg', N'Còn hàng', N'Khay nhựa chống trượt, dễ vệ sinh'), -- ItemID 23
(N'Áo len cho mèo mùa đông', 120000, N'/images/clothes1.jpg', N'Còn hàng', N'Áo len ấm, co giãn tốt, dành cho mèo cưng'), -- ItemID 24
(N'Giường nệm êm size S', 180000, N'/images/bed1.jpg', N'Còn hàng', N'Giường nệm bông mềm cho chó nhỏ'), -- ItemID 25
(N'Balo mang mèo trong suốt', 350000, N'/images/bag1.jpg', N'Còn hàng', N'Balo có lỗ thoáng khí, phù hợp đi chơi xa'); -- ItemID 26


-- BẢNG PRODUCT: ItemID từ 1 đến 20
INSERT INTO Product (ItemID, Category, Brand, ProductCategoryID) VALUES
(1, N'Thức ăn hạt cho chó trưởng thành', N'Pedigree', 1),
(2, N'Thức ăn ướt cho mèo con', N'Whiskas', 2),
(3, N'Thức ăn viên cho cá cảnh', N'Tetra', 3),
(4, N'Thức ăn cho chim yến phụng', N'Vitakraft', 4),
(5, N'Thức ăn hỗn hợp cho thỏ', N'Versele-Laga', 5),
(6, N'Dây dắt và vòng cổ cho chó nhỏ', N'PetCare', 6),
(7, N'Cát vệ sinh khử mùi cho mèo', N'MeoWow', 7),
(8, N'Máy lọc nước hồ cá mini', N'Sunsun', 8),
(9, N'Lồng inox cho chim chào mào', N'HappyBird', 9),
(10, N'Sữa tắm dưỡng lông cho chó', N'Benny''s', 10),
(11, N'Vitamin tổng hợp cho mèo', N'Nutripet', 11),
(12, N'Lồng sắt gấp gọn cho chó', N'PetHouse', 12),
(13, N'Bóng cao su phát sáng cho thú cưng', N'Kong', 13),
(14, N'Snack gà sấy cho chó', N'JerHigh', 14),
(15, N'Lược chải lông thép không gỉ', N'Trixie', 15),
(16, N'Nước khử mùi chuồng thú cưng', N'BioPet', 16),
(17, N'Khay huấn luyện đi vệ sinh cho chó', N'Savic', 17),
(18, N'Áo len mùa đông cho mèo', N'PetFashion', 18),
(19, N'Giường nệm mềm cho chó cỡ nhỏ', N'ComfyPet', 19),
(20, N'Balo mang mèo trong suốt', N'MiPet', 20);


-- BẢNG ITEM: Thêm 20 thú cưng (ItemID 27 - 46)
INSERT INTO Item (Name, Price, ImageUrl, Status, Description) VALUES
(N'Chó Corgi thuần chủng', 15000000, N'/images/pet_corgi.jpg', N'Còn hàng', N'Corgi 1 tuổi, đăng ký từ đời.'), -- ItemID 27
(N'Mèo Anh lông ngắn', 8000000, N'/images/pet_aln.jpg', N'Còn hàng', N'Mèo Anh lông ngắn 2 tuổi, Rất thân thiện.'), -- ItemID 28
(N'Chó Poodle Tiny', 10000000, N'/images/pet_poodle.jpg', N'Còn hàng', N'Poodle Tiny, tiêm chủng đủ đủ'), -- ItemID 29
(N'Mèo Ba Tư lông dài', 12000000, N'/images/pet_persian.jpg', N'Còn hàng', N'Mèo Ba Tư 3 tuổi, lông rất mượt.'), -- ItemID 30
(N'Chó Husky trưởng thành', 18000000, N'/images/pet_husky.jpg', N'Còn hàng', N'Husky 2 tuổi, năng động, thích chơi.'), -- ItemID 31
(N'Mèo Mướp Việt Nam', 1500000, N'/images/pet_mup.jpg', N'Còn hàng', N'Mèo Mướp 1 tuổi, dễ nuôi vật nuôi.'), -- ItemID 32
(N'Chó Golden Retriever', 20000000, N'/images/pet_golden.jpg', N'Còn hàng', N'Golden 2 tuổi, thông minh.'), -- ItemID 33
(N'Mèo Xiêm thuần chủng', 9000000, N'/images/pet_siamese.jpg', N'Còn hàng', N'Mèo Xiêm 2 tuổi, dễ ăn.'), -- ItemID 34
(N'Chó Chihuahua', 8500000, N'/images/pet_chihuahua.jpg', N'Còn hàng', N'Chihuahua 1 tuổi, nhỏ gọn.'), -- ItemID 35
(N'Mèo Mỹ lông ngắn', 11000000, N'/images/pet_aml.jpg', N'Còn hàng', N'Mèo Mỹ lông ngắn 3 tuổi.'), -- ItemID 36
(N'Chó Beagle', 14000000, N'/images/pet_beagle.jpg', N'Còn hàng', N'Beagle 2 tuổi, tinh nghịch.'), -- ItemID 37
(N'Mèo Maine Coon', 25000000, N'/images/pet_mainecoon.jpg', N'Còn hàng', N'Maine Coon 3 tuổi, lớn con.'), -- ItemID 38
(N'Chó Shiba Inu', 22000000, N'/images/pet_shiba.jpg', N'Còn hàng', N'Shiba Inu 2 tuổi, thân thiện.'), -- ItemID 39
(N'Mèo Scottish Fold', 18000000, N'/images/pet_scottish.jpg', N'Còn hàng', N'Scottish Fold 1 tuổi, tai cụp.'), -- ItemID 40
(N'Chó Pug', 9500000, N'/images/pet_pug.jpg', N'Còn hàng', N'Pug 4 tuổi, mặt ngầu.'), -- ItemID 41
(N'Chó Doberman', 28000000, N'/images/pet_doberman.jpg', N'Còn hàng', N'Doberman 3 tuổi, trung thành.'), -- ItemID 42
(N'Mèo Ragdoll', 20000000, N'/images/pet_ragdoll.jpg', N'Còn hàng', N'Ragdoll 2 tuổi, mắt xanh.'), -- ItemID 43
(N'Chó German Shepherd', 30000000, N'/images/pet_gsd.jpg', N'Còn hàng', N'German Shepherd 3 tuổi, bảo vệ tốt.'), -- ItemID 44
(N'Mèo Bengal', 27000000, N'/images/pet_bengal.jpg', N'Còn hàng', N'Bengal 1 tuổi, nhanh nhẹn.'), -- ItemID 45
(N'Chó Samoyed', 35000000, N'/images/pet_samoyed.jpg', N'Còn hàng', N'Samoyed 2 tuổi, lông trắng tuyệt.'); -- ItemID 46

-- BẢNG PET: ItemID từ 27 đến 46
INSERT INTO Pet (ItemID, Species, Breed, Age, Gender)
VALUES
(27, N'Chó', N'Corgi', 1, N'Male'),
(28, N'Mèo', N'Anh lông ngắn', 2, N'Female'),
(29, N'Chó', N'Poodle', 1, N'Male'),
(30, N'Mèo', N'Ba Tư', 3, N'Female'),
(31, N'Chó', N'Husky', 2, N'Male'),
(32, N'Mèo', N'Mướp', 1, N'Female'),
(33, N'Chó', N'Golden Retriever', 2, N'Male'),
(34, N'Mèo', N'Xiêm', 2, N'Female'),
(35, N'Chó', N'Chihuahua', 1, N'Male'),
(36, N'Mèo', N'Mỹ lông ngắn', 3, N'Female'),
(37, N'Chó', N'Beagle', 2, N'Male'),
(38, N'Mèo', N'Maine Coon', 3, N'Female'),
(39, N'Chó', N'Shiba Inu', 2, N'Male'),
(40, N'Mèo', N'Scottish Fold', 1, N'Female'),
(41, N'Chó', N'Pug', 4, N'Female'),
(42, N'Chó', N'Doberman', 3, N'Male'),
(43, N'Mèo', N'Ragdoll', 2, N'Female'),
(44, N'Chó', N'German Shepherd', 3, N'Male'),
(45, N'Mèo', N'Bengal', 1, N'Female'),
(46, N'Chó', N'Samoyed', 2, N'Male');


INSERT INTO Account (AccountID, Username, [Password], Role)
VALUES
(N'Tien', N'Tien', N'pass123', N'Customer'),
(N'Khanh', N'Khanh', N'pass123', N'Customer'),
(N'Bao', N'Bao', N'pass123', N'Customer'),
(N'Quoc', N'Quoc', N'pass123', N'Customer'),
(N'Tung', N'Tung', N'pass123', N'Customer'),
(N'Khach', N'Khach', N'pass123', N'Customer'),
(N'Trung', N'Trung', N'pass123', N'Customer'),
(N'Hau', N'Hau', N'pass123', N'Customer'),
(N'Ngan', N'Ngan', N'pass123', N'Customer'),
(N'Tri', N'Tri', N'pass123', N'Customer'),
(N'Tai', N'Tai', N'pass123', N'Staff'),
(N'NhanVien', N'NhanVien', N'pass123', N'Staff'),
(N'Trang', N'Trang', N'pass123', N'Staff'),
(N'Dung', N'Dung', N'pass123', N'Staff'),
(N'Bich', N'Bich', N'pass123', N'Staff'),
(N'Owner', N'Owner', N'pass123', N'Owner');

-- BẢNG USER: ĐÃ SỬA LỖI TRUNCATED DATA TẠI DÒNG THỨ 3 (UserID 3)
INSERT INTO [User] (AccountID, Name, Gender, Email, Phone, Address)
VALUES
(N'Tien', N'Nguyễn Minh Tiến', N'male', N'tien@example.com', N'0901000001', N'12 Lê Lợi, Q1, TP.HCM'), -- UserID 1
(N'Khanh', N'Trần Ngọc Khánh', N'female', N'khanh@example.com', N'0901000002', N'45 Nguyễn Trãi, Q5, TP.HCM'), -- UserID 2
(N'Bao', N'Phạm Bảo', N'male', N'bao@example.com', N'0901000003', N'78 Hai Bà Trưng, Q3, TP.HCM'), -- UserID 3 (Đã sửa)
(N'Quoc', N'Lê Quốc', N'male', N'quoc@example.com', N'0901000004', N'23 Lý Thường Kiệt, Q10, TP.HCM'), -- UserID 4
(N'Tung', N'Hoàng Anh Tùng', N'male', N'tung@example.com', N'0901000005', N'90 Cách Mạng Tháng 8, Q3, TP.HCM'), -- UserID 5
(N'Khach', N'Khách Hàng Mẫu', N'female', N'khach@example.com', N'0901000006', N'56 Nguyễn Văn Cừ, Q5, TP.HCM'), -- UserID 6
(N'Trung', N'Nguyễn Trung', N'male', N'trung@example.com', N'0901000007', N'102 Võ Văn Kiệt, Q1, TP.HCM'), -- UserID 7
(N'Hau', N'Phan Hậu', N'male', N'hau@example.com', N'0901000008', N'27 Trần Hưng Đạo, Q1, TP.HCM'), -- UserID 8
(N'Ngan', N'Lê Ngân', N'female', N'ngan@example.com', N'0901000009', N'88 Hoàng Diệu, Q4, TP.HCM'), -- UserID 9
(N'Tri', N'Võ Minh Trí', N'male', N'tri@example.com', N'0901000010', N'65 Nguyễn Huệ, Q1, TP.HCM'), -- UserID 10
(N'Tai', N'Nguyễn Tài', N'male', N'tai@example.com', N'0902000011', N'102 Lạc Long Quân, Q11, TP.HCM'), -- UserID 11
(N'NhanVien', N'Nhân Viên Chung', N'female', N'nhanvien@example.com', N'0902000012', N'54 Phan Xích Long, Q.Phú Nhuận, TP.HCM'), -- UserID 12
(N'Trang', N'Trần Trang', N'female', N'trang@example.com', N'0902000013', N'89 Quang Trung, Q.Gò Vấp, TP.HCM'), -- UserID 13
(N'Dung', N'Phạm Dung', N'female', N'dung@example.com', N'0902000014', N'75 Âu Cơ, Q.Tân Bình, TP.HCM'), -- UserID 14
(N'Bich', N'Nguyễn Bích', N'female', N'bich@example.com', N'0902000015', N'23 Nguyễn Kiệm, Q.Phú Nhuận, TP.HCM'), -- UserID 15
(N'Owner', N'Chủ Shop Thú Cưng', N'male', N'owner@example.com', N'0909999999', N'01 Võ Văn Ngân, TP.Thủ Đức, TP.HCM'); -- UserID 16


-- BẢNG SupportRequest
INSERT INTO SupportRequest (CustomerID, Message, Status, CreatedDate)
VALUES
(1, N'Tôi muốn hỏi về tình trạng đơn hàng gần nhất của tôi.', N'Pending', GETDATE()),
(2, N'Cần đổi sản phẩm vì giao nhầm loại thức ăn.', N'Processing', DATEADD(DAY, -1, GETDATE())),
(3, N'Thuốc cho chó của tôi bị hư, mong được đổi trả.', N'Resolved', DATEADD(DAY, -2, GETDATE())),
(4, N'Sản phẩm bị giao trễ, xin được hỗ trợ.', N'Pending', DATEADD(DAY, -3, GETDATE())),
(5, N'Tôi cần hướng dẫn sử dụng sữa tắm cho mèo.', N'Closed', DATEADD(DAY, -4, GETDATE())),
(6, N'Tôi không nhận được mã giảm giá khi thanh toán.', N'Processing', DATEADD(DAY, -5, GETDATE())),
(7, N'Đơn hàng bị hủy nhưng chưa hoàn tiền.', N'Resolved', DATEADD(DAY, -6, GETDATE())),
(8, N'Tôi muốn góp ý về dịch vụ chăm sóc khách hàng.', N'Closed', DATEADD(DAY, -7, GETDATE())),
(9, N'Tôi muốn hỏi thêm về chính sách bảo hành.', N'Pending', DATEADD(DAY, -8, GETDATE())),
(10, N'Sản phẩm trong giỏ hàng của tôi bị lỗi khi thanh toán.', N'Processing', DATEADD(DAY, -9, GETDATE()));

-- BẢNG ORDER: Đã thay PaymentMethod bằng giá trị hợp lệ theo CHECK Constraint
INSERT INTO [Order] (CustomerID, Amount, ShippingAddress, PaymentMethod, PaymentStatus)
VALUES 
(1, 250000, N'123 Lê Lợi, TP.HCM', N'Cash', N'Paid'),
(2, 480000, N'56 Hai Bà Trưng, Hà Nội', N'Bank_Transfer', N'Pending'), -- Đã sửa Bank Transfer -> Bank_Transfer
(3, 175000, N'89 Nguyễn Huệ, Đà Nẵng', N'Ewallet', N'Paid'),
(4, 320000, N'12 Trần Phú, Cần Thơ', N'Cash', N'Paid'),
(5, 590000, N'45 Nguyễn Trãi, TP.HCM', N'Bank_Transfer', N'Cancelled'), -- Đã sửa Bank Transfer -> Bank_Transfer
(6, 210000, N'99 Hùng Vương, Huế', N'Ewallet', N'Cancelled'),
(7, 120000, N'75 Phan Chu Trinh, Hà Nội', N'Cash', N'Paid'),
(8, 430000, N'21 Lê Duẩn, Đà Nẵng', N'Ewallet', N'Pending'),
(9, 310000, N'18 Nguyễn Văn Cừ, TP.HCM', N'Cash', N'Cancelled'),
(10, 275000, N'67 Lê Lợi, Hải Phòng', N'Bank_Transfer', N'Paid'); -- Đã sửa Bank Transfer -> Bank_Transfer

-- BẢNG OrderDetail
INSERT INTO OrderDetail (OrderID, ItemID, Quantity, Price)
VALUES
(1, 1, 2, 95000),    -- Đã dùng giá thực của ItemID 1 (95000)
(2, 3, 1, 120000),   -- Đã dùng giá thực của ItemID 3 (120000)
(3, 2, 5, 250000),   -- Đã dùng giá thực của ItemID 2 (250000)
(4, 4, 3, 270000),   -- Đã dùng giá thực của ItemID 4 (270000)
(5, 5, 1, 95000),    -- Đã dùng giá thực của ItemID 5 (95000)
(6, 7, 2, 85000),    -- Đã dùng giá thực của ItemID 7 (85000)
(7, 6, 4, 65000),    -- Đã dùng giá thực của ItemID 6 (65000)
(8, 8, 2, 99000),    -- Đã dùng giá thực của ItemID 8 (99000)
(9, 9, 1, 80000),    -- Đã dùng giá thực của ItemID 9 (80000)
(10, 10, 5, 45000);  -- Đã dùng giá thực của ItemID 10 (45000)

INSERT INTO Review (ItemID, UserID, Rating, Comment)
VALUES
(27, 1, 5, N'Chó Corgi rất ngoan và dễ thương, giao hàng nhanh.'),
(28, 3, 4, N'Mèo Anh lông ngắn đẹp, lông mượt nhưng hơi nhát.'),
(18, 4, 5, N'Áo vừa vặn, chất liệu tốt, thú cưng rất thích.'),
(2, 5, 3, N'Sản phẩm hạt Pedigree ổn, nhưng giao hơi chậm.'),
(10, 6, 5, N'Dây dắt chắc chắn, màu đẹp.'),
(3, 7, 4, N'Thức ăn Whiskas chất lượng, thú cưng ăn ngon miệng.'),
(30, 8, 2, N'Mèo Ba Tư không giống hình, hơi thất vọng.'),
(16, 9, 5, N'Nước tắm thơm, dùng xong lông bóng mượt.'),
(35, 2, 4, N'Chó Chihuahua đáng yêu, cần được chăm sóc thêm.'),
(25, 10, 5, N'Giường nệm rất hài lòng, shop tư vấn nhiệt tình và giao đúng hẹn.');

INSERT INTO Cart (CustomerID)
VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO CartItem (CartID, ItemID, Quantity)
VALUES
(1, 1, 2), (1, 3, 1), (2, 4, 1), (2, 6, 3), (3, 5, 1), 
(3, 7, 2), (4, 2, 1), (4, 8, 2), (5, 9, 1), (5, 10, 4), 
(6, 3, 1), (7, 6, 2), (8, 1, 1), (9, 7, 1), (10, 5, 2);

