package com.petshop.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "ProductCategory")
public class ProductCategory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ProductCategoryID")
	private Integer productCategoryID;

	@Column(name = "Name", nullable = false, length = 100)
	private String name;

	@Column(name = "Description", length = 255)
	private String description;

	@OneToMany(mappedBy = "productCategory", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Product> products;

	@OneToMany(mappedBy = "productCategory", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Promotion> promotions;

	// Constructors
	public ProductCategory() {}
	
	public ProductCategory(Integer productCategoryID) {
		this.productCategoryID = productCategoryID;
	}

	public Integer getProductCategoryID() { return productCategoryID; }
	public void setProductCategoryID(Integer productCategoryID) { this.productCategoryID = productCategoryID; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }
	public List<Product> getProducts() { return products; }
	public void setProducts(List<Product> products) { this.products = products; }
	public List<Promotion> getPromotions() { return promotions; }
	public void setPromotions(List<Promotion> promotions) { this.promotions = promotions; }
}