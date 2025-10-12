package com.petshop.dao;

import com.petshop.model.Account;
import com.petshop.model.User;
import com.petshop.util.DatabaseUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class AccountDAO {

    public Account authenticate(String username, String password) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Account> query = em.createQuery(
                "SELECT a FROM Account a WHERE a.username = :username AND a.password = :password", 
                Account.class
            );
            query.setParameter("username", username);
            query.setParameter("password", password);
            
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // Invalid credentials
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public User getUserByAccountId(Integer accountId) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.account.accountID = :accountId", 
                User.class
            );
            query.setParameter("accountId", accountId);
            
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }

    public Account findByUsername(String username) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Account> query = em.createQuery(
                "SELECT a FROM Account a WHERE a.username = :username", 
                Account.class
            );
            query.setParameter("username", username);
            
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }
}
