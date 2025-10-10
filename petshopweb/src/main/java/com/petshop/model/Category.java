package com.petshop.model;

import java.util.List;

public class Category {
    private int id;
    private String name;
    private String description;
    
    // Thuộc tính mới: ID của danh mục cha (dùng Integer để chấp nhận NULL)
    private Integer parentID; 
    
    // Thuộc tính mới: Danh sách các danh mục con
    private List<Category> subCategories; 

    // Constructor mặc định
    public Category() {
    }
    
    // Constructor đầy đủ (có thể tự tạo)
    public Category(int id, String name, String description, Integer parentID) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.parentID = parentID;
    }

    // --- GETTERS & SETTERS ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // GETTERS & SETTERS cho thuộc tính Đa cấp
    public Integer getParentID() {
        return parentID;
    }

    public void setParentID(Integer parentID) {
        this.parentID = parentID;
    }

    public List<Category> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<Category> subCategories) {
        this.subCategories = subCategories;
    }
}