package com.shop.model;

import java.util.Date;

public class Order {
    private int orderId;
    private String customerName;
    private String address;
    private String phone;
    private String email;
    private String paymentMethod;
    private Date orderDate;

    public Order(String customerName, String address, String phone, String email, String paymentMethod) {
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.paymentMethod = paymentMethod;
        this.orderDate = new Date();
    }

    // Getter và Setter
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}
