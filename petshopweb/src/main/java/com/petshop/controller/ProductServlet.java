package com.petshop.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petshop.dao.CategoryDAO;
import com.petshop.dao.ProductDAO; // Giả định bạn đã đổi tên ProductDAO để xử lý Item
import com.petshop.model.Category;
import com.petshop.model.Item;

@WebServlet("/products") // Giả định Servlet mapping là /products
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // --- 1. XỬ LÝ MENU ĐA CẤP ---
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategoriesTree();
        request.setAttribute("categories", categories); // Gán Menu vào request
        
        // --- 2. XỬ LÝ LỌC SẢN PHẨM ---
        ProductDAO productDAO = new ProductDAO();
        List<Item> productList = null;
        Integer categoryId = null;

        // Lấy tham số categoryID từ URL (ví dụ: /products?categoryID=21)
        String categoryIdParam = request.getParameter("categoryID");

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
                // Lấy sản phẩm theo Danh mục ID
                productList = productDAO.listItems(categoryId);
            } catch (NumberFormatException e) {
                // Nếu tham số không hợp lệ, vẫn tải tất cả sản phẩm
                productList = productDAO.listItems(null); 
            }
        } else {
            // Lấy tất cả sản phẩm mặc định
            productList = productDAO.listItems(null);
        }
        
        // Gán danh sách sản phẩm vào request
        request.setAttribute("productList", productList);
        
        // Chuyển tiếp tới trang JSP để hiển thị
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}