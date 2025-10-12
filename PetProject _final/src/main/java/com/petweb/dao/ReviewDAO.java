package com.petweb.dao;
import java.util.*;
public class ReviewDAO {
    public List<Map<String, Object>> getReviewsByItemId(int itemId) {
        return new ArrayList<>();
    }
    
    public boolean saveReview(int itemId, int userId, int rating, String comment, String fullName, String email) {
        return true; // Giả lập lưu thành công
    }
}
