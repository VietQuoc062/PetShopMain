package com.petshop.dao; 

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petshop.model.Item;

public class ProductDAO { // Vẫn giữ tên ProductDAO

    // SỬ DỤNG WINDOWS AUTHENTICATION (Integrated Security)
    private String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PetShopDB;integratedSecurity=true;encrypt=false"; 
    
    // Đổi tên hằng số này để chuẩn bị cho việc lọc sản phẩm theo Category
    private static final String SELECT_ALL_ITEMS_DEFAULT = "SELECT ItemID, Name, Price, ImageUrl, Description FROM Item";
    private static final String SEARCH_ITEMS = "SELECT ItemID, Name, Price, ImageUrl, Description FROM Item WHERE Name LIKE ? OR Description LIKE ?";

    // Thêm câu lệnh mới để lọc theo danh mục
    private static final String SELECT_ITEMS_BY_CATEGORY = 
            "SELECT ItemID, Name, Price, ImageUrl, Description FROM Item WHERE CategoryID = ?";


    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Kết nối bằng chuỗi có integratedSecurity=true
            return DriverManager.getConnection(jdbcURL); 
            
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server Driver not found.", e);
        }
    }

    private Item mapRowToItem(ResultSet rs) throws SQLException {
        int id = rs.getInt("ItemID");
        String name = rs.getString("Name");
        BigDecimal price = rs.getBigDecimal("Price"); 
        String imageUrl = rs.getString("ImageUrl");
        String description = rs.getString("Description");
        return new Item(id, name, price, imageUrl, description);
    }

    // Phương thức đã sửa: listAllItems -> listItems (có thể nhận CategoryID)
    public List<Item> listItems(Integer categoryId) {
        List<Item> itemList = new ArrayList<>();
        String sql = (categoryId != null) ? SELECT_ITEMS_BY_CATEGORY : SELECT_ALL_ITEMS_DEFAULT;
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            
            // Nếu có CategoryID, set tham số
            if (categoryId != null) {
                preparedStatement.setInt(1, categoryId);
            }

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    itemList.add(mapRowToItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }
    
    // Giữ nguyên logic tìm kiếm (searchItems)
    public List<Item> searchItems(String keyword) {
        List<Item> itemList = new ArrayList<>();
        String searchPattern = "%" + keyword + "%"; 

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_ITEMS)) {

            preparedStatement.setString(1, searchPattern); 
            preparedStatement.setString(2, searchPattern); 

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    itemList.add(mapRowToItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }
}