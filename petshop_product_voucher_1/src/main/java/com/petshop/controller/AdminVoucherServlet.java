package com.petshop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

import com.petshop.dao.ProductDAO;
import com.petshop.model.ProductCategory;
import com.petshop.model.Promotion;
import com.petshop.service.VoucherService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/vouchers/*")
public class AdminVoucherServlet extends HttpServlet {
    private VoucherService voucherService;
    private ProductDAO productDAO;
    
    public void init() { 
        voucherService = new VoucherService(); 
        productDAO = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/";
        try {
            switch (action) {
                case "/new": showNewForm(request,response); break;
                case "/insert": insertVoucher(request,response); break;
                case "/delete": deleteVoucher(request,response); break;
                case "/edit": showEditForm(request,response); break;
                case "/update": updateVoucher(request,response); break;
                default: listVoucher(request,response); break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            // Forward về trang thêm mới hoặc trang lỗi phù hợp
            String redirectPath = request.getPathInfo() != null && request.getPathInfo().equals("/insert") 
                ? "/admin/vouchers/new" : "/admin/vouchers/list";
            request.setAttribute("currentPage", "vouchers");
            request.getRequestDispatcher(redirectPath + ".jsp").forward(request, response);
        }
    }

    private LocalDate parseDate(String val) {
        if (val == null || val.isEmpty()) return null;
        try {
            return LocalDate.parse(val);
        } catch (DateTimeParseException ex) { 
            throw new IllegalArgumentException("Invalid date format: " + val); 
        }
    }

    private void insertVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        BigDecimal discountPercent = new BigDecimal(request.getParameter("discountPercent"));
        LocalDate startDate = parseDate(request.getParameter("startDate"));
        LocalDate endDate = parseDate(request.getParameter("endDate"));
        Integer productCategoryID = Integer.parseInt(request.getParameter("productCategoryID"));

        // Validate date range
        if (startDate != null && endDate != null && !startDate.isBefore(endDate)) {
            // Redirect back to form with error message
            response.sendRedirect(request.getContextPath() + "/admin/vouchers/new?error=invalid_date_range");
            return;
        }

        Promotion v = new Promotion();
        v.setName(name);
        v.setCode(code);
        v.setDiscountPercent(discountPercent);
        v.setStartDate(startDate);
        v.setEndDate(endDate);
        
        // Create a ProductCategory object with the selected ID
        ProductCategory category = new ProductCategory();
        category.setProductCategoryID(productCategoryID);
        v.setProductCategory(category);

        voucherService.addVoucher(v);
        response.sendRedirect(request.getContextPath() + "/admin/vouchers/list?message=add_success");
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        BigDecimal discountPercent = new BigDecimal(request.getParameter("discountPercent"));
        LocalDate startDate = parseDate(request.getParameter("startDate"));
        LocalDate endDate = parseDate(request.getParameter("endDate"));

        // Validate date range
        if (startDate != null && endDate != null && !startDate.isBefore(endDate)) {
            // Redirect back to edit form with error message
            response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id + "&error=invalid_date_range");
            return;
        }

        Promotion v = new Promotion();
        v.setPromotionID(id);
        v.setName(name);
        v.setCode(code);
        v.setDiscountPercent(discountPercent);
        v.setStartDate(startDate);
        v.setEndDate(endDate);
        
        voucherService.updateVoucher(v);
        response.sendRedirect(request.getContextPath() + "/admin/vouchers/list?message=update_success");
    }

    private void listVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
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
        int totalItems = voucherService.getTotalVoucherCount();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        List<Promotion> listVoucher = voucherService.getVouchersPaginated(offset, pageSize);
        
        // Debug: Print promotion names to console
        System.out.println("=== PROMOTIONS RETRIEVED ===");
        for (Promotion p : listVoucher) {
            System.out.println("ID: " + p.getPromotionID() + ", Name: " + p.getName() + ", Code: " + p.getCode());
        }
        System.out.println("===========================");
        
        request.setAttribute("listVoucher", listVoucher);
        request.setAttribute("currentPage", "vouchers");
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/vouchers/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Load all product categories for the dropdown
            List<ProductCategory> categories = productDAO.getAllCategories();
            request.setAttribute("listCategories", categories);
            request.setAttribute("currentPage", "vouchers");
            request.getRequestDispatcher("/WEB-INF/views/admin/vouchers/add.jsp").forward(request, response);
        } catch (Exception ex) {
            throw new ServletException("Error loading categories", ex);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Promotion voucher = voucherService.getVoucherById(id);
        
        // Format dates for HTML date input (yyyy-MM-dd format)
        if (voucher.getStartDate() != null) {
            request.setAttribute("startDateFormatted", voucher.getStartDate().toString());
        }
        if (voucher.getEndDate() != null) {
            request.setAttribute("endDateFormatted", voucher.getEndDate().toString());
        }
        
        request.setAttribute("voucher", voucher);
        request.setAttribute("currentPage", "vouchers");
        request.getRequestDispatcher("/WEB-INF/views/admin/vouchers/edit.jsp").forward(request, response);
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        voucherService.deleteVoucher(id);
        response.sendRedirect(request.getContextPath() + "/admin/vouchers/list?message=delete_success");
    }
}
