<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.petweb.model.Review" %>
<%@ page import="com.petweb.dao.ReviewDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%
    String message = "";
    String messageType = "";
    
    // Xử lý submit review khi có POST request
    if ("POST".equals(request.getMethod())) {
        try {
            String petIdParam = request.getParameter("petId");
            String ratingParam = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String userName = request.getParameter("userName");
            String userEmail = request.getParameter("userEmail");
            
            if (petIdParam != null && ratingParam != null) {
                int petId = Integer.parseInt(petIdParam);
                int rating = Integer.parseInt(ratingParam);
                
                // Validate
                if (rating < 1 || rating > 5) {
                    message = "Rating phải từ 1 đến 5 sao!";
                    messageType = "error";
                } else if (comment == null || comment.trim().isEmpty()) {
                    message = "Vui lòng nhập nội dung đánh giá!";
                    messageType = "error";
                } else {
                    // Tạo review mới
                    Review newReview = new Review();
                    newReview.setItemId(petId);
                    newReview.setUserId(1);
                    newReview.setRating(rating);
                    newReview.setComment(comment.trim());
                    newReview.setReviewDate(LocalDateTime.now());
                    newReview.setFullName(userName != null && !userName.trim().isEmpty() ? userName.trim() : "Khách hàng");
                    newReview.setEmail(userEmail != null && !userEmail.trim().isEmpty() ? userEmail.trim() : "N/A");
                    
                    // Lưu vào database
                    ReviewDAO reviewDAO = new ReviewDAO();
                    boolean success = reviewDAO.saveReview(newReview);
                    
                    if (success) {
                        message = "Đánh giá của bạn đã được gửi thành công!";
                        messageType = "success";
                    } else {
                        message = "Có lỗi xảy ra khi lưu đánh giá. Vui lòng thử lại!";
                        messageType = "error";
                    }
                }
            }
        } catch (Exception e) {
            message = "Có lỗi hệ thống xảy ra!";
            messageType = "error";
            e.printStackTrace();
        }
    }
    
    // Tạo dữ liệu pet mẫu
    java.util.Map<String, Object> pet = new java.util.HashMap<>();
    pet.put("name", "Chó Golden Retriever");
    pet.put("species", "Chó");
    pet.put("breed", "Golden Retriever");
    
    java.util.Map<String, Object> item = new java.util.HashMap<>();
    item.put("name", "Chó Golden Retriever");
    item.put("imageUrl", "images/golden-retriever.jpg");
    pet.put("item", item);
    
    // Lấy danh sách reviews từ database
    ReviewDAO reviewDAO = new ReviewDAO();
    List<Review> reviews = reviewDAO.getReviewsByPetId(1);
    
    // Set attributes
    request.setAttribute("pet", pet);
    request.setAttribute("reviews", reviews);
    request.setAttribute("message", message);
    request.setAttribute("messageType", messageType);
%>
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
            <a href="#">${pet.species}</a> &gt;
            <span>${pet.breed}</span>
        </nav>

        <div class="product-detail">
            <div class="product-gallery">
                <div class="main-image-frame">
                    <img src="${pet.item.imageUrl}" alt="${pet.item.name}" class="main-image">
                </div>
                <div class="thumbnail-list">
                    <img src="${pet.item.imageUrl}" alt="${pet.item.name} 1" class="active">
                    <img src="${pet.item.imageUrl}" alt="${pet.item.name} 2">
                    <img src="${pet.item.imageUrl}" alt="${pet.item.name} 3">
                    <img src="${pet.item.imageUrl}" alt="${pet.item.name} 4">
                </div>
            </div>

            <div class="product-info">
                <div class="info-container">
                    <h1>${pet.item.name}</h1>
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
                            <div class="info-label">Loài:</div>
                            <div class="info-value">${pet.species}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Giống:</div>
                            <div class="info-value">${pet.breed}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Tuổi:</div>
                            <div class="info-value">${pet.age} tháng</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Giới tính:</div>
                            <div class="info-value">${pet.gender}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Giá:</div>
                            <div class="info-value">${pet.item.price} VND</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Trạng thái:</div>
                            <div class="info-value">${pet.item.status}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Mô tả:</div>
                            <div class="info-value">${pet.item.description}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Tuổi thọ:</div>
                            <div class="info-value">10-12 năm</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Tuổi sinh sản:</div>
                            <div class="info-value">8-10 tháng</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Số lượng sinh:</div>
                            <div class="info-value">2-4 con/lứa</div>
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
            <% if (!message.isEmpty()) { %>
                <div class="alert alert-<%= messageType %>">
                    <%= message %>
                </div>
            <% } %>
            
            <form class="review-form" action="petDetail.jsp" method="post">
                <input type="hidden" name="petId" value="1">
                <div class="form-group">
                    <label>Đánh giá <span class="required">*</span></label>
                    <select class="input" name="rating" required>
                        <option value="">Chọn số sao</option>
                        <option value="1">⭐ 1 sao</option>
                        <option value="2">⭐⭐ 2 sao</option>
                        <option value="3">⭐⭐⭐ 3 sao</option>
                        <option value="4">⭐⭐⭐⭐ 4 sao</option>
                        <option value="5">⭐⭐⭐⭐⭐ 5 sao</option>
                    </select>
                </div>
                <div class="form-group">
                    <textarea class="input textarea" name="comment" rows="6" placeholder="Viết đánh giá của bạn..." required></textarea>
                </div>
                <div class="form-row">
                    <div class="form-col">
                        <label>Họ và tên <span class="required">*</span></label>
                        <input class="input" type="text" name="userName" placeholder="Nguyễn Văn A" required>
                    </div>
                    <div class="form-col">
                        <label>Email <span class="required">*</span></label>
                        <input class="input" type="email" name="userEmail" placeholder="email@domain.com" required>
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

        <!-- Phần hiển thị các đánh giá đã có -->
        <section class="reviews-display-section">
            <h2>Đánh giá từ khách hàng</h2>
            

            
            <div class="reviews-container">
                <%
                    if (reviews != null && reviews.size() > 0) {
                    for (com.petweb.model.Review review : reviews) {
                %>
                    <div class="review-item">
                        <div class="review-header">
                            <div class="reviewer-info">
                                <h4 class="reviewer-name">
                                    <%= review.getFullName() != null ? review.getFullName() : 
                                        (review.getCustomerName() != null ? review.getCustomerName() : "Khách hàng") %>
                                </h4>
                                <span class="review-date">
                                    <%= review.getReviewDate() != null ? 
                                        review.getReviewDate().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) : 
                                        "N/A" %>
                                </span>
                            </div>
                            <div class="rating-stars">
                                <% 
                                int rating = review.getRating();
                                for (int i = 1; i <= 5; i++) {
                                    if (i <= rating) {
                                %>
                                    <i class="fas fa-star filled"></i>
                                <% } else { %>
                                    <i class="far fa-star empty"></i>
                                <% } } %>
                                <span class="rating-number">(<%= rating %>/5)</span>
                            </div>
                        </div>
                        <div class="review-content">
                            <p><%= review.getComment() != null ? review.getComment() : "Không có nội dung đánh giá" %></p>
                        </div>
                        <div class="review-footer">
                            <span class="reviewer-email">
                                <%= review.getEmail() != null ? review.getEmail() : 
                                    (review.getCustomerEmail() != null ? review.getCustomerEmail() : "") %>
                            </span>
                        </div>
                    </div>
                <% 
                    }
                } else { 
                %>
                    <div class="no-reviews">
                        <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                        <p>Hãy là người đầu tiên đánh giá!</p>
                    </div>
                <% } %>
            </div>
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