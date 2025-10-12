package com.petweb.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductID")
    private int productId;
    
    @Column(name = "Category", length = 100)
    private String category;
    
    @Column(name = "Brand", length = 100)
    private String brand;
    
    @Column(name = "ProductCategoryID", nullable = false)
    private int productCategoryId;
    
    // Relationship với ProductCategory
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ProductCategoryID", insertable = false, updatable = false)
    private ProductCategory productCategory;
    
    // Relationship với Item (One-to-Many)
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Item> items;

    // Constructor mặc định
    public Product() {
    }

    // Constructor không có ID
    public Product(String category, String brand, int productCategoryId) {
        this.category = category;
        this.brand = brand;
        this.productCategoryId = productCategoryId;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public int getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(int productCategoryId) {
        this.productCategoryId = productCategoryId;
    }

    public ProductCategory getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(ProductCategory productCategory) {
        this.productCategory = productCategory;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", category='" + category + '\'' +
                ", brand='" + brand + '\'' +
                ", productCategoryId=" + productCategoryId +
                '}';
    }
}