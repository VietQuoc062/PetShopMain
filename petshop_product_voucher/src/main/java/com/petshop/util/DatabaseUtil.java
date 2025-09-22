package com.petshop.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    private static final String JDBC_URL =
    "jdbc:sqlserver://DESKTOP-0AN9F32:1433;" +
    "databaseName=petshop;" +
    "integratedSecurity=true;" +
    "encrypt=true;" +
    "trustServerCertificate=true;";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // For Windows Authentication, no need to provide username/password
            connection = DriverManager.getConnection(JDBC_URL);
            
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            e.printStackTrace(); // Add this for better debugging
        }
        return connection;
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
            }
        }
    }
}