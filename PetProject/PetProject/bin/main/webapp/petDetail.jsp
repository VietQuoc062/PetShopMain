<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thú cưng</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="index.jsp">Trang chủ</a> &gt;
            <a href="category?type=${pet.type}">${pet.type}</a> &gt;
            <span>${pet.name}</span>
        </nav>

        <div class="pet-detail">
            <div class="pet-images">
                <div class="main-image">
                    <img src="${pet.imageUrl}" alt="${pet.name}">
                </div>
                <div class="image-gallery">
                    <!-- Thêm gallery hình ảnh ở đây -->
                </div>
            </div>

            <div class="pet-info">
                <h1>${pet.name}</h1>
                <div class="rating">
                    <!-- Thêm rating ở đây -->
                </div>

                <table class="info-table">
                    <tr>
                        <td>Tên khác:</td>
                        <td>${pet.alias}</td>
                    </tr>
                    <tr>
                        <td>Nguồn gốc:</td>
                        <td>${pet.origin}</td>
                    </tr>
                    <tr>
                        <td>Phân loại:</td>
                        <td>${pet.type}</td>
                    </tr>
                    <tr>
                        <td>Kiểu lông:</td>
                        <td>${pet.furType}</td>
                    </tr>
                    <tr>
                        <td>Màu lông:</td>
                        <td>${pet.colors}</td>
                    </tr>
                    <tr>
                        <td>Đặc điểm ngoại hình:</td>
                        <td>${pet.features}</td>
                    </tr>
                    <tr>
                        <td>Cân nặng:</td>
                        <td>${pet.weight} kg</td>
                    </tr>
                    <tr>
                        <td>Tuổi thọ:</td>
                        <td>${pet.ageRange} năm</td>
                    </tr>
                    <tr>
                        <td>Tuổi sinh sản:</td>
                        <td>${pet.breedingAge}</td>
                    </tr>
                    <tr>
                        <td>Số lượng sinh:</td>
                        <td>${pet.littersPerYear} con/lứa</td>
                    </tr>
                </table>

                <div class="price-table">
                    <h3>BẢNG GIÁ THAM KHẢO</h3>
                    <div class="price-options">
                        <div class="price-male">
                            <h4>Chó đực</h4>
                            <a href="#" class="contact-btn">Liên Hệ</a>
                        </div>
                        <div class="price-female">
                            <h4>Chó cái</h4>
                            <a href="#" class="contact-btn">Liên Hệ</a>
                        </div>
                    </div>
                </div>

                <div class="contact-info">
                    <button class="order-btn">ĐẶT CỌC</button>
                    <div class="hotline">
                        <p>Tư vấn đặt hàng: <a href="tel:0838336888">0838.336.888</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>