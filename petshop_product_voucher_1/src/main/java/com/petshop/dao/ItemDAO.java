package com.petshop.dao;

import java.util.List;

import com.petshop.model.Item;
import com.petshop.model.Product;
import com.petshop.util.DatabaseUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class ItemDAO {

    public List<Item> getAllItems() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Item> query = em.createQuery(
                "SELECT i FROM Item i LEFT JOIN FETCH i.product ORDER BY i.itemID ASC", 
                Item.class
            );
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public List<Item> getItemsPaginated(int offset, int limit) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Item> query = em.createQuery(
                "SELECT i FROM Item i LEFT JOIN FETCH i.product ORDER BY i.itemID ASC", 
                Item.class
            );
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public int getTotalItemCount() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(i) FROM Item i", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Item getItemById(int id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Item> query = em.createQuery(
                "SELECT i FROM Item i LEFT JOIN FETCH i.product WHERE i.itemID = :id", 
                Item.class
            );
            query.setParameter("id", id);
            List<Item> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Item addItem(Item item) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // Load the Product if productID is provided
            if (item.getProductID() != null) {
                Product product = em.find(Product.class, item.getProductID());
                if (product != null) {
                    item.setProduct(product);
                }
            }
            
            em.persist(item);
            em.getTransaction().commit();
            return item;
        } catch (RuntimeException ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Item updateItem(Item item) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Item existingItem = em.find(Item.class, item.getItemID());
            if (existingItem == null) {
                throw new RuntimeException("Item not found with ID: " + item.getItemID());
            }

            existingItem.setName(item.getName());
            existingItem.setPrice(item.getPrice());
            existingItem.setImageUrl(item.getImageUrl());
            existingItem.setStatus(item.getStatus());
            existingItem.setDescription(item.getDescription());
            
            if (item.getProductID() != null) {
                Product product = em.find(Product.class, item.getProductID());
                if (product != null) {
                    existingItem.setProduct(product);
                }
            }

            Item merged = em.merge(existingItem);
            em.getTransaction().commit();
            return merged;
        } catch (RuntimeException ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public void deleteItem(int id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Item item = em.find(Item.class, id);
            if (item != null) {
                em.remove(item);
            }
            em.getTransaction().commit();
        } catch (RuntimeException ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public List<Product> getAllProducts() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p ORDER BY p.category", Product.class);
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }
}
