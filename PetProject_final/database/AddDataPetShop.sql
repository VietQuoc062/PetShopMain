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

INSERT INTO Product (Category, Brand, ProductCategoryID) VALUES
(N'Thức ăn hạt cho chó trưởng thành', N'Pedigree', 1),
(N'Thức ăn ướt cho mèo con', N'Whiskas', 2),
(N'Thức ăn viên cho cá cảnh', N'Tetra', 3),
(N'Thức ăn cho chim yến phụng', N'Vitakraft', 4),
(N'Thức ăn hỗn hợp cho thỏ', N'Versele-Laga', 5),
(N'Dây dắt và vòng cổ cho chó nhỏ', N'PetCare', 6),
(N'Cát vệ sinh khử mùi cho mèo', N'MeoWow', 7),
(N'Máy lọc nước hồ cá mini', N'Sunsun', 8),
(N'Lồng inox cho chim chào mào', N'HappyBird', 9),
(N'Sữa tắm dưỡng lông cho chó', N'Benny''s', 10),
(N'Vitamin tổng hợp cho mèo', N'Nutripet', 11),
(N'Lồng sắt gấp gọn cho chó', N'PetHouse', 12),
(N'Bóng cao su phát sáng cho thú cưng', N'Kong', 13),
(N'Snack gà sấy cho chó', N'JerHigh', 14),
(N'Lược chải lông thép không gỉ', N'Trixie', 15),
(N'Nước khử mùi chuồng thú cưng', N'BioPet', 16),
(N'Khay huấn luyện đi vệ sinh cho chó', N'Savic', 17),
(N'Áo len mùa đông cho mèo', N'PetFashion', 18),
(N'Giường nệm mềm cho chó cỡ nhỏ', N'ComfyPet', 19),
(N'Balo mang mèo trong suốt', N'MiPet', 20);

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
(N'Thời trang thú cưng', N'FASHION30', 30.00, '2025-10-03', '2025-10-31', 18),
(N'Giường ổ nằm', N'BED15', 15.00, '2025-10-04', '2025-10-24', 19),
(N'Đồ dùng di chuyển', N'TRAVEL12', 12.00, '2025-10-05', '2025-10-25', 20);


INSERT INTO Item (Name, Price, ImageUrl, Status, Description, ProductID) VALUES
(N'Hạt Pedigree vị bò 1.5kg', 95000, N'/images/dogfood1.jpg', N'Còn hàng', N'Thức ăn hạt Pedigree vị bò cho chó trưởng thành', 1),
(N'Hạt Pedigree vị gà 3kg', 250000, N'/images/dogfood2.jpg', N'Còn hàng', N'Thức ăn hạt vị gà, bổ sung vitamin cho chó', 1),
(N'Thức ăn Whiskas mèo con 1.2kg', 120000, N'/images/catfood1.jpg', N'Còn hàng', N'Thức ăn ướt Whiskas vị cá ngừ cho mèo con', 2),
(N'Thức ăn Whiskas mèo lớn 3kg', 270000, N'/images/catfood2.jpg', N'Hết hàng', N'Thức ăn Whiskas vị cá hồi cho mèo lớn', 2),
(N'Viên Tetra Bits 500mg', 95000, N'/images/fishfood1.jpg', N'Còn hàng', N'Thức ăn viên nổi cho cá cảnh Tetra Bits', 3),
(N'Thức ăn TetraMin 100mg', 65000, N'/images/fishfood2.jpg', N'Còn hàng', N'Thức ăn dạng mảnh cho cá cảnh nhỏ', 3),
(N'Hạt Vitakraft cho chim', 85000, N'/images/birdfood1.jpg', N'Còn hàng', N'Hạt dinh dưỡng dành cho chim yến phụng', 4),
(N'Hạt Versele-Laga cho chim họa mi', 99000, N'/images/birdfood2.jpg', N'Còn hàng', N'Thức ăn cao cấp cho chim hót', 4),
(N'Thức ăn cho thỏ 1kg', 80000, N'/images/rabbit1.jpg', N'Còn hàng', N'Hỗn hợp rau củ khô cho thỏ cảnh', 5),
(N'Dây dắt cho chó nhỏ', 45000, N'/images/dogleash1.jpg', N'Còn hàng', N'Dây dắt bằng vải bền, phù hợp cho chó nhỏ', 6),
(N'Vòng cổ chống rụng lông', 55000, N'/images/dogcollar1.jpg', N'Còn hàng', N'Vòng cổ da mềm có thể điều chỉnh', 6),
(N'Cát vệ sinh khử mùi 5L', 90000, N'/images/catlitter1.jpg', N'Còn hàng', N'Cát vệ sinh hương oải hương cho mèo', 7),
(N'Nhà mèo mini', 250000, N'/images/cathouse1.jpg', N'Hết hàng', N'Nhà vải mềm cho mèo nằm ngủ', 7),
(N'Máy lọc nước hồ cá 10W', 180000, N'/images/fishfilter1.jpg', N'Còn hàng', N'Máy lọc nước mini dùng cho hồ cá nhỏ', 8),
(N'Lồng inox chim chào mào', 320000, N'/images/birdcage1.jpg', N'Còn hàng', N'Lồng tròn bằng inox sáng bóng, bền đẹp', 9),
(N'Sữa tắm dưỡng lông Shed Control 500ml', 115000, N'/images/shampoo1.jpg', N'Còn hàng', N'Sữa tắm giúp lông bóng mượt cho chó mèo', 10),
(N'Vitamin Nutripet 80g', 130000, N'/images/vitamin1.jpg', N'Còn hàng', N'Bổ sung vitamin và khoáng chất cho mèo', 11),
(N'Lồng sắt gấp gọn size M', 400000, N'/images/cage1.jpg', N'Còn hàng', N'Lồng sắt sơn tĩnh điện, dễ gấp gọn', 12),
(N'Bóng cao su phát sáng', 35000, N'/images/toy1.jpg', N'Còn hàng', N'Bóng cao su phát sáng, chống cắn, bền', 13),
(N'Snack gà sấy 100g', 55000, N'/images/snack1.jpg', N'Còn hàng', N'Snack thưởng vị gà sấy khô cho chó', 14),
(N'Lược chải lông thép nhỏ', 70000, N'/images/brush1.jpg', N'Còn hàng', N'Lược thép không gỉ dùng cho mèo và chó nhỏ', 15),
(N'Nước khử mùi chuồng 500ml', 90000, N'/images/cleaner1.jpg', N'Còn hàng', N'Dung dịch khử mùi hôi chuồng thú cưng', 16),
(N'Khay vệ sinh huấn luyện chó', 160000, N'/images/tray1.jpg', N'Còn hàng', N'Khay nhựa chống trượt, dễ vệ sinh', 17),
(N'Áo len cho mèo mùa đông', 120000, N'/images/clothes1.jpg', N'Còn hàng', N'Áo len ấm, co giãn tốt, dành cho mèo cưng', 18),
(N'Giường nệm êm size S', 180000, N'/images/bed1.jpg', N'Còn hàng', N'Giường nệm bông mềm cho chó nhỏ', 19),
(N'Balo mang mèo trong suốt', 350000, N'/images/bag1.jpg', N'Còn hàng', N'B	alo có lỗ thoáng khí, phù hợp đi chơi xa', 20);

INSERT INTO Pet (ItemID, Species, Breed, Age, Gender)
VALUES
(1,  N'Chó', N'Corgi', 1, N'Male'),
(2,  N'Mèo', N'Anh lông ngắn', 2, N'Female'),
(3,  N'Chó', N'Poodle', 1, N'Male'),
(4,  N'Mèo', N'Ba Tư', 3, N'Female'),
(5,  N'Chó', N'Husky', 2, N'Male'),
(6,  N'Mèo', N'Mướp', 1, N'Female'),
(7,  N'Chó', N'Golden Retriever', 2, N'Male'),
(8,  N'Mèo', N'Xiêm', 2, N'Female'),
(9,  N'Chó', N'Chihuahua', 1, N'Male'),
(10, N'Mèo', N'Mỹ lông ngắn', 3, N'Female'),
(11, N'Chó', N'Beagle', 2, N'Male'),
(12, N'Mèo', N'Maine Coon', 3, N'Female'),
(13, N'Chó', N'Shiba Inu', 2, N'Male'),
(14, N'Mèo', N'Scottish Fold', 1, N'Female'),
(15, N'Chó', N'Pug', 4, N'Female'),
(16, N'Chó', N'Doberman', 3, N'Male'),
(17, N'Mèo', N'Ragdoll', 2, N'Female'),
(18, N'Chó', N'German Shepherd', 3, N'Male'),
(19, N'Mèo', N'Bengal', 1, N'Female'),
(20, N'Chó', N'Samoyed', 2, N'Male');

INSERT INTO Account (Username, [Password], Role)
VALUES
(N'Tien', N'pass123', N'Customer'),
(N'Khanh', N'pass123', N'Customer'),
(N'Bao', N'pass123', N'Customer'),
(N'Quoc', N'pass123', N'Customer'),
(N'Tung', N'pass123', N'Customer'),
(N'khach', N'pass123', N'Customer'),
(N'Trung', N'pass123', N'Customer'),
(N'Hau', N'pass123', N'Customer'),
(N'Ngan', N'pass123', N'Customer'),
(N'Tri', N'pass123', N'Customer'),
(N'Tai', N'pass123', N'Staff'),
(N'nhanvien', N'pass123', N'Staff'),
(N'Trang', N'pass123', N'Staff'),
(N'Dung', N'pass123', N'Staff'),
(N'Bich', N'pass123', N'Staff'),
(N'owner', N'pass123', N'Owner');

INSERT INTO [User] (AccountID, Name, Gender, Email, Phone, Address)
VALUES
(1, N'Nguyễn Minh Tiến', N'Male', N'tien@example.com', N'0901000001', N'12 Lê Lợi, Q1, TP.HCM'),
(2, N'Trần Ngọc Khánh', N'Female', N'khanh@example.com', N'0901000002', N'45 Nguyễn Trãi, Q5, TP.HCM'),
(3, N'Phạm Bảo', N'Male', N'bao@example.com', N'0901000003', N'78 Hai Bà Trưng, Q3, TP.HCM'),
(4, N'Lê Quốc', N'Male', N'quoc@example.com', N'0901000004', N'23 Lý Thường Kiệt, Q10, TP.HCM'),
(5, N'Hoàng Anh Tùng', N'Male', N'tung@example.com', N'0901000005', N'90 Cách Mạng Tháng 8, Q3, TP.HCM'),
(6, N'Khách Hàng Mẫu', N'Female', N'khach@example.com', N'0901000006', N'56 Nguyễn Văn Cừ, Q5, TP.HCM'),
(7, N'Nguyễn Trung', N'Male', N'trung@example.com', N'0901000007', N'102 Võ Văn Kiệt, Q1, TP.HCM'),
(8, N'Phan Hậu', N'Male', N'hau@example.com', N'0901000008', N'27 Trần Hưng Đạo, Q1, TP.HCM'),
(9, N'Lê Ngân', N'Female', N'ngan@example.com', N'0901000009', N'88 Hoàng Diệu, Q4, TP.HCM'),
(10, N'Võ Minh Trí', N'Male', N'tri@example.com', N'0901000010', N'65 Nguyễn Huệ, Q1, TP.HCM'),
(11, N'Nguyễn Tài', N'Male', N'tai@example.com', N'0902000011', N'102 Lạc Long Quân, Q11, TP.HCM'),
(12, N'Nhân Viên Chung', N'Female', N'nhanvien@example.com', N'0902000012', N'54 Phan Xích Long, Q.Phú Nhuận, TP.HCM'),
(13, N'Trần Trang', N'Female', N'trang@example.com', N'0902000013', N'89 Quang Trung, Q.Gò Vấp, TP.HCM'),
(14, N'Phạm Dung', N'Female', N'dung@example.com', N'0902000014', N'75 Âu Cơ, Q.Tân Bình, TP.HCM'),
(15, N'Nguyễn Bích', N'Female', N'bich@example.com', N'0902000015', N'23 Nguyễn Kiệm, Q.Phú Nhuận, TP.HCM'),
(16, N'Chủ Shop Thú Cưng', N'Male', N'owner@example.com', N'0909999999', N'01 Võ Văn Ngân, TP.Thủ Đức, TP.HCM');

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

INSERT INTO [Order] (CustomerID, Amount, ShippingAddress, PaymentMethod, PaymentStatus)
VALUES 
(1, 250000, N'123 Lê Lợi, TP.HCM', N'Cash', N'Paid'),
(2, 480000, N'56 Hai Bà Trưng, Hà Nội', N'Bank_Transfer', N'Pending'),
(3, 175000, N'89 Nguyễn Huệ, Đà Nẵng', N'Ewallet', N'Paid'),
(4, 320000, N'12 Trần Phú, Cần Thơ', N'Cash', N'Paid'),
(5, 590000, N'45 Nguyễn Trãi, TP.HCM', N'Bank_Transfer', N'Failed'),
(6, 210000, N'99 Hùng Vương, Huế', N'Ewallet', N'Refunded'),
(7, 120000, N'75 Phan Chu Trinh, Hà Nội', N'Cash', N'Paid'),
(8, 430000, N'21 Lê Duẩn, Đà Nẵng', N'Ewallet', N'Pending'),
(9, 310000, N'18 Nguyễn Văn Cừ, TP.HCM', N'Cash', N'Cancelled'),
(10, 275000, N'67 Lê Lợi, Hải Phòng', N'Bank_Transfer', N'Paid');

INSERT INTO OrderDetail (OrderID, ItemID, Quantity, Price)
VALUES
(1, 1, 2, 125000),
(2, 3, 1, 480000),
(3, 2, 5, 35000),
(4, 4, 3, 106667),
(5, 5, 1, 590000),
(6, 7, 2, 105000),
(7, 6, 4, 30000),
(8, 8, 2, 215000),
(9, 9, 1, 310000),
(10, 10, 5, 55000);

INSERT INTO Review (ItemID, UserID, Rating, Comment)
VALUES
(1, 1, 5, N'Chó rất ngoan và dễ thương, giao hàng nhanh.'),
(2, 3, 4, N'Mèo đẹp, lông mượt nhưng hơi nhát.'),
(3, 4, 5, N'Áo vừa vặn, chất liệu tốt, thú cưng rất thích.'),
(4, 5, 3, N'Sản phẩm ổn, nhưng giao hơi chậm.'),
(5, 6, 5, N'Dây dắt chắc chắn, màu đẹp.'),
(6, 7, 4, N'Thức ăn chất lượng, thú cưng ăn ngon miệng.'),
(7, 8, 2, N'Sản phẩm không giống hình, hơi thất vọng.'),
(8, 9, 5, N'Nước tắm thơm, dùng xong lông bóng mượt.'),
(9, 2, 4, N'Trứng dế tươi, thú cưng ăn ngon, đáng tiền.'),
(10, 10, 5, N'Rất hài lòng, shop tư vấn nhiệt tình và giao đúng hẹn.');

INSERT INTO Cart (CustomerID)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO CartItem (CartID, ItemID, Quantity)
VALUES
(1, 1, 2),
(1, 3, 1),
(2, 4, 1),
(2, 6, 3),
(3, 5, 1),
(3, 7, 2),
(4, 2, 1),
(4, 8, 2),
(5, 9, 1),
(5, 10, 4),
(6, 3, 1),
(7, 6, 2),
(8, 1, 1),
(9, 7, 1),
(10, 5, 2);


SELECT 
    r.ReviewID,
    r.Rating,
    r.Comment,
    r.ReviewDate,
    i.Name AS ItemName,
    u.Name AS UserName,
    u.Email AS UserEmail
FROM Review r
INNER JOIN Item i ON r.ItemID = i.ItemID
INNER JOIN [User] u ON r.UserID = u.UserID
ORDER BY r.ReviewDate DESC;