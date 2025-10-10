package com.petshop.model; 

import java.math.BigDecimal; 

public class Item {
    private int itemID;
    private String name;
    private BigDecimal price; 
    private String imageUrl;
    private String description;

    // Constructors
    public Item() {
    }

    public Item(int itemID, String name, BigDecimal price, String imageUrl, String description) {
        this.itemID = itemID;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    // Getters and Setters
    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
