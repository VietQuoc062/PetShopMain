package com.petshop.controller;

import java.io.IOException;

import com.petshop.dao.AccountDAO;
import com.petshop.model.Account;
import com.petshop.model.User;
import com.petshop.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AuthService authService;
    private AccountDAO accountDAO;

    public void init() {
        authService = new AuthService();
        accountDAO = new AccountDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            Account account = (Account) session.getAttribute("account");
            redirectToRolePage(account, response, request);
            return;
        }

        // Show login form
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Account account = authService.login(username, password);

        if (account != null) {
            // Get user information
            User user = accountDAO.getUserByAccountId(account.getAccountID());
            
            // Login successful
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            session.setAttribute("user", user);
            session.setAttribute("username", account.getUsername());
            session.setAttribute("role", account.getRole());
            
            // Set display name and role for UI
            if (user != null) {
                session.setAttribute("displayName", user.getName());
            } else {
                session.setAttribute("displayName", account.getUsername());
            }
            
            String roleDisplay = "";
            switch (account.getRole()) {
                case "Owner": roleDisplay = "Quản lý"; break;
                case "Staff": roleDisplay = "Nhân viên"; break;
                case "Customer": roleDisplay = "Khách hàng"; break;
                default: roleDisplay = account.getRole(); break;
            }
            session.setAttribute("roleDisplay", roleDisplay);

            redirectToRolePage(account, response, request);
        } else {
            // Login failed
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    private void redirectToRolePage(Account account, HttpServletResponse response, HttpServletRequest request) throws IOException {
        if (account.isOwner()) {
            response.sendRedirect(request.getContextPath() + "/admin/products/list");
        } else if (account.isStaff()) {
            // Staff goes to admin panel but with read-only access
            response.sendRedirect(request.getContextPath() + "/admin/products/list");
        } else {
            // Customer gets access denied page
            response.sendRedirect(request.getContextPath() + "/access-denied");
        }
    }
}
