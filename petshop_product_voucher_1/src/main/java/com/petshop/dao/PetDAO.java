package com.petshop.dao;

import java.util.List;

import com.petshop.model.Item;
import com.petshop.model.Pet;
import com.petshop.util.DatabaseUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class PetDAO {

    public List<Pet> getAllPets() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Pet> query = em.createQuery(
                "SELECT p FROM Pet p LEFT JOIN FETCH p.item ORDER BY p.petID ASC", 
                Pet.class
            );
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public List<Pet> getPetsPaginated(int offset, int limit) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Pet> query = em.createQuery(
                "SELECT p FROM Pet p LEFT JOIN FETCH p.item ORDER BY p.petID ASC", 
                Pet.class
            );
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public int getTotalPetCount() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Pet p", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Pet getPetById(int id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Pet> query = em.createQuery(
                "SELECT p FROM Pet p LEFT JOIN FETCH p.item WHERE p.petID = :id", 
                Pet.class
            );
            query.setParameter("id", id);
            List<Pet> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Pet addPet(Pet pet) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // Load the Item if itemID is provided
            if (pet.getItemID() != null) {
                Item item = em.find(Item.class, pet.getItemID());
                if (item != null) {
                    pet.setItem(item);
                }
            }
            
            em.persist(pet);
            em.getTransaction().commit();
            return pet;
        } catch (RuntimeException ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Pet updatePet(Pet pet) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Pet existingPet = em.find(Pet.class, pet.getPetID());
            if (existingPet == null) {
                throw new RuntimeException("Pet not found with ID: " + pet.getPetID());
            }

            existingPet.setSpecies(pet.getSpecies());
            existingPet.setBreed(pet.getBreed());
            existingPet.setAge(pet.getAge());
            existingPet.setGender(pet.getGender());
            
            if (pet.getItemID() != null) {
                Item item = em.find(Item.class, pet.getItemID());
                if (item != null) {
                    existingPet.setItem(item);
                }
            }

            Pet merged = em.merge(existingPet);
            em.getTransaction().commit();
            return merged;
        } catch (RuntimeException ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public void deletePet(int id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Pet pet = em.find(Pet.class, id);
            if (pet != null) {
                em.remove(pet);
            }
            em.getTransaction().commit();
        } catch (RuntimeException ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public List<Item> getAllItems() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Item> query = em.createQuery("SELECT i FROM Item i ORDER BY i.name", Item.class);
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }
}
