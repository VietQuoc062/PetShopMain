package com.petweb.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "[User]")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserID")
    private int userId;
    
    @Column(name = "AccountID", nullable = false)
    private int accountId;
    
    @Column(name = "Name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "Gender", length = 10)
    private String gender;
    
    @Column(name = "Email", unique = true, length = 100)
    private String email;
    
    @Column(name = "Phone", length = 20)
    private String phone;
    
    @Column(name = "Address", length = 255)
    private String address;
    
    // Relationship với Account
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "AccountID", insertable = false, updatable = false)
    private Account account;
    
    // Relationship với Review (One-to-Many)
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Review> reviews;

    // Constructor mặc định
    public User() {
    }

    // Constructor không có ID
    public User(int accountId, String name, String gender, String email, String phone, String address) {
        this.accountId = accountId;
        this.name = name;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", accountId=" + accountId +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}