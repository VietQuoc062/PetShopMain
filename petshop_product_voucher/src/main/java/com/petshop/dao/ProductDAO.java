package com.petshop.dao;
import com.petshop.model.Product;
import com.petshop.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String SELECT_ALL_PRODUCTS = "SELECT * FROM products ORDER BY id DESC"; // Lấy sản phẩm mới nhất trước
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCTS);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all products: " + e.getMessage());
        }
        return products;
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int id) {
        Product product = null;
        String SELECT_PRODUCT_BY_ID = "SELECT * FROM products WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                product = mapResultSetToProduct(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting product by ID: " + e.getMessage());
        }
        return product;
    }

    // Thêm sản phẩm mới
    public void addProduct(Product product) {
        String INSERT_PRODUCT_SQL = "INSERT INTO products (name, description, price, stock_quantity, image_url, category_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {

            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setBigDecimal(3, product.getPrice());
            preparedStatement.setInt(4, product.getStockQuantity());
            preparedStatement.setString(5, product.getImageUrl());
            preparedStatement.setInt(6, product.getCategoryId());

            preparedStatement.executeUpdate();
            System.out.println("Product added: " + product.getName());
        } catch (SQLException e) {
            System.err.println("Error adding product: " + e.getMessage());
        }
        if (product.getCategoryId() <= 0) {
            throw new IllegalArgumentException("Invalid category ID");
        }
    }

    // Cập nhật sản phẩm
    public void updateProduct(Product product) {
        String UPDATE_PRODUCT_SQL = "UPDATE products SET name = ?, description = ?, price = ?, stock_quantity = ?, image_url = ?, category_id = ? WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {

            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setBigDecimal(3, product.getPrice());
            preparedStatement.setInt(4, product.getStockQuantity());
            preparedStatement.setString(5, product.getImageUrl());
            preparedStatement.setInt(6, product.getCategoryId());
            preparedStatement.setInt(7, product.getId());

            preparedStatement.executeUpdate();
            System.out.println("Product updated: " + product.getName());
        } catch (SQLException e) {
            System.err.println("Error updating product: " + e.getMessage());
        }
        if (product.getCategoryId() <= 0) {
            throw new IllegalArgumentException("Invalid category ID");
        }
    }

    // Xóa sản phẩm
    public void deleteProduct(int id) {
        String DELETE_PRODUCT_SQL = "DELETE FROM products WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
            System.out.println("Product deleted with ID: " + id);
        } catch (SQLException e) {
            System.err.println("Error deleting product: " + e.getMessage());
        }
    }

    // Helper method để ánh xạ ResultSet sang đối tượng Product
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setImageUrl(rs.getString("image_url"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        return product;
    }
}