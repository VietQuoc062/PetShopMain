package com.shop.dao;

import com.shop.model.Order;

import javax.persistence.*;
import java.util.List;

public class OrderDAO {
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("PetShopPU");

    private <T> T executeWithResult(JPAOperation<T> operation) {
        EntityManager em = emf.createEntityManager();
        try {
            return operation.execute(em);
        } finally {
            em.close();
        }
    }

    private void executeTransaction(JPATransaction operation) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            operation.execute(em);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ===== CRUD =====
    public void insert(Order order) {
        executeTransaction(em -> {
            em.persist(order);
            System.out.println("✅ Đã lưu Order ID: " + order.getOrderId());
        });
    }

    public void update(Order order) {
        executeTransaction(em -> em.merge(order));
    }

    public void close() {
        if (emf.isOpen()) emf.close();
    }
    public void delete(int orderId) {
        executeTransaction(em -> {
            Order order = em.find(Order.class, orderId);
            if (order != null) em.remove(order);
        });
    }

    public Order findById(int orderId) {
        return executeWithResult(em -> {
            Order order = em.find(Order.class, orderId);
            if (order != null) order.getOrderDetails().size(); // nạp lazy
            return order;
        });
    }

    public List<Order> getAllOrders() {
        return executeWithResult(em -> em.createQuery("SELECT o FROM Order o", Order.class).getResultList());
    }

    // ===== Functional interfaces =====
    @FunctionalInterface
    private interface JPAOperation<T> {
        T execute(EntityManager em);
    }

    @FunctionalInterface
    private interface JPATransaction {
        void execute(EntityManager em);
    }

}
