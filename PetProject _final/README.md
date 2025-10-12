# Pet Shop Project - JPA Implementation

## Mô tả dự án
Dự án web bán thú cưng sử dụng Jakarta EE với JPA/Hibernate, có chức năng đánh giá sản phẩm lưu trực tiếp vào SQL Server database.

## ⭐ Chức năng chính

### 1. Xem chi tiết sản phẩm
- Hiển thị thông tin thú cưng (loài, giống, tuổi, giới tính)
- Hiển thị thông tin sản phẩm (tên, giá, mô tả, hình ảnh)

### 2. **Hệ thống đánh giá sản phẩm (MỚI)**
- ✅ Form đánh giá với thông tin khách hàng
- ✅ Lưu đánh giá trực tiếp vào database SQL Server
- ✅ Hiển thị danh sách đánh giá đã có
- ✅ Rating bằng sao (1-5 sao)
- ✅ Thông tin người đánh giá và ngày tạo
- ✅ **Có sẵn 10 dữ liệu đánh giá mẫu trong SQL**
- Giao diện responsive với CSS hiện đại

### 2. 🎯 Chức năng đánh giá sản phẩm
**Đặc biệt quan trọng**: Chức năng này hoạt động độc lập và lưu trực tiếp vào database!

#### Quy trình:
1. Khách hàng điền form đánh giá (họ tên, email, SĐT, nội dung đánh giá)
2. Hệ thống lưu vào bảng `Review` trong SQL Server
3. Admin có thể xem kết quả trong SSMS

#### Kiểm tra kết quả trong SSMS:
```sql
-- Xem tất cả đánh giá mới nhất
SELECT * FROM Review ORDER BY ReviewDate DESC;

-- Xem đánh giá kèm thông tin sản phẩm
SELECT 
    r.ReviewID,
    r.Rating,
    r.Comment,
    r.ReviewDate,
    i.Name AS ProductName
FROM Review r
INNER JOIN Item i ON r.ItemID = i.ItemID
ORDER BY r.ReviewDate DESC;

-- Thống kê đánh giá theo điểm
SELECT 
    Rating,
    COUNT(*) AS SoLuong
FROM Review
GROUP BY Rating
ORDER BY Rating DESC;
```

## 🛠️ Công nghệ sử dụng
- **Backend**: Java 17, Jakarta EE, JPA/Hibernate 6.2.7
- **Database**: SQL Server với bảng schema từ DBweb.sql
- **Frontend**: JSP, HTML5, CSS3
- **Server**: Apache Tomcat 10.1.x
- **Build Tool**: Maven (pom.xml có sẵn)

## 📁 Cấu trúc project
```
PetProject/
├── src/main/java/com/petweb/
│   ├── model/           # JPA Entities
│   │   ├── Pet.java     # Entity thú cưng
│   │   ├── Item.java    # Entity sản phẩm  
│   │   ├── Review.java  # Entity đánh giá
│   │   └── ...
│   ├── dao/             # Data Access Objects
│   │   ├── PetDAO.java  # DAO cho Pet
│   │   └── ReviewDAO.java # DAO cho Review (lưu DB)
│   └── servlet/         # Controllers
│       ├── PetDetailServlet.java
│       └── ReviewServlet.java # Xử lý form đánh giá
├── src/main/webapp/     # Web resources
│   ├── petDetail.jsp    # Trang chi tiết + form đánh giá
│   └── css/
├── database/            # SQL Schema
│   ├── DBweb.sql       # Tạo database structure
│   └── AddDataPetShop.sql # Dữ liệu mẫu
└── pom.xml             # Maven dependencies
```

## 🚀 Cách Deploy

### Bước 1: Chuẩn bị
1. **Khởi động SQL Server** (port 1433)
2. **Import database:**
   - Chạy `database/DBweb.sql` tạo bảng
   - Chạy `database/AddDataPetShop.sql` import dữ liệu (có 10 reviews mẫu)

### Bước 2: Deploy
```bash
# Sửa đường dẫn Tomcat trong deploy.bat nếu cần
# Sau đó chạy:
deploy.bat
```

### Bước 3: Truy cập
- **Test page:** http://localhost:8080/PetProject/index.jsp  
- **Pet detail:** http://localhost:8080/PetProject/petDetail.jsp
- **Servlet:** http://localhost:8080/PetProject/pet-detail?id=1

### 🛠️ Nếu lỗi 404
1. Kiểm tra Tomcat đã khởi động (logs trong `TOMCAT_HOME/logs/`)
2. Kiểm tra file đã copy vào `webapps/PetProject/`
3. Thử truy cập test page trước
restart-tomcat.bat    # Khởi động lại
Double-click trực tiếp:
Mở File Explorer → vào thư mục project → double-click file .bat
Nếu vẫn không dừng được:
Mở Task Manager (Ctrl+Shift+Esc)
Tìm process java.exe hoặc tomcat
Right-click → End Task