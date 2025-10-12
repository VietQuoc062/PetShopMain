package com.petshop.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "Promotion") // map to Promotion table
public class Voucher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PromotionID")
    private Integer voucherID;

    @Column(name = "Name", nullable = false, length = 100)
    private String name;

    @Column(name = "Code", length = 50, unique = true)
    private String code;

    @Column(name = "DiscountPercent", precision = 5, scale = 2)
    private BigDecimal discountPercent;

    @Column(name = "StartDate", nullable = false)
    private LocalDate startDate;

    @Column(name = "EndDate", nullable = false)
    private LocalDate endDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ProductCategoryID", nullable = false)
    private ProductCategory productCategory;

    // Constructors
    public Voucher() {
    }

    public Voucher(Integer voucherID, String name, String code, BigDecimal discountPercent, LocalDate startDate,
                   LocalDate endDate, ProductCategory productCategory) {
        this.voucherID = voucherID;
        this.name = name;
        this.code = code;
        this.discountPercent = discountPercent;
        this.startDate = startDate;
        this.endDate = endDate;
        this.productCategory = productCategory;
    }

    // Getters and Setters
    public Integer getVoucherID() { return voucherID; }
    public void setVoucherID(Integer voucherID) { this.voucherID = voucherID; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public BigDecimal getDiscountPercent() { return discountPercent; }
    public void setDiscountPercent(BigDecimal discountPercent) { this.discountPercent = discountPercent; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public ProductCategory getProductCategory() { return productCategory; }
    public void setProductCategory(ProductCategory productCategory) { this.productCategory = productCategory; }

    // Compatibility methods for JSP backward compatibility
    public Integer getId() { return voucherID; }
    public void setId(Integer id) { this.voucherID = id; }
    
    public String getDescription() { return name; }
    public void setDescription(String description) { this.name = description; }
    
    public BigDecimal getDiscountAmount() { return discountPercent; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountPercent = discountAmount; }
    
    public BigDecimal getMinOrderValue() { return BigDecimal.ZERO; }
    public void setMinOrderValue(BigDecimal minOrderValue) { /* No mapping needed */ }
    
    public boolean isActive() { 
        LocalDate now = LocalDate.now();
        return startDate != null && endDate != null && 
               !startDate.isAfter(now) && !endDate.isBefore(now);
    }
    public void setActive(boolean active) { /* No mapping needed */ }
}