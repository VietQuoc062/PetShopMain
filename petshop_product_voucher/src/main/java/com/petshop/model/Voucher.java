package com.petshop.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Voucher {
    private int id;
    private String code;
    private String description;
    private BigDecimal discountAmount; // Số tiền giảm giá
    private BigDecimal minOrderValue; // Giá trị đơn hàng tối thiểu để áp dụng
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private boolean active;

    // Constructors
    public Voucher() {
    }

    public Voucher(int id, String code, String description, BigDecimal discountAmount, BigDecimal minOrderValue,
                   LocalDateTime startDate, LocalDateTime endDate, boolean active) {
        this.id = id;
        this.code = code;
        this.description = description;
        this.discountAmount = discountAmount;
        this.minOrderValue = minOrderValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.active = active;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }
    public BigDecimal getMinOrderValue() { return minOrderValue; }
    public void setMinOrderValue(BigDecimal minOrderValue) { this.minOrderValue = minOrderValue; }
    public LocalDateTime getStartDate() { return startDate; }
    public void setStartDate(LocalDateTime startDate) { this.startDate = startDate; }
    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    @Override
    public String toString() {
        return "Voucher{" +
               "id=" + id +
               ", code='" + code + '\'' +
               ", discountAmount=" + discountAmount +
               ", active=" + active +
               '}';
    }
}