package com.shop.servlet;

import com.shop.dao.OrderDAO;
import com.shop.model.Order;
import com.shop.model.OrderDetail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Chưa đăng nhập
            response.sendRedirect("index.jsp?error=not_logged_in");
            return;
        }
        List<?> cart = (List<?>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("index.jsp?error=empty_cart");
            return;
        }

        try {
            // Lấy customerId từ session
            int customerId = (int) session.getAttribute("userId"); // hoặc user.getId()
            String paymentMethod = request.getParameter("paymentMethod");
            String shippingAddress = request.getParameter("shippingAddress");

            // Lấy danh sách item từ form
            String[] itemIds = request.getParameterValues("itemId");
            String[] quantities = request.getParameterValues("quantity");
            String[] prices = request.getParameterValues("price");

            if (itemIds == null || itemIds.length == 0) {
                // Giỏ hàng trống
                response.sendRedirect("index.jsp?error=empty_cart");
                return;
            }

            double totalAmount = 0;
            List<OrderDetail> details = new ArrayList<>();

            for (int i = 0; i < itemIds.length; i++) {
                int itemId = Integer.parseInt(itemIds[i]);
                int qty = Integer.parseInt(quantities[i]);
                double price = Double.parseDouble(prices[i]);

                OrderDetail detail = new OrderDetail();
                detail.setItemId(itemId);
                detail.setQuantity(qty);
                detail.setPrice(price);

                totalAmount += qty * price;
                details.add(detail);
            }

            // Tạo Order
            Order order = new Order();
            order.setCustomerId(customerId);
            order.setOrderDate(new Date());
            order.setAmount(totalAmount);
            order.setPaymentMethod(paymentMethod);
            order.setShippingAddress(shippingAddress);
            order.setPaymentStatus("Pending");
            order.setOrderDetails(details);
            // Gắn Order vào từng OrderDetail
            for (OrderDetail od : details) {
                od.setOrder(order);
            }

            // Lưu vào DB
            OrderDAO dao = new OrderDAO();
            dao.insert(order); // nếu cascade ALL thì OrderDetail cũng được lưu


            // Redirect sang trang chi tiết đơn hàng
            response.sendRedirect("checkout-success.jsp?orderId=" + order.getOrderId());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }

    }
}
