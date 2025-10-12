package com.petweb.dao;

import com.petweb.model.Review;
import java.sql.*;
import java.util.*;
import java.time.LocalDateTime;

/**
 * ReviewDAO - sử dụng JPA khi có thư viện, fallback JDBC khi không có
 */
public class ReviewDAO {
    
    public boolean saveReview(Review review) {
        // Thử sử dụng JPA trước
        try {
            return saveReviewWithJPA(review);
        } catch (Exception e) {
            System.out.println("JPA not available, falling back to JDBC...");
            return saveReviewWithJDBC(review);
        }
    }
    
    private boolean saveReviewWithJPA(Review review) {
        try {
            // EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
            // em.getTransaction().begin();
            // em.persist(review);
            // em.getTransaction().commit();
            // em.close();
            // return true;
            throw new UnsupportedOperationException("JPA libraries not loaded");
        } catch (Exception e) {
            throw new UnsupportedOperationException("JPA libraries not loaded");
        }
    }
    
    private boolean saveReviewWithJDBC(Review review) {
        String sql = "INSERT INTO Review (ItemID, UserID, Rating, Comment) VALUES (?, ?, ?, ?)";
        String url = "jdbc:sqlserver://.;databaseName=master;trustServerCertificate=true";
        
        try (Connection conn = DriverManager.getConnection(url, "sa", "123");
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, review.getItemId());
            stmt.setInt(2, review.getUserId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Review> getReviewsByPetId(int petId) {
        // Thử sử dụng JPA trước
        try {
            return getReviewsByPetIdWithJPA(petId);
        } catch (Exception e) {
            System.out.println("JPA not available, falling back to JDBC...");
            return getReviewsByPetIdWithJDBC(petId);
        }
    }
    
    private List<Review> getReviewsByPetIdWithJPA(int petId) {
        try {
            // EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
            // TypedQuery<Review> query = em.createQuery(
            //     "SELECT r FROM Review r " +
            //     "WHERE r.item.pet.petId = :petId " +
            //     "ORDER BY r.reviewDate DESC", Review.class);
            // query.setParameter("petId", petId);
            // List<Review> reviews = query.getResultList();
            // em.close();
            // return reviews;
            throw new UnsupportedOperationException("JPA libraries not loaded");
        } catch (Exception e) {
            throw new UnsupportedOperationException("JPA libraries not loaded");
        }
    }
    
    private List<Review> getReviewsByPetIdWithJDBC(int petId) {
        List<Review> reviews = new ArrayList<>();
        
        String sql = "SELECT r.ReviewID, r.ItemID, r.UserID, r.Rating, r.Comment, r.ReviewDate, " +
                    "COALESCE(u.Name, 'Khách hàng') as FullName, " +
                    "COALESCE(u.Email, 'N/A') as Email " +
                    "FROM Review r " +
                    "LEFT JOIN [User] u ON r.UserID = u.UserID " +
                    "WHERE r.ItemID = ? " +
                    "ORDER BY r.ReviewDate DESC";
        
        String url = "jdbc:sqlserver://.;databaseName=master;trustServerCertificate=true";
        
        try {
            // Load JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            // Driver not found, return empty list
            return reviews;
        }
        
        try (Connection conn = DriverManager.getConnection(url, "sa", "123");
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, petId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("ReviewID"));
                review.setItemId(rs.getInt("ItemID"));
                review.setUserId(rs.getInt("UserID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                Timestamp timestamp = rs.getTimestamp("ReviewDate");
                if (timestamp != null) {
                    review.setReviewDate(timestamp.toLocalDateTime());
                }
                review.setFullName(rs.getString("FullName"));
                review.setEmail(rs.getString("Email"));
                
                reviews.add(review);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return reviews;
    }
}
