<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết thú cưng - ${pet.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_new.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="#">Trang chủ</a> &gt;
            <a href="#">${pet.type}</a> &gt;
            <span>${pet.name}</span>
        </nav>

        <div class="product-detail">
            <div class="product-gallery">
                <div class="main-image-frame">
                    <img src="${pet.imageUrl}" alt="${pet.name}" class="main-image">
                </div>
                <div class="thumbnail-list">
                    <img src="${pet.imageUrl}" alt="${pet.name} 1" class="active">
                    <img src="${pet.imageUrl}" alt="${pet.name} 2">
                    <img src="${pet.imageUrl}" alt="${pet.name} 3">
                    <img src="${pet.imageUrl}" alt="${pet.name} 4">
                </div>
            </div>

            <div class="product-info">
                <div class="info-container">
                    <h1>${pet.name}</h1>
                    <div class="rating">
                        <span class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </span>
                        <span class="rating-text">Average: 4.1 (33 votes)</span>
                    </div>

                    <div class="info-table">
                        <div class="info-row">
                            <div class="info-label">Tên khác:</div>
                            <div class="info-value">${pet.alias}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Nguồn gốc:</div>
                            <div class="info-value">${pet.origin}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Phân loại:</div>
                            <div class="info-value">${pet.type}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Kiểu lông:</div>
                            <div class="info-value">${pet.furType}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Màu lông:</div>
                            <div class="info-value">${pet.colors}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Đặc điểm ngoại hình:</div>
                            <div class="info-value">${pet.features}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Cân nặng:</div>
                            <div class="info-value">${pet.weight} kg</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Tuổi thọ:</div>
                            <div class="info-value">${pet.ageRange}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Tuổi sinh sản:</div>
                            <div class="info-value">${pet.breedingAge}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Số lượng sinh:</div>
                            <div class="info-value">${pet.littersPerYear} con/lứa</div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="cart-section">
            <button class="cart-btn"><i class="fas fa-shopping-cart"></i> Giỏ hàng</button>
        </div>

        <section class="review-section">
            <h2>Nhận xét của bạn <span class="required">*</span></h2>
            
            <!-- Hiển thị thông báo -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">${success}</div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">${error}</div>
            <% } %>
            
            <form class="review-form" action="${pageContext.request.contextPath}/submit-review" method="post">
                <input type="hidden" name="petId" value="${pet.id}">
                <div class="form-group">
                    <textarea class="input textarea" name="comment" rows="6" placeholder="Viết đánh giá của bạn..." required></textarea>
                </div>
                <div class="form-row">
                    <div class="form-col">
                        <label>Họ và tên <span class="required">*</span></label>
                        <input class="input" type="text" name="fullName" placeholder="Nguyễn Văn A" required>
                    </div>
                    <div class="form-col">
                        <label>Email <span class="required">*</span></label>
                        <input class="input" type="email" name="email" placeholder="email@domain.com" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-col">
                        <label>Số điện thoại</label>
                        <input class="input" type="tel" name="phone" placeholder="0xxxxxxxxx">
                    </div>
                </div>
                <button type="submit" class="submit-btn">Gửi đánh giá</button>
            </form>
        </section>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const thumbnails = document.querySelectorAll('.thumbnail-list img');
            const mainImage = document.querySelector('.main-image');

            thumbnails.forEach(thumb => {
                thumb.addEventListener('click', function() {
                    // Remove active class from all thumbnails
                    thumbnails.forEach(t => t.classList.remove('active'));
                    // Add active class to clicked thumbnail
                    this.classList.add('active');
                    // Update main image source
                    mainImage.src = this.src;
                });
            });
        });
    </script>
</body>
</html>