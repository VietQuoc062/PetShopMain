package com.petshop.dao;

import java.util.List;

import com.petshop.model.ProductCategory;
import com.petshop.model.Promotion;
import com.petshop.util.DatabaseUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class VoucherDAO {

	// JPA-style methods using Promotion entity (table Promotion)
	public List<Promotion> getAll() {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<Promotion> q = em.createQuery(
				"SELECT p FROM Promotion p LEFT JOIN FETCH p.productCategory ORDER BY p.promotionID ASC", 
				Promotion.class
			);
			return q.getResultList();
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Promotion findById(Integer id) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<Promotion> q = em.createQuery(
				"SELECT p FROM Promotion p LEFT JOIN FETCH p.productCategory WHERE p.promotionID = :id", 
				Promotion.class
			);
			q.setParameter("id", id);
			List<Promotion> results = q.getResultList();
			return results.isEmpty() ? null : results.get(0);
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Promotion create(Promotion promotion) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			
			// Ensure ProductCategory is properly loaded
			ProductCategory cat = promotion.getProductCategory();
			if (cat != null && cat.getProductCategoryID() != null) {
				// Load the actual ProductCategory from database
				ProductCategory managedCategory = em.find(ProductCategory.class, cat.getProductCategoryID());
				if (managedCategory == null) {
					throw new RuntimeException("ProductCategory not found with ID: " + cat.getProductCategoryID());
				}
				promotion.setProductCategory(managedCategory);
			} else {
				// If no category provided, use default category ID 1
				ProductCategory defaultCategory = em.find(ProductCategory.class, 1);
				if (defaultCategory == null) {
					throw new RuntimeException("Default ProductCategory (ID=1) not found in database");
				}
				promotion.setProductCategory(defaultCategory);
			}
			
			em.persist(promotion);
			em.getTransaction().commit();
			return promotion;
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Promotion update(Promotion promotion) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			
			// Find the existing promotion to preserve ProductCategory
			Promotion existingPromotion = em.find(Promotion.class, promotion.getPromotionID());
			if (existingPromotion == null) {
				throw new RuntimeException("Promotion not found with ID: " + promotion.getPromotionID());
			}
			
			// Update only the fields that are provided
			existingPromotion.setName(promotion.getName());
			existingPromotion.setCode(promotion.getCode());
			existingPromotion.setDiscountPercent(promotion.getDiscountPercent());
			existingPromotion.setStartDate(promotion.getStartDate());
			existingPromotion.setEndDate(promotion.getEndDate());
			
			// Keep the existing ProductCategory - don't change it during update
			// If you need to update the category, you would need to add that logic here
			
			Promotion merged = em.merge(existingPromotion);
			em.getTransaction().commit();
			return merged;
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public void delete(Integer id) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			Promotion p = em.find(Promotion.class, id);
			if (p != null) em.remove(p);
			em.getTransaction().commit();
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	// Backward-compatible API (tên phương thức cũ mà services gọi)
	public List<Promotion> getAllVouchers() { return getAll(); }
	public Promotion getVoucherById(int id) { return findById(id); }
	public Promotion addVoucher(Promotion voucher) { return create(voucher); }
	public Promotion updateVoucher(Promotion voucher) { return update(voucher); }
	public void deleteVoucher(int id) { delete(id); }

	// Optionally keep category lookup
	public List<Promotion> findByCategoryId(Integer categoryId) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<Promotion> q = em.createQuery(
				"SELECT p FROM Promotion p WHERE p.productCategory.productCategoryID = :cid", Promotion.class);
			q.setParameter("cid", categoryId);
			return q.getResultList();
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}
	
	public List<Promotion> getVouchersPaginated(int offset, int limit) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<Promotion> q = em.createQuery(
				"SELECT p FROM Promotion p LEFT JOIN FETCH p.productCategory ORDER BY p.promotionID ASC", 
				Promotion.class
			);
			q.setFirstResult(offset);
			q.setMaxResults(limit);
			return q.getResultList();
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}
    
    public int getTotalVoucherCount() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Long> q = em.createQuery("SELECT COUNT(p) FROM Promotion p", Long.class);
            return q.getSingleResult().intValue();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }
}