<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.petweb.dao.ReviewDAO" %>
<%@ page import="com.petweb.dao.ItemDAO" %>
<%@ page import="com.petweb.dao.PetDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>
<%
    String message = "";
    String messageType = "";
    
    // Xử lý submit review khi có POST request
    if ("POST".equals(request.getMethod())) {
        try {
            String itemIdParam = request.getParameter("itemId");
            String ratingParam = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String userName = request.getParameter("userName");
            String userEmail = request.getParameter("userEmail");
            
            if (itemIdParam != null && ratingParam != null) {
                int itemId = Integer.parseInt(itemIdParam);
                int rating = Integer.parseInt(ratingParam);
                
                // Validate
                if (rating < 1 || rating > 5) {
                    message = "Rating phải từ 1 đến 5 sao!";
                    messageType = "error";
                } else if (comment == null || comment.trim().isEmpty()) {
                    message = "Vui lòng nhập nội dung đánh giá!";
                    messageType = "error";
                } else {
                    // Lưu vào database (sử dụng ReviewDAO)
                    ReviewDAO reviewDAO = new ReviewDAO();
                    boolean success = reviewDAO.saveReview(itemId, 1, rating, comment.trim(), 
                        userName != null && !userName.trim().isEmpty() ? userName.trim() : "Khách hàng",
                        userEmail != null && !userEmail.trim().isEmpty() ? userEmail.trim() : "N/A");
                    
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
    
    // Lấy ItemID từ parameter
    String itemIdParam = request.getParameter("id");
    int itemId = (itemIdParam != null) ? Integer.parseInt(itemIdParam) : 27; // Default to Pet ID 27
    
    // Load thông tin từ database
    ItemDAO itemDAO = new ItemDAO();
    Map<String, Object> item = itemDAO.getItemById(itemId);
    
    // Load thông tin Pet nếu là Pet
    PetDAO petDAO = new PetDAO();
    Map<String, Object> pet = null;
    if (itemId >= 27) { // Pet IDs từ 27-46
        pet = petDAO.getPetById(itemId);
    }
    

    
    // Lấy danh sách reviews từ database
    ReviewDAO reviewDAO = new ReviewDAO();
    List<Map<String, Object>> reviews = reviewDAO.getReviewsByItemId(itemId);
    
    // Set attributes
    request.setAttribute("item", item);
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
    <title>Chi tiết thú cưng - <%= item != null ? item.get("name") : "Pet" %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_new.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <nav class="breadcrumb">
            <a href="#">Trang chủ</a> &gt;
            <a href="#"><%= pet != null ? pet.get("species") : "Pets" %></a> &gt;
            <span><%= pet != null ? pet.get("breed") : (item != null ? item.get("name") : "Detail") %></span>
        </nav>

        <div class="product-detail">
            <div class="product-gallery">
                <div class="main-image-frame">
                    <img src="<%= item != null ? item.get("imageUrl") : "images/default.jpg" %>" alt="<%= item != null ? item.get("name") : "Pet" %>" class="main-image">
                </div>
                <div class="thumbnail-list">
                    <img src="<%= item != null ? item.get("imageUrl") : "images/default.jpg" %>" alt="<%= item != null ? item.get("name") : "Pet" %> 1" class="active">
                    <img src="<%= item != null ? item.get("imageUrl") : "images/default.jpg" %>" alt="<%= item != null ? item.get("name") : "Pet" %> 2">
                    <img src="<%= item != null ? item.get("imageUrl") : "images/default.jpg" %>" alt="<%= item != null ? item.get("name") : "Pet" %> 3">
                    <img src="<%= item != null ? item.get("imageUrl") : "images/default.jpg" %>" alt="<%= item != null ? item.get("name") : "Pet" %> 4">
                </div>
            </div>

            <div class="product-info">
                <div class="info-container">
                    <h1><%= item != null ? item.get("name") : "Pet" %></h1>
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
                        <% if (itemId >= 27 && pet != null) { // Nếu là Pet %>
                            <div class="info-row">
                                <div class="info-label">Loài:</div>
                                <div class="info-value"><%= pet.get("species") %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Giống:</div>
                                <div class="info-value"><%= pet.get("breed") %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Tuổi:</div>
                                <div class="info-value"><%= pet.get("age") %> tháng</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Giới tính:</div>
                                <div class="info-value"><%= pet.get("gender") %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Giá:</div>
                                <div class="info-value"><%= item != null ? item.get("price") : 0 %> VND</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Trạng thái:</div>
                                <div class="info-value"><%= item != null ? item.get("status") : "N/A" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Mô tả:</div>
                                <div class="info-value"><%= item != null ? item.get("description") : "N/A" %></div>
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
                        <% } else { // Nếu là Product %>
                            <div class="info-row">
                                <div class="info-label">Tên sản phẩm:</div>
                                <div class="info-value"><%= item != null ? item.get("name") : "N/A" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Danh mục:</div>
                                <div class="info-value"><%= item != null ? item.get("category") : "Phụ kiện thú cưng" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Thương hiệu:</div>
                                <div class="info-value"><%= item != null ? item.get("brand") : "N/A" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Giá:</div>
                                <div class="info-value"><%= item != null ? item.get("price") : 0 %> VND</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Trạng thái:</div>
                                <div class="info-value"><%= item != null ? item.get("status") : "Có sẵn" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Mô tả:</div>
                                <div class="info-value"><%= item != null ? item.get("description") : "N/A" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Kích thước:</div>
                                <div class="info-value"><%= item != null ? item.get("size") : "Đa dạng" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Màu sắc:</div>
                                <div class="info-value"><%= item != null ? item.get("color") : "Nhiều màu" %></div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Xuất xứ:</div>
                                <div class="info-value"><%= item != null ? item.get("origin") : "Việt Nam" %></div>
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
            
            <form class="review-form" action="petDetail.jsp" method="post">
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
                    for (Map<String, Object> review : reviews) {
                %>
                    <div class="review-item">
                        <div class="review-header">
                            <div class="reviewer-info">
                                <h4 class="reviewer-name">
                                    <%= review.get("fullName") != null ? review.get("fullName") : 
                                        (review.get("customerName") != null ? review.get("customerName") : "Khách hàng") %>
                                </h4>
                                <span class="review-date">
                                    <%= review.get("reviewDate") != null ? review.get("reviewDate") : "N/A" %>
                                </span>
                            </div>
                            <div class="rating-stars">
                                <% 
                                int reviewRating = review.get("rating") != null ? ((Integer)review.get("rating")).intValue() : 0;
                                for (int i = 1; i <= 5; i++) {
                                    if (i <= reviewRating) {
                                %>
                                    <i class="fas fa-star filled"></i>
                                <% } else { %>
                                    <i class="far fa-star empty"></i>
                                <% } } %>
                                <span class="rating-number">(<%= reviewRating %>/5)</span>
                            </div>
                        </div>
                        <div class="review-content">
                            <p><%= review.get("comment") != null ? review.get("comment") : "Không có nội dung đánh giá" %></p>
                        </div>
                        <div class="review-footer">
                            <span class="reviewer-email">
                                <%= review.get("email") != null ? review.get("email") : 
                                    (review.get("customerEmail") != null ? review.get("customerEmail") : "") %>
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