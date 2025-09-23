package com.petshop.service;

import java.util.List;

import com.petshop.dao.ProductDAO;
import com.petshop.model.Product;

public class ProductService {
    private ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }

    public void addProduct(Product product) {
        // Basic validation
        if (product.getName() == null || product.getName().isEmpty()) {
            throw new IllegalArgumentException("Product name cannot be empty");
        }
        if (product.getPrice() == null || product.getPrice().signum() <= 0) {
            throw new IllegalArgumentException("Price must be positive");
        }
        productDAO.addProduct(product);
    }

    public void updateProduct(Product product) {
        // Similar validation
        if (product.getName() == null || product.getName().isEmpty()) {
            throw new IllegalArgumentException("Product name cannot be empty");
        }
        productDAO.updateProduct(product);
    }

    public void deleteProduct(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Invalid product ID");
        }
        productDAO.deleteProduct(id);
    }
}
