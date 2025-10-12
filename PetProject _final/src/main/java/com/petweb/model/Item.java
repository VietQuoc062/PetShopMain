package com.petweb.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.List;

@Entity
@Table(name = "Item")
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ItemID")
    private int itemId;
    
    @Column(name = "Name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "Price", precision = 18, scale = 2)
    private BigDecimal price;
    
    @Column(name = "ImageUrl", length = 255)
    private String imageUrl;
    
    @Column(name = "Status", length = 30)
    private String status;
    
    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;
    
    @Column(name = "ProductID")
    private Integer productId;
    
    // Relationship với Product
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ProductID", insertable = false, updatable = false)
    private Product product;
    
    // Relationship với Pet (One-to-Many)
    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Pet> pets;
    
    // Relationship với Review (One-to-Many)
    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Review> reviews;

    // Constructor mặc định
    public Item() {
    }

    // Constructor không có ID
    public Item(String name, BigDecimal price, String imageUrl, String status, String description, Integer productId) {
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.status = status;
        this.description = description;
        this.productId = productId;
    }

    // Getters and Setters
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Pet> getPets() {
        return pets;
    }

    public void setPets(List<Pet> pets) {
        this.pets = pets;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    @Override
    public String toString() {
        return "Item{" +
                "itemId=" + itemId +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", status='" + status + '\'' +
                '}';
    }
}