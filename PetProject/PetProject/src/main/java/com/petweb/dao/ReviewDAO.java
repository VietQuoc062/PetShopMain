package com.petweb.dao;

import com.petweb.database.DatabaseConnection;
import com.petweb.model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    
    public boolean saveReview(Review review) {
        String sql = "INSERT INTO Reviews (pet_id, full_name, email, phone, comment, rating) VALUES (?, ?, ?, ?, ?, ?)";
        
        System.out.println("=== ReviewDAO Debug ===");
        System.out.println("SQL: " + sql);
        System.out.println("Review data:");
        System.out.println("  petId: " + review.getPetId());
        System.out.println("  fullName: " + review.getFullName());
        System.out.println("  email: " + review.getEmail());
        System.out.println("  phone: " + review.getPhone());
        System.out.println("  comment: " + review.getComment());
        System.out.println("  rating: " + review.getRating());
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            System.out.println("Database connection successful!");
            
            stmt.setInt(1, review.getPetId());
            stmt.setString(2, review.getFullName());
            stmt.setString(3, review.getEmail());
            stmt.setString(4, review.getPhone());
            stmt.setString(5, review.getComment());
            stmt.setInt(6, review.getRating());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("SQL Exception occurred:");
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.out.println("General Exception occurred:");
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Review> getReviewsByPetId(int petId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM Reviews WHERE pet_id = ? ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, petId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setPetId(rs.getInt("pet_id"));
                review.setFullName(rs.getString("full_name"));
                review.setEmail(rs.getString("email"));
                review.setPhone(rs.getString("phone"));
                review.setComment(rs.getString("comment"));
                review.setRating(rs.getInt("rating"));
                review.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                
                reviews.add(review);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return reviews;
    }
}
