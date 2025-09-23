<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.shop.dao.OrderDetail" %>
<html>
<head>
    <title>Thanh toán</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>


<h2 class = "header">Xác nhận đơn hàng</h2>


<table class = "order-table">
    <tr>
        <th>Sản phẩm</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Tổng</th>
    </tr>
    <%
        // Giả định có list OrderDetail được gửi từ controller
        List<OrderDetail> items = (List<OrderDetail>) request.getAttribute("cartItems");
        double grandTotal = 0;
        if (items != null) {
            for (OrderDetail item : items) {
                grandTotal += item.getQuantity() * item.getPrice();
    %>
    <tr>
        <td><%= item.getProductName() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= item.getPrice() %></td>
        <td><%= item.getQuantity() * item.getPrice() %></td>
    </tr>
    <%
            }
        }
    %>
    <tr>
        <td colspan="3"><b>Tổng cộng</b></td>
        <td><b><%= grandTotal %></b></td>
    </tr>
</table>
<form action="index" method="post" class="checkout-form">
    <h3 id="tttt">Thông tin thanh toán</h3>

    <div class="form-group">
        <label for="name">Họ và tên</label>
        <input type="text" id="name" name="name" required>
    </div>

    <div class="form-group">
        <label for="address">Địa chỉ</label>
        <textarea id="address" name="address" required></textarea>
    </div>

    <div class="form-group">
        <label for="phone">Số điện thoại</label>
        <input type="text" id="phone" name="phone" required>
    </div>

    <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
        <label for="paymentMethod">Phương thức thanh toán</label>
        <select id="paymentMethod" name="paymentMethod" required>
            <option value="COD">Thanh toán khi nhận hàng</option>
            <option value="BANK">Chuyển khoản</option>
            <option value="CARD">Thẻ tín dụng</option>
        </select>
    </div>

    <div class="form-actions">
        <button id="comeback" type="button">Quay lại trang giỏ hàng</button>
        <button id="thanhtoan" type="submit">Xác nhận thanh toán</button>
    </div>
</form>

</body>
</html>
