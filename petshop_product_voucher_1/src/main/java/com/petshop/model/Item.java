package com.petshop.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "Item")
public class Item {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ItemID")
	private Integer itemID;

	@Column(name = "Name", nullable = false, length = 100)
	private String name;

	@Column(name = "Price", precision = 18, scale = 2)
	private BigDecimal price;

	@Column(name = "ImageUrl", length = 255)
	private String imageUrl;

	@Column(name = "Status", length = 30)
	private String status;

	@Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
	private String description;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ProductID")
	private Product product;

	public Integer getItemID() { return itemID; }
	public void setItemID(Integer itemID) { this.itemID = itemID; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public BigDecimal getPrice() { return price; }
	public void setPrice(BigDecimal price) { this.price = price; }
	public String getImageUrl() { return imageUrl; }
	public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
	public String getStatus() { return status; }
	public void setStatus(String status) { this.status = status; }
	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }
	public Product getProduct() { return product; }
	public void setProduct(Product product) { this.product = product; }
	public Integer getProductID() {
        return product != null ? product.getProductID() : null;
    }

    public void setProductID(Integer productID) {
        if (productID != null) {
            Product newProduct = new Product();
            newProduct.setProductID(productID);
            this.product = newProduct;
        } else {
            this.product = null;
        }
    }
}