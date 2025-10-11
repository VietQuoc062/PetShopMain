<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shop.dao.OrderDAO, com.shop.dao.ItemDAO, com.shop.model.Order, com.shop.model.OrderDetail, com.shop.model.Item, java.util.List" %>
<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css?v=1">
</head>
<body>

<h1 class="page-header">Chi tiết đơn hàng</h1>

<%
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    Order order = new OrderDAO().findById(orderId);
    List<OrderDetail> details = order.getOrderDetails();
    ItemDAO itemDAO = new ItemDAO();
%>

<div class="order-info">
    <p><strong>Order ID:</strong> <%= order.getOrderId() %></p>
    <p><strong>Ngày đặt:</strong> <%= order.getOrderDate() %></p>
    <p><strong>Phương thức thanh toán:</strong> <%= order.getPaymentMethod() %></p>
    <p><strong>Địa chỉ giao hàng:</strong> <%= order.getShippingAddress() %></p>
    <p><strong>Tổng tiền:</strong> <%= order.getAmount() %></p>
</div>

<table class="order-table">
    <thead>
    <tr>
        <th>Sản phẩm</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Thành tiền</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (OrderDetail detail : details) {
            Item item = itemDAO.findById(detail.getItemId());
    %>
    <tr>
        <td><%= item.getName() %></td>
        <td><%= detail.getQuantity() %></td>
        <td><%= detail.getPrice() %></td>
        <td><%= detail.getQuantity() * detail.getPrice() %></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<div class="back-button">
    <a href="index.jsp"><button>Quay lại giỏ hàng</button></a>
</div>

</body>
</html>
