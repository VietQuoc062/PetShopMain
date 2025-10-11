package com.shop.dao;

import com.shop.model.Item;

import javax.persistence.*;
import java.util.List;

public class ItemDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PetShopPU");

    // Lấy tất cả Item
    public List<Item> getAllItems() {
        EntityManager em = emf.createEntityManager();
        List<Item> items = null;
        try {
            items = em.createQuery("SELECT i FROM Item i", Item.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return items;
    }
    public Item findById(int itemId) {
        EntityManager em = emf.createEntityManager();
        Item item = null;
        try {
            item = em.find(Item.class, itemId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return item;
    }

    // Lấy Item theo ID
    public Item getItemById(int itemId) {
        EntityManager em = emf.createEntityManager();
        Item item = null;
        try {
            item = em.find(Item.class, itemId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return item;
    }

    // Thêm Item mới
    public void insert(Item item) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(item);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Cập nhật Item
    public void update(Item item) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(item);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Xóa Item theo ID
    public void delete(int itemId) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Item item = em.find(Item.class, itemId);
            if (item != null) {
                em.remove(item);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
