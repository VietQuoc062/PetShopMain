package com.petshop.dao;

import java.util.List;

import com.petshop.model.Item;
import com.petshop.model.Product;
import com.petshop.model.ProductCategory;
import com.petshop.util.DatabaseUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class ProductDAO {

	// Lấy tất cả product
	public List<Product> getAll() {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<Product> q = em.createQuery("SELECT p FROM Product p", Product.class);
			List<Product> products = q.getResultList();

			// populate transient fields from Item (if any)
			for (Product p : products) {
				TypedQuery<Item> qi = em.createQuery(
					"SELECT i FROM Item i WHERE i.product.productID = :pid", Item.class);
				qi.setParameter("pid", p.getProductID());
				qi.setMaxResults(1);
				List<Item> items = qi.getResultList();
				if (!items.isEmpty()) {
					Item it = items.get(0);
					p.setName(it.getName());
					p.setPrice(it.getPrice());
					p.setImageUrl(it.getImageUrl());
					p.setDescription(it.getDescription());
					// stockQuantity not stored in Item table in current schema -> leave null or handle separately
					// p.setStockQuantity(...);
				}
			}
			return products;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Product findById(Integer id) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			Product p = em.find(Product.class, id);
			if (p != null) {
				TypedQuery<Item> qi = em.createQuery(
					"SELECT i FROM Item i WHERE i.product.productID = :pid", Item.class);
				qi.setParameter("pid", p.getProductID());
				qi.setMaxResults(1);
				List<Item> items = qi.getResultList();
				if (!items.isEmpty()) {
					Item it = items.get(0);
					p.setName(it.getName());
					p.setPrice(it.getPrice());
					p.setImageUrl(it.getImageUrl());
					p.setDescription(it.getDescription());
				}
			}
			return p;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Product create(Product product) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();

			// ensure category is managed if provided
			ProductCategory cat = product.getProductCategory();
			if (cat != null && cat.getProductCategoryID() != null) {
				cat = em.find(ProductCategory.class, cat.getProductCategoryID());
				product.setProductCategory(cat);
			}

			em.persist(product);
			// create Item record from transient product fields
			Item it = new Item();
			it.setName(product.getName());
			it.setPrice(product.getPrice());
			it.setImageUrl(product.getImageUrl());
			it.setDescription(product.getDescription());
			it.setProduct(product); // set relationship
			em.persist(it);

			em.getTransaction().commit();
			// populate transient id from persisted item if needed
			return product;
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Product update(Product product) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();

			// Find existing product and merge only the DB-mapped fields
			Product existingProduct = em.find(Product.class, product.getProductID());
			if (existingProduct == null) {
				throw new RuntimeException("Product not found with ID: " + product.getProductID());
			}

			// Update only the Product table fields
			existingProduct.setCategory(product.getCategory());
			existingProduct.setBrand(product.getBrand());
			
			// Update ProductCategory if provided
			if (product.getProductCategoryID() != null) {
				ProductCategory category = em.find(ProductCategory.class, product.getProductCategoryID());
				if (category != null) {
					existingProduct.setProductCategory(category);
				}
			}

			Product merged = em.merge(existingProduct);

			// Only update Item fields if they are provided (not null)
			if (product.getName() != null || product.getPrice() != null || 
				product.getImageUrl() != null || product.getDescription() != null) {
				
				// Find existing Item and update only if transient fields are provided
				TypedQuery<Item> qi = em.createQuery(
					"SELECT i FROM Item i WHERE i.product.productID = :pid", Item.class);
				qi.setParameter("pid", merged.getProductID());
				qi.setMaxResults(1);
				List<Item> items = qi.getResultList();
				
				if (!items.isEmpty()) {
					Item it = items.get(0);
					// Only update fields that are not null
					if (product.getName() != null) it.setName(product.getName());
					if (product.getPrice() != null) it.setPrice(product.getPrice());
					if (product.getImageUrl() != null) it.setImageUrl(product.getImageUrl());
					if (product.getDescription() != null) it.setDescription(product.getDescription());
					em.merge(it);
				} else if (product.getName() != null) {
					// Only create new Item if name is provided (required field)
					Item it = new Item();
					it.setName(product.getName());
					it.setPrice(product.getPrice());
					it.setImageUrl(product.getImageUrl());
					it.setDescription(product.getDescription());
					it.setProduct(merged);
					em.persist(it);
				}
			}

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
			// delete items linked to product first to avoid orphan data
			TypedQuery<Item> qi = em.createQuery("SELECT i FROM Item i WHERE i.product.productID = :pid", Item.class);
			qi.setParameter("pid", id);
			List<Item> items = qi.getResultList();
			for (Item it : items) {
				if (em.contains(it)) em.remove(it); else em.remove(em.merge(it));
			}
			Product p = em.find(Product.class, id);
			if (p != null) {
				em.remove(p);
			}
			em.getTransaction().commit();
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public List<ProductCategory> getAllCategories() {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<ProductCategory> query = em.createQuery("SELECT pc FROM ProductCategory pc ORDER BY pc.name", ProductCategory.class);
			return query.getResultList();
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	// Backward-compatible API (ghi đè / wrapper) để services/controllers hiện tại dùng
	public List<Product> getAllProducts() {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			TypedQuery<Product> query = em.createQuery(
				"SELECT p FROM Product p LEFT JOIN FETCH p.productCategory ORDER BY p.productID", 
				Product.class
			);
			return query.getResultList();
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Product getProductById(int id) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			return em.find(Product.class, id);
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Product addProduct(Product product) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			
			// Load the ProductCategory if categoryId is provided
			if (product.getProductCategoryID() != null) {
				ProductCategory category = em.find(ProductCategory.class, product.getProductCategoryID());
				if (category != null) {
					product.setProductCategory(category);
				}
			}
			
			em.persist(product);
			em.getTransaction().commit();
			return product;
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public Product updateProduct(Product product) {
		EntityManager em = DatabaseUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			
			// Find existing product
			Product existingProduct = em.find(Product.class, product.getProductID());
			if (existingProduct == null) {
				throw new RuntimeException("Product not found with ID: " + product.getProductID());
			}

			// Update Product table fields
			existingProduct.setCategory(product.getCategory());
			existingProduct.setBrand(product.getBrand());
			
			// Update ProductCategory if provided
			if (product.getProductCategoryID() != null) {
				ProductCategory category = em.find(ProductCategory.class, product.getProductCategoryID());
				if (category != null) {
					existingProduct.setProductCategory(category);
				}
			}

			Product merged = em.merge(existingProduct);
			em.getTransaction().commit();
			return merged;
		} catch (RuntimeException ex) {
			if (em.getTransaction().isActive()) em.getTransaction().rollback();
			throw ex;
		} finally {
			DatabaseUtil.closeEntityManager(em);
		}
	}

	public void deleteProduct(int id) {
		delete(id);
	}

    public List<Product> getProductsPaginated(int offset, int limit) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.productCategory ORDER BY p.productID ASC", 
                Product.class
            );
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }
    
    public int getTotalProductCount() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Product p", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            DatabaseUtil.closeEntityManager(em);
        }
    }
}