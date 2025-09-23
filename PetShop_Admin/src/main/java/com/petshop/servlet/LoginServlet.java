package com.petshop.servlet;

import com.petshop.dao.UserDAO;
import com.petshop.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        
        try {
            User user = UserDAO.login(username.trim(), password);
            
            if (user != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(30 * 60);
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            } else {
                req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }
        
        req.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
