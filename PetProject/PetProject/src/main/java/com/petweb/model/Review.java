package com.petweb.model;

import java.time.LocalDateTime;

public class Review {
    private int id;
    private int petId;
    private String fullName;
    private String email;
    private String phone;
    private String comment;
    private int rating;
    private LocalDateTime createdDate;

    public Review() {}

    public Review(int petId, String fullName, String email, String phone, String comment, int rating) {
        this.petId = petId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.comment = comment;
        this.rating = rating;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPetId() { return petId; }
    public void setPetId(int petId) { this.petId = petId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public LocalDateTime getCreatedDate() { return createdDate; }
    public void setCreatedDate(LocalDateTime createdDate) { this.createdDate = createdDate; }
}
