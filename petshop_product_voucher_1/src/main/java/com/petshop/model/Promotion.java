package com.petshop.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
@Table(name = "Promotion")
public class Promotion {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PromotionID")
	private Integer promotionID;

	@Column(name = "Name", nullable = false, length = 100)
	private String name;

	@Column(name = "Code", length = 50, unique = true)
	private String code;

	@Column(name = "DiscountPercent", precision = 5, scale = 2)
	private BigDecimal discountPercent;

	@Column(name = "StartDate", nullable = false)
	private LocalDate startDate;

	@Column(name = "EndDate", nullable = false)
	private LocalDate endDate;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ProductCategoryID", nullable = false)
	private ProductCategory productCategory;

	// TRANSIENT fields: used by old UI/servlet but NOT mapped to DB columns
	@Transient
	private String description;

	@Transient
	private BigDecimal discountAmount;

	@Transient
	private BigDecimal minOrderValue;

	@Transient
	private Boolean active;

	// No-arg constructor
	public Promotion() {}

	// Minimal DB-mapped constructor (existing)
	public Promotion(Integer promotionID, String name, String code, BigDecimal discountPercent, LocalDate startDate, LocalDate endDate) {
		this.promotionID = promotionID;
		this.name = name;
		this.code = code;
		this.discountPercent = discountPercent;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	// Compatibility constructor required by AdminVoucherServlet:
	// (int, String, String, BigDecimal, BigDecimal, LocalDateTime, LocalDateTime, boolean)
	public Promotion(Integer promotionID, String name, String code,
	                 BigDecimal discountAmount, BigDecimal minOrderValue,
	                 LocalDateTime startDateTime, LocalDateTime endDateTime, boolean active) {
		this.promotionID = promotionID;
		this.name = name;
		this.code = code;
		this.discountAmount = discountAmount;
		this.minOrderValue = minOrderValue;
		this.active = active;
		// convert LocalDateTime to LocalDate for DB mapped fields
		if (startDateTime != null) this.startDate = startDateTime.toLocalDate();
		if (endDateTime != null) this.endDate = endDateTime.toLocalDate();
		// discountPercent remains null unless set explicitly
	}

	// DB-mapped getters/setters
	public Integer getPromotionID() { return promotionID; }
	public void setPromotionID(Integer promotionID) { this.promotionID = promotionID; }

	public String getName() { return name; }
	public void setName(String name) { this.name = name; }

	public String getCode() { return code; }
	public void setCode(String code) { this.code = code; }

	public BigDecimal getDiscountPercent() { return discountPercent; }
	public void setDiscountPercent(BigDecimal discountPercent) { this.discountPercent = discountPercent; }

	public LocalDate getStartDate() { return startDate; }
	public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

	public LocalDate getEndDate() { return endDate; }
	public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

	public ProductCategory getProductCategory() { return productCategory; }
	public void setProductCategory(ProductCategory productCategory) { this.productCategory = productCategory; }

	// TRANSIENT getters/setters used by servlet/UI (compile-time compatibility)
	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }

	public BigDecimal getDiscountAmount() { return discountAmount; }
	public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

	public BigDecimal getMinOrderValue() { return minOrderValue; }
	public void setMinOrderValue(BigDecimal minOrderValue) { this.minOrderValue = minOrderValue; }

	public Boolean getActive() { return active; }
	public void setActive(Boolean active) { this.active = active; }

	// Convenience: accept LocalDateTime and convert to LocalDate (servlet may pass LocalDateTime)
	public void setStartDate(LocalDateTime startDateTime) {
		this.startDate = (startDateTime != null) ? startDateTime.toLocalDate() : null;
	}
	public void setEndDate(LocalDateTime endDateTime) {
		this.endDate = (endDateTime != null) ? endDateTime.toLocalDate() : null;
	}

	// alias for EL (${promotion.id})
	public Integer getId() { return this.promotionID; }
	public void setId(Integer id) { this.promotionID = id; }
}