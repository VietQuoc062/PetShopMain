package com.shop.servlet;

import com.shop.model.Order;
import com.shop.dao.OrderDetail;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/index")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String paymentMethod = request.getParameter("paymentMethod");

        // Tạo Order
        Order order = new Order(name, address, phone, email, paymentMethod);

        // Lấy giỏ hàng (đã set sẵn ở request hoặc session)
        List<OrderDetail> cartItems = (List<OrderDetail>) request.getSession().getAttribute("cartItems");

        // TODO: Lưu Order + OrderDetail vào DB qua DAO

        request.setAttribute("order", order);
        request.setAttribute("cartItems", cartItems);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/checkout-success.jsp");
        dispatcher.forward(request, response);
    }
}
