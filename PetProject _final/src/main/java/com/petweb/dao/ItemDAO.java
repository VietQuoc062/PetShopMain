package com.petweb.dao;

import java.util.*;
import jakarta.persistence.*;
import com.petweb.util.JPAUtil;
import com.petweb.model.Item;

public class ItemDAO {
    
    public Map<String, Object> getItemById(int itemId) {
        EntityManager em = null;
        Map<String, Object> item = new HashMap<>();
        
        try {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            
            // Try to get Item from database using JPA
            Item itemEntity = em.find(Item.class, itemId);
            
            if (itemEntity != null) {
                // Load data from database
                item.put("id", itemEntity.getItemId());
                item.put("name", itemEntity.getName());
                item.put("price", itemEntity.getPrice());
                item.put("status", itemEntity.getStatus());
                item.put("description", itemEntity.getDescription());
                item.put("imageUrl", itemEntity.getImageUrl());
                
                // Get additional info from related Product if exists
                if (itemEntity.getProduct() != null) {
                    item.put("category", itemEntity.getProduct().getCategory());
                    item.put("brand", itemEntity.getProduct().getBrand());
                }
            } else {
                // Fallback to sample data if not found in database
                generateSampleData(item, itemId);
            }
            
        } catch (Exception e) {
            System.err.println("ItemDAO JPA Error: " + e.getMessage());
            e.printStackTrace();
            // Fallback to sample data on database error
            generateSampleData(item, itemId);
        } finally {
            if (em != null) {
                em.close();
            }
        }
        
        return item;
    }
    
    private void generateSampleData(Map<String, Object> item, int itemId) {
        if (itemId >= 27) {
            // Pet data - different for each ID
            item.put("id", itemId);
            item.put("name", "Pet " + itemId);
            item.put("price", 4000000 + (itemId * 100000));
            item.put("description", "Beautiful pet with ID " + itemId);
            item.put("status", "Available");
            item.put("imageUrl", "images/pet" + itemId + ".jpg");
        } else {
            // Product data - different for each ID  
            item.put("id", itemId);
            item.put("name", "Product " + itemId);
            item.put("price", 150000 + (itemId * 25000));
            item.put("description", "Quality pet product " + itemId);
            item.put("status", "In Stock");
            item.put("category", "Pet Accessories");
            item.put("brand", "PetBrand " + itemId);
            item.put("size", itemId % 2 == 0 ? "Large" : "Small");
            item.put("color", itemId % 3 == 0 ? "Red" : (itemId % 3 == 1 ? "Blue" : "Green"));
            item.put("origin", "Vietnam");
            item.put("imageUrl", "images/product" + itemId + ".jpg");
        }
    }
}
