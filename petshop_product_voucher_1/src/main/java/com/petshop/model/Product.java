package com.petshop.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "Product")
public class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ProductID")
	private Integer productID;

	@Column(name = "Category", length = 100)
	private String category;

	@Column(name = "Brand", length = 100)
	private String brand;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ProductCategoryID", nullable = false)
	private ProductCategory productCategory;

	@Transient
	private String name;

	@Transient
	private String description;

	@Transient
	private BigDecimal price;

	@Transient
	private Integer stockQuantity;

	@Transient
	private String imageUrl;

	@Transient
	private Timestamp createdAt;

	public Product() {
	}

	public Product(int id, String name, String description, BigDecimal price, int stockQuantity, String imageUrl, int categoryId, Timestamp createdAt) {
		this.productID = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.stockQuantity = stockQuantity;
		this.imageUrl = imageUrl;
		this.createdAt = createdAt;
	}

	public Integer getProductID() { return productID; }
	public void setProductID(Integer productID) { this.productID = productID; }

	public String getCategory() { return category; }
	public void setCategory(String category) { this.category = category; }

	public String getBrand() { return brand; }
	public void setBrand(String brand) { this.brand = brand; }

	public ProductCategory getProductCategory() { return productCategory; }
	public void setProductCategory(ProductCategory productCategory) { this.productCategory = productCategory; }

	public Integer getProductCategoryID() {
		return productCategory != null ? productCategory.getProductCategoryID() : null;
	}

	public void setProductCategoryID(Integer productCategoryID) {
		if (productCategoryID != null) {
			ProductCategory category = new ProductCategory();
			category.setProductCategoryID(productCategoryID);
			this.productCategory = category;
		} else {
			this.productCategory = null;
		}
	}

	// Transient-field getters/setters used by controllers/services
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }

	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }

	public BigDecimal getPrice() { return price; }
	public void setPrice(BigDecimal price) { this.price = price; }

	public Integer getStockQuantity() { return stockQuantity; }
	public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }

	public String getImageUrl() { return imageUrl; }
	public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	// Aliases for JSP/EL (${product.id})
	public Integer getId() { return this.productID; }
	public void setId(Integer id) { this.productID = id; }

	// Helper used by controllers to set category by id
	public void setCategoryId(Integer categoryId) {
		if (categoryId == null) {
			this.productCategory = null;
		} else {
			if (this.productCategory == null) this.productCategory = new ProductCategory();
			this.productCategory.setProductCategoryID(categoryId);
		}
	}

	// helper: expose categoryId for JSP/EL (${product.categoryId})
	public Integer getCategoryId() {
		return (this.productCategory != null) ? this.productCategory.getProductCategoryID() : null;
	}
}