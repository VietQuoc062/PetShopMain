package com.petweb.model;

import java.time.LocalDateTime;

/**
 * Review Entity - sử dụng JPA khi có thư viện, fallback POJO khi không có
 */
public class Review {
    private int reviewId;
    private int itemId;        // ID của sản phẩm được đánh giá
    private int userId;        // User ID
    private int rating;        // Rating 1-5 stars
    private String comment;    // Nội dung đánh giá
    private LocalDateTime reviewDate;
    
    // Thông tin bổ sung từ form (không lưu DB)
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    
    // Thông tin từ database join
    private String fullName;    // Tên từ bảng Users
    private String email;       // Email từ bảng Account
    
    // Constructors
    public Review() {
        this.reviewDate = LocalDateTime.now();
        this.userId = 1; // Mặc định user guest
    }
    
    public Review(int itemId, int rating, String comment) {
        this();
        this.itemId = itemId;
        this.rating = rating;
        this.comment = comment;
    }
    
    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }
    
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }
    
    public int getItemId() {
        return itemId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        if (rating >= 1 && rating <= 5) {
            this.rating = rating;
        } else {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public LocalDateTime getReviewDate() {
        return reviewDate;
    }
    
    public void setReviewDate(LocalDateTime reviewDate) {
        this.reviewDate = reviewDate;
    }
    
    // Thông tin khách hàng (không lưu DB)
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getCustomerEmail() {
        return customerEmail;
    }
    
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public String getCustomerPhone() {
        return customerPhone;
    }
    
    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }
    
    // Thông tin từ database join
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", itemId=" + itemId +
                ", userId=" + userId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", reviewDate=" + reviewDate +
                ", customerName='" + customerName + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                '}';
    }
}