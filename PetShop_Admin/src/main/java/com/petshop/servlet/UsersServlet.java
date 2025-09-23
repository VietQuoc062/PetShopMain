package com.petshop.servlet;

import com.petshop.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", UserDAO.getUsers());
        req.getRequestDispatcher("users.jsp").forward(req, resp);
    }
}
