package com.petweb.dao;

import java.sql.*;
import java.math.BigDecimal;

// Simple POJO classes for DAO
class SimpleItem {
    public int itemId;
    public String name;
    public BigDecimal price;
    public String imageUrl;
    public String status;
    public String description;
    public int productId;
}

class SimpleProduct {
    public int productId;
    public String category;
    public String brand;
    public int productCategoryId;
}

public class ItemDAO {
    
    public SimpleItem getItemById(int itemId) {
        String sql = "SELECT ItemID, Name, Price, ImageUrl, Status, Description, ProductID " +
                    "FROM Item WHERE ItemID = ?";
        String url = "jdbc:sqlserver://.;databaseName=master;trustServerCertificate=true";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            return null;
        }
        
        try (Connection conn = DriverManager.getConnection(url, "sa", "123");
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                SimpleItem item = new SimpleItem();
                item.itemId = rs.getInt("ItemID");
                item.name = rs.getString("Name");
                item.price = rs.getBigDecimal("Price");
                item.imageUrl = rs.getString("ImageUrl");
                item.status = rs.getString("Status");
                item.description = rs.getString("Description");
                item.productId = rs.getInt("ProductID");
                return item;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public SimpleProduct getProductByItemId(int itemId) {
        String sql = "SELECT p.ProductID, p.Category, p.Brand, p.ProductCategoryID " +
                    "FROM Product p " +
                    "INNER JOIN Item i ON p.ProductID = i.ProductID " +
                    "WHERE i.ItemID = ?";
        String url = "jdbc:sqlserver://.;databaseName=master;trustServerCertificate=true";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            return null;
        }
        
        try (Connection conn = DriverManager.getConnection(url, "sa", "123");
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                SimpleProduct product = new SimpleProduct();
                product.productId = rs.getInt("ProductID");
                product.category = rs.getString("Category");
                product.brand = rs.getString("Brand");
                product.productCategoryId = rs.getInt("ProductCategoryID");
                return product;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}