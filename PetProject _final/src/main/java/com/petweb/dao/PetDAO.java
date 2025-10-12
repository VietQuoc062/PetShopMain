package com.petweb.dao;
import java.util.*;
import jakarta.persistence.*;
import com.petweb.util.JPAUtil;
import com.petweb.model.Pet;

public class PetDAO {
    public boolean isPet(int itemId) {
        return itemId > 26;
    }
    
    public Map<String, Object> getPetById(int itemId) {
        if (itemId < 27) return null;
        
        EntityManager em = null;
        Map<String, Object> petMap = new HashMap<>();
        
        try {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            
            // Try to get Pet from database using JPA
            Pet petEntity = em.find(Pet.class, itemId);
            
            if (petEntity != null) {
                // Load data from database
                petMap.put("id", petEntity.getItemId());
                petMap.put("species", petEntity.getSpecies());
                petMap.put("breed", petEntity.getBreed());
                petMap.put("age", petEntity.getAge());
                petMap.put("gender", petEntity.getGender());
            } else {
                // Fallback to sample data if not found in database
                generateSamplePetData(petMap, itemId);
            }
            
        } catch (Exception e) {
            System.err.println("PetDAO JPA Error: " + e.getMessage());
            e.printStackTrace();
            // Fallback to sample data on database error
            generateSamplePetData(petMap, itemId);
        } finally {
            if (em != null) {
                em.close();
            }
        }
        
        return petMap;
    }
    
    private void generateSamplePetData(Map<String, Object> pet, int itemId) {
        // Sample data - different for each pet ID
        String[] species = {"Dog", "Cat", "Rabbit", "Bird"};
        String[] breeds = {"Golden Retriever", "Persian Cat", "Holland Lop", "Canary", "Poodle", "Siamese", "Angora", "Parrot"};
        String[] genders = {"Male", "Female"};
        
        pet.put("id", itemId);
        pet.put("species", species[(itemId - 27) % species.length]);
        pet.put("breed", breeds[(itemId - 27) % breeds.length]);
        pet.put("age", 1 + ((itemId - 27) % 8)); // Age 1-8
        pet.put("gender", genders[(itemId - 27) % genders.length]);
    }
}
