package com.petshop.servlet;

import java.io.IOException;
import java.util.List;

import com.petshop.dao.UserDAO;
import com.petshop.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RoleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        User currentUser = getCurrentUser(req);
        if (currentUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        if (!isAdmin(currentUser)) {
            req.setAttribute("error", "⚠️ Truy cập bị từ chối. Bạn không đủ quyền để vào trang này.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        try {
            List<User> users = UserDAO.getUsers();
            req.setAttribute("users", users);
            req.setAttribute("currentUser", currentUser);
            req.getRequestDispatcher("roles.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Đã xảy ra lỗi khi tải danh sách người dùng.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        User currentUser = getCurrentUser(req);
        if (currentUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        if (!isAdmin(currentUser)) {
            resp.sendRedirect("error.jsp");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                handleAddUser(req, resp);
            } else if ("delete".equals(action)) {
                handleDeleteUser(req, resp, currentUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("roles");
    }
    
    private void handleAddUser(HttpServletRequest req, HttpServletResponse resp) {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        
        UserDAO.addUser(username, password, role);
    }
    
    private void handleDeleteUser(HttpServletRequest req, HttpServletResponse resp, User currentUser) {
        String username = req.getParameter("username");
        
        if (currentUser != null && currentUser.getUsername().equals(username)) {
            return; // Prevent self-deletion
        }
        
        UserDAO.deleteUser(username);
    }
    
    private User getCurrentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }
    
    private boolean isAdmin(User user) {
        return user != null && "ADMIN".equalsIgnoreCase(user.getRole());
    }
}
