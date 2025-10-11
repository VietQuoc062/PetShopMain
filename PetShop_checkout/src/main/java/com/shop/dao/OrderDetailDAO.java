package com.shop.dao;

import com.shop.model.OrderDetail;

import javax.persistence.*;
import java.util.List;

public class OrderDetailDAO {
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
    public void insert(OrderDetail od) {
        executeTransaction(em -> em.persist(od));
    }

    public void update(OrderDetail od) {
        executeTransaction(em -> em.merge(od));
    }

    public void delete(int orderDetailId) {
        executeTransaction(em -> {
            OrderDetail od = em.find(OrderDetail.class, orderDetailId);
            if (od != null) em.remove(od);
        });
    }

    public OrderDetail findById(int orderDetailId) {
        return executeWithResult(em -> em.find(OrderDetail.class, orderDetailId));
    }

    public List<OrderDetail> getAllOrderDetails() {
        return executeWithResult(em -> em.createQuery("SELECT od FROM OrderDetail od", OrderDetail.class)
                .getResultList());
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
