package com.petshop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import com.petshop.dao.ProductDAO;
import com.petshop.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/products/*") // Sử dụng wildcard để xử lý các path con (list, add, edit, delete)
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Chuyển POST về GET để xử lý action
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo(); // Lấy phần path sau "/admin/products"
        if (action == null) {
            action = "/"; // Mặc định là trang list
        }

        try {
            switch (action) {
                case "/new": // Trang form thêm mới
                    showNewForm(request, response);
                    break;
                case "/insert": // Xử lý thêm mới
                    insertProduct(request, response);
                    break;
                case "/delete": // Xử lý xóa
                    deleteProduct(request, response);
                    break;
                case "/edit": // Trang form sửa
                    showEditForm(request, response);
                    break;
                case "/update": // Xử lý cập nhật
                    updateProduct(request, response);
                    break;
                case "/": // Mặc định: trang danh sách
                case "/list":
                default:
                    listProduct(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        List<Product> listProduct = productDAO.getAllProducts();
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("currentPage", "products"); // Để highlight menu sidebar
        request.getRequestDispatcher("/WEB-INF/views/admin/products/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("currentPage", "products");
        request.getRequestDispatcher("/WEB-INF/views/admin/products/add.jsp").forward(request, response);
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Đọc dữ liệu từ form
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận tiếng Việt
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stockQuantity");
        String imageUrl = request.getParameter("imageUrl");
        String categoryStr = request.getParameter("categoryId");
    
        // Validation
        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/products/new?error=name_required");
            return;
        }
    
        try {
            BigDecimal price = new BigDecimal(priceStr);
            if (price.signum() <= 0) {
                throw new NumberFormatException("Price must be positive");
            }
        
            int stockQuantity = Integer.parseInt(stockStr);
            if (stockQuantity < 0) {
                throw new NumberFormatException("Stock must be non-negative");
            }
        
            int categoryId = Integer.parseInt(categoryStr);
            if (categoryId <= 0) {
                throw new NumberFormatException("Category ID must be positive");
            }
        
            Product newProduct = new Product();
            newProduct.setName(name.trim());
            newProduct.setDescription(description != null ? description.trim() : null);
            newProduct.setPrice(price);
            newProduct.setStockQuantity(stockQuantity);
            newProduct.setImageUrl(imageUrl != null ? imageUrl.trim() : null);
            newProduct.setCategoryId(categoryId);
            
            productDAO.addProduct(newProduct);
            response.sendRedirect(request.getContextPath() + "/admin/products/list?message=add_success");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products/new?error=invalid_input");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product existingProduct = productDAO.getProductById(id);
        request.setAttribute("product", existingProduct);
        request.setAttribute("currentPage", "products");
        request.getRequestDispatcher("/WEB-INF/views/admin/products/edit.jsp").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String imageUrl = request.getParameter("imageUrl");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Product product = new Product(id, name, description, price, stockQuantity, imageUrl, categoryId, null); // createdAt sẽ giữ nguyên
        productDAO.updateProduct(product);
        response.sendRedirect(request.getContextPath() + "/admin/products/list?message=update_success");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/admin/products/list?message=delete_success");
    }
}