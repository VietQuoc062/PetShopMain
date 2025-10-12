<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.petweb.model.Review" %>
<%@ page import="com.petweb.dao.ReviewDAO" %>
<%@ page import="com.petweb.dao.ItemDAO" %>
<%@ page import="com.petweb.dao.PetDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%
    String message = "";
    String messageType = "";
    
    // Lấy thông tin sản phẩm từ parameter
    String itemIdParam = request.getParameter("id");
    int itemId = (itemIdParam != null) ? Integer.parseInt(itemIdParam) : 1; // Default to 1
    
    // Load thông tin sản phẩm
    ItemDAO itemDAO = new ItemDAO();
    ItemDAO.SimpleItem item = itemDAO.getItemById(itemId);
    
    // Kiểm tra xem có phải Pet không
    PetDAO petDAO = new PetDAO();
    com.petweb.model.Pet pet = petDAO.getPetByItemId(itemId);
    
    // Load thông tin Product (nếu có)
    ItemDAO.SimpleProduct product = itemDAO.getProductByItemId(itemId);
    
    // Xử lý submit review khi có POST request
    if ("POST".equals(request.getMethod())) {
        try {
            String itemIdPostParam = request.getParameter("itemId");
            String ratingParam = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String userName = request.getParameter("userName");
            String userEmail = request.getParameter("userEmail");
            
            if (itemIdPostParam != null && ratingParam != null) {
                int itemIdPost = Integer.parseInt(itemIdPostParam);
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
                    newReview.setItemId(itemIdPost);
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
    
    // Lấy danh sách reviews từ database cho Item này
    ReviewDAO reviewDAO = new ReviewDAO();
    List<Review> reviews = reviewDAO.getReviewsByPetId(itemId);
    
    // Set attributes
    request.setAttribute("item", item);
    request.setAttribute("pet", pet);
    request.setAttribute("product", product);
    request.setAttribute("reviews", reviews);
    request.setAttribute("message", message);
    request.setAttribute("messageType", messageType);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm - <%= item != null ? item.name : "Sản phẩm" %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_new.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="#">Trang chủ</a> &gt;
            <% if (pet != null) { %>
                <a href="#"><%= pet.getSpecies() %></a> &gt;
                <span><%= pet.getBreed() %></span>
            <% } else if (product != null) { %>
                <a href="#"><%= product.category %></a> &gt;
                <span><%= product.brand %></span>
            <% } else { %>
                <span>Sản phẩm</span>
            <% } %>
        </nav>

        <div class="product-detail">
            <div class="product-gallery">
                <div class="main-image-frame">
                    <img src="<%= item != null && item.imageUrl != null ? item.imageUrl : "images/default-product.jpg" %>" 
                         alt="<%= item != null ? item.name : "Sản phẩm" %>" class="main-image">
                </div>
                <div class="thumbnail-list">
                    <img src="<%= item != null && item.imageUrl != null ? item.imageUrl : "images/default-product.jpg" %>" 
                         alt="<%= item != null ? item.name : "Sản phẩm" %> 1" class="active">
                    <img src="<%= item != null && item.imageUrl != null ? item.imageUrl : "images/default-product.jpg" %>" 
                         alt="<%= item != null ? item.name : "Sản phẩm" %> 2">
                </div>
            </div>

            <div class="product-info">
                <div class="info-container">
                    <h1><%= item != null ? item.name : "Sản phẩm" %></h1>
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
                        <!-- Thông tin chung cho tất cả sản phẩm -->
                        <div class="info-row">
                            <div class="info-label">Giá:</div>
                            <div class="info-value"><%= item != null && item.price != null ? item.price : "0" %> VND</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Trạng thái:</div>
                            <div class="info-value"><%= item != null && item.status != null ? item.status : "N/A" %></div>
                        </div>
                        
                        <!-- Nếu là Pet, hiển thị thông tin Pet -->
                        <% if (pet != null) { %>
                            <div class="info-row">
                                <div class="info-label">Loài:</div>
                                <div class="info-value"><%= pet.getSpecies() %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Giống:</div>
                                <div class="info-value"><%= pet.getBreed() %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Tuổi:</div>
                                <div class="info-value"><%= pet.getAge() %> tháng</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Giới tính:</div>
                                <div class="info-value"><%= pet.getGender() %></div>
                            </div>
                        <% } else if (product != null) { %>
                            <!-- Nếu là Product thông thường -->
                            <div class="info-row">
                                <div class="info-label">Danh mục:</div>
                                <div class="info-value"><%= product.category %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Thương hiệu:</div>
                                <div class="info-value"><%= product.brand %></div>
                            </div>
                        <% } %>
                        <div class="info-row">
                            <div class="info-label">Mô tả:</div>
                            <div class="info-value"><%= item != null && item.description != null ? item.description : "Không có mô tả" %></div>
                        </div>
                        
                        <!-- Thông tin bổ sung chỉ dành cho Pet -->
                        <% if (pet != null) { %>
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
                        <% } %>
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
            
            <form class="review-form" action="productDetail.jsp" method="post">
                <input type="hidden" name="itemId" value="<%= itemId %>">
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