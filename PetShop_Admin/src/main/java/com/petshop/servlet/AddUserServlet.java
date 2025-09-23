package com.petshop.servlet;

import com.petshop.dao.UserDAO;
import com.petshop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User u = new User(0, username, password, role);

        if (UserDAO.addUser(u)) {
            resp.sendRedirect(req.getContextPath() + "/roles.jsp");
        } else {
            req.setAttribute("error", "Không thể thêm user!");
            req.getRequestDispatcher("roles.jsp").forward(req, resp);
        }
    }
}
