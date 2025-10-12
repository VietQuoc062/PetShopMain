package com.petshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.petshop.dao.ProductDAO;
import com.petshop.model.Product;
import com.petshop.model.ProductCategory;

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
        // Get page parameter, default to 1
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 10; // 10 items per page
        int offset = (page - 1) * pageSize;
        
        // Get total count and paginated results
        int totalItems = productDAO.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        List<Product> listProduct = productDAO.getProductsPaginated(offset, pageSize);
        
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("currentPage", "products");
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/products/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Load all categories for the dropdown
        List<ProductCategory> categories = productDAO.getAllCategories();
        
        request.setAttribute("listCategories", categories);
        request.setAttribute("currentPage", "products");
        request.getRequestDispatcher("/WEB-INF/views/admin/products/add.jsp").forward(request, response);
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String categoryIdStr = request.getParameter("productCategoryID");

        // Validation
        if (category == null || category.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/products/new?error=category_required");
            return;
        }

        try {
            Integer productCategoryID = Integer.parseInt(categoryIdStr);
            if (productCategoryID <= 0) {
                throw new NumberFormatException("Category ID must be positive");
            }

            Product newProduct = new Product();
            newProduct.setCategory(category.trim());
            newProduct.setBrand(brand != null ? brand.trim() : null);
            newProduct.setProductCategoryID(productCategoryID);
            
            productDAO.addProduct(newProduct);
            response.sendRedirect(request.getContextPath() + "/admin/products/list?message=add_success");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products/new?error=invalid_input");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product existingProduct = productDAO.getProductById(id);
        
        // Load all categories for the dropdown
        List<ProductCategory> categories = productDAO.getAllCategories();
        
        request.setAttribute("product", existingProduct);
        request.setAttribute("listCategories", categories);
        request.setAttribute("currentPage", "products");
        request.getRequestDispatcher("/WEB-INF/views/admin/products/edit.jsp").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        Integer productCategoryID = Integer.parseInt(request.getParameter("productCategoryID"));

        Product product = new Product();
        product.setProductID(id);
        product.setCategory(category);
        product.setBrand(brand);
        product.setProductCategoryID(productCategoryID);
        
        productDAO.updateProduct(product);
        response.sendRedirect(request.getContextPath() + "/admin/products/list?message=update_success");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/admin/products/list?message=delete_success");
    }
}