package com.petweb.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    private static EntityManagerFactory entityManagerFactory;
    
    static {
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("PetWebPU");
        } catch (Exception e) {
            System.err.println("Failed to create EntityManagerFactory: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }
    
    public static void closeEntityManagerFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
        }
    }
    
    // Cleanup method to be called on application shutdown
    public static void shutdown() {
        closeEntityManagerFactory();
    }
}