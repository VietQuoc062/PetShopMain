package com.petshop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.petshop.model.Category; // Cần import Model Category của bạn

public class CategoryDAO {

    // Chuỗi kết nối sử dụng Windows Authentication (dựa trên ProductDAO của bạn)
    private String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PetShopDB;integratedSecurity=true;encrypt=false"; 

    // Câu lệnh SQL lấy tất cả danh mục, sắp xếp theo ParentID để xử lý cây dễ hơn
    private static final String SELECT_ALL_CATEGORIES = 
        "SELECT ID, Name, ParentID FROM ProductCategory ORDER BY ParentID ASC, ID ASC";

    // Phương thức kết nối DB (giống ProductDAO)
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(jdbcURL); 
        } catch (ClassNotFoundException e) {
            // Ném ngoại lệ SQL để báo lỗi Driver
            throw new SQLException("SQL Server Driver not found.", e);
        }
    }

    /**
     * Lấy tất cả danh mục và xây dựng cấu trúc cây phân cấp (Menu Đa cấp).
     * @return Danh sách các Category cấp Cha (Root) đã chứa danh sách SubCategories.
     */
    public List<Category> getAllCategoriesTree() {
        List<Category> allCategories = new ArrayList<>();
        // Map dùng để tra cứu nhanh Category cha bằng ID (Key: ID, Value: Category Object)
        Map<Integer, Category> categoryMap = new HashMap<>();
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CATEGORIES);
             ResultSet rs = preparedStatement.executeQuery()) {

            // 1. Lấy tất cả danh mục phẳng (Flattened list) và ánh xạ vào Category Model
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("ID"));
                category.setName(rs.getString("Name"));
                
                // Xử lý ParentID: Kiểm tra NULL
                int parentId = rs.getInt("ParentID");
                if (!rs.wasNull()) {
                    category.setParentID(parentId);
                }
                // Khởi tạo danh sách con, sau đó sẽ điền vào
                category.setSubCategories(new ArrayList<>()); 
                
                allCategories.add(category);
                categoryMap.put(category.getId(), category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 2. Xây dựng cây (Tree Structure)
        List<Category> rootCategories = new ArrayList<>();
        for (Category cat : allCategories) {
            if (cat.getParentID() == null) {
                // Nếu ParentID là NULL, đây là danh mục cấp Cha (Root)
                rootCategories.add(cat);
            } else {
                // Nếu có ParentID, tìm đối tượng Cha trong Map và thêm vào danh sách con của nó
                Category parent = categoryMap.get(cat.getParentID());
                if (parent != null) {
                    parent.getSubCategories().add(cat);
                }
            }
        }
        return rootCategories;
    }
}
