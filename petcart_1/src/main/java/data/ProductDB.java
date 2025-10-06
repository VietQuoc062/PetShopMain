package data;

import business.Product; 
import java.sql.*;

public class ProductDB {
    private String jdbcURL = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=PetShop;encrypt=false;trustServerCertificate=true";
    private String jdbcUser = "sa";        
    private String jdbcPassword = "123456"; 

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);
    }


    public Product getProductById(String id) {
        Product product = null;
        String sql = "SELECT id, name, price FROM Products WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String code = rs.getString("id");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                product = new Product(code,name, price);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

}
