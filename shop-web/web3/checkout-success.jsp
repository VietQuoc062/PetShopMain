<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.shop.model.Order, com.shop.dao.OrderDetail" %>
<html>
<head>
    <title>Thanh toán thành công</title>
    <link rel="stylesheet" type="text/css" href="styles/checkout.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f9f9f9;
        }

        #dhtc {
            color: #28a745;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            text-align: center;
            font-size: 16px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            background-color: #fff;
        }

        th {
            background-color: #007bff;
            color: white;
            padding: 10px;
        }

        td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .back-home {
            display: block;
            width: 220px;
            margin: 30px auto;
            padding: 12px;
            background-color: #007bff;
            color: white;
            text-align: center;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        .back-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    Order order = (Order) request.getAttribute("order");
    List<OrderDetail> cartItems = (List<OrderDetail>) request.getAttribute("cartItems");
%>

<h2 id="dhtc">Đặt hàng thành công!</h2>
<p>Cảm ơn <b><%= order.getCustomerName() %></b> đã đặt hàng.</p>
<p>Phương thức thanh toán: <%= order.getPaymentMethod() %></p>

<h3 style="text-align:center;">Chi tiết đơn hàng</h3>
<table>
    <tr>
        <th>Sản phẩm</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Tổng</th>
    </tr>
    <%
        if (cartItems != null) {
            for (OrderDetail item : cartItems) {
    %>
    <tr>
        <td><%= item.getProductName() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= item.getPrice() %> đ</td>
        <td><%= item.getQuantity() * item.getPrice() %> đ</td>
    </tr>
    <%
            }
        }
    %>
</table>

<!-- Nút quay lại trang chủ -->
<a href="index.jsp" class="back-home">Quay lại trang chủ</a>

</body>
</html>
