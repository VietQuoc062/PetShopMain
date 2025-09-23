package com.petshop.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleLogout(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleLogout(req, resp);
    }
    
    private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
