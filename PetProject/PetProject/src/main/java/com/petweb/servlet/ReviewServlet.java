package com.petweb.servlet;

import com.petweb.dao.ReviewDAO;
import com.petweb.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/submit-review")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewDAO reviewDAO = new ReviewDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Debug: Log request parameters
        System.out.println("=== ReviewServlet Debug ===");
        System.out.println("Request parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println(key + " = " + String.join(", ", values));
        });
        
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String comment = request.getParameter("comment");
        String petIdStr = request.getParameter("petId");
        
        System.out.println("Extracted values:");
        System.out.println("fullName: " + fullName);
        System.out.println("email: " + email);
        System.out.println("phone: " + phone);
        System.out.println("comment: " + comment);
        System.out.println("petId: " + petIdStr);
        
        // Validate dữ liệu
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            comment == null || comment.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            request.getRequestDispatcher("/petDetail.jsp").forward(request, response);
            return;
        }
        
        try {
            int petId = Integer.parseInt(petIdStr != null ? petIdStr : "1");
            
            // Tạo đối tượng Review
            Review review = new Review();
            review.setPetId(petId);
            review.setFullName(fullName.trim());
            review.setEmail(email.trim());
            review.setPhone(phone != null ? phone.trim() : "");
            review.setComment(comment.trim());
            review.setRating(5); // Mặc định 5 sao
            
            // Lưu vào database
            System.out.println("Attempting to save review to database...");
            boolean success = reviewDAO.saveReview(review);
            System.out.println("Save result: " + success);
            
            if (success) {
                request.setAttribute("success", "Cảm ơn bạn đã đánh giá! Đánh giá đã được lưu thành công.");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi lưu đánh giá. Vui lòng thử lại!");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sản phẩm không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại sau!");
        }
        
        // Forward về trang chi tiết
        request.getRequestDispatcher("/petDetail.jsp").forward(request, response);
    }
}
