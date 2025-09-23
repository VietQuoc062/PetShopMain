package com.petshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petshop.model.User;
import com.petshop.util.DBUtil;

public class UserDAO {
    private static final String SELECT_ALL_USERS = "SELECT id, username, password, role FROM Users";
    private static final String SELECT_USER_BY_CREDENTIALS = "SELECT id, username, password, role FROM Users WHERE username=? AND password=?";
    private static final String INSERT_USER = "INSERT INTO Users(username, password, role) VALUES (?, ?, ?)";
    private static final String DELETE_USER_BY_USERNAME = "DELETE FROM Users WHERE username=?";
    private static final String SELECT_USER_BY_USERNAME = "SELECT COUNT(*) FROM Users WHERE username=?";

    public static List<User> getUsers() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_USERS);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                users.add(new User(rs.getInt("id"), rs.getString("username"), 
                    rs.getString("password"), rs.getString("role")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static User login(String username, String password) {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            return null;
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_CREDENTIALS)) {
            
            ps.setString(1, username.trim());
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt("id"), rs.getString("username"), 
                        rs.getString("password"), rs.getString("role"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean addUser(String username, String password, String role) {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            return false;
        }
        
        if (isUsernameExists(username)) {
            return false;
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_USER)) {
            
            ps.setString(1, username.trim());
            ps.setString(2, password);
            ps.setString(3, role.toUpperCase());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean addUser(User user) {
        if (user == null) return false;
        return addUser(user.getUsername(), user.getPassword(), user.getRole());
    }

    public static boolean deleteUser(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_USER_BY_USERNAME)) {
            
            ps.setString(1, username.trim());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private static boolean isUsernameExists(String username) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_USERNAME)) {
            
            ps.setString(1, username.trim());
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
