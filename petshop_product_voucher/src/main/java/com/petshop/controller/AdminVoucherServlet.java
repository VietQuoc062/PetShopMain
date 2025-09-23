package com.petshop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

import com.petshop.model.Voucher;
import com.petshop.service.VoucherService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/vouchers/*")
public class AdminVoucherServlet extends HttpServlet {
    private VoucherService voucherService;
    public void init() { voucherService = new VoucherService(); }

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

    private LocalDateTime parseDateTimeLocal(String val) {
        if (val == null || val.isEmpty()) return null;
        try {
            // datetime-local format: "yyyy-MM-ddTHH:mm" -> LocalDateTime.parse supports ISO_LOCAL_DATE_TIME
            return LocalDateTime.parse(val);
        } catch (DateTimeParseException e) {
            // try to be lenient: replace space separator
            String t = val.replace(' ', 'T');
            try { return LocalDateTime.parse(t); }
            catch (DateTimeParseException ex) { throw new IllegalArgumentException("Invalid datetime format: " + val); }
        }
    }

    private void insertVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        BigDecimal discountAmount = new BigDecimal(request.getParameter("discountAmount"));
        BigDecimal minOrderValue = new BigDecimal(request.getParameter("minOrderValue"));
        LocalDateTime startDate = parseDateTimeLocal(request.getParameter("startDate"));
        LocalDateTime endDate = parseDateTimeLocal(request.getParameter("endDate"));
        boolean active = Boolean.parseBoolean(request.getParameter("active"));

        Voucher v = new Voucher();
        v.setCode(code); v.setDescription(description);
        v.setDiscountAmount(discountAmount); v.setMinOrderValue(minOrderValue);
        v.setStartDate(startDate); v.setEndDate(endDate); v.setActive(active);

        voucherService.addVoucher(v);
        response.sendRedirect(request.getContextPath() + "/admin/vouchers/list?message=add_success");
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        BigDecimal discountAmount = new BigDecimal(request.getParameter("discountAmount"));
        BigDecimal minOrderValue = new BigDecimal(request.getParameter("minOrderValue"));
        LocalDateTime startDate = parseDateTimeLocal(request.getParameter("startDate"));
        LocalDateTime endDate = parseDateTimeLocal(request.getParameter("endDate"));
        boolean active = Boolean.parseBoolean(request.getParameter("active"));

        Voucher v = new Voucher(id, code, description, discountAmount, minOrderValue, startDate, endDate, active);
        voucherService.updateVoucher(v);
        response.sendRedirect(request.getContextPath() + "/admin/vouchers/list?message=update_success");
    }

    private void listVoucher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        request.setAttribute("listVoucher", voucherService.getAllVouchers());
        request.setAttribute("currentPage","vouchers");
        request.getRequestDispatcher("/WEB-INF/views/admin/vouchers/list.jsp").forward(request,response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("currentPage", "vouchers");
        request.getRequestDispatcher("/WEB-INF/views/admin/vouchers/add.jsp").forward(request,response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Voucher voucher = voucherService.getVoucherById(id);
        if (voucher.getStartDate() != null) {
            request.setAttribute("startDateFormatted",
                voucher.getStartDate().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")));
        }
        if (voucher.getEndDate() != null) {
            request.setAttribute("endDateFormatted",
                voucher.getEndDate().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")));
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
