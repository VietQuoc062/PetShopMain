<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thanh toán</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css?v=1">
</head>
<body>
<%
    String error = request.getParameter("error");
    if ("empty_cart".equals(error)) {
%>
<script>
    alert("Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm trước khi thanh toán.");
</script>
<%
    }
%>
<h1 class = "order-header">Thanh toán đơn hàng</h1>

<form action="checkout" method="post" class = "checkout-form">
    <c:set var="cart" value="${sessionScope.cart}" />
    <c:set var="total" value="0" />
    <table class = "checkout-table">
        <tr>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Thành tiền</th>
        </tr>
        <c:choose>
            <c:when test="${not empty cart}">
                <c:forEach var="item" items="${cart}">
                    <tr>
                        <td>${item.name}</td>
                        <td>${item.quantity}</td>
                        <td>${item.price}</td>
                        <td>${item.price * item.quantity}</td>

                        <input type="hidden" name="itemId" value="${item.id}" />
                        <input type="hidden" name="quantity" value="${item.quantity}" />
                        <input type="hidden" name="price" value="${item.price}" />

                        <c:set var="total" value="${total + (item.price * item.quantity)}" />
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4" class = "empty-cart">Giỏ hàng trống</td>
                </tr>
            </c:otherwise>
        </c:choose>
        <tr>
            <td colspan="3"><strong>Tổng tiền:</strong></td>
            <td><strong>${total}</strong></td>
        </tr>
    </table>

    <input type="hidden" name="customerId" value="${sessionScope.user.id}" />
    <input type="hidden" name="amount" value="${total}" />

    <div class="form-group">
        <label>Địa chỉ giao hàng:</label>
        <input type="text" name="shippingAddress" placeholder="Nhập địa chỉ" required />
    </div>
    <div class="form-group">
        <label>Phương thức thanh toán:</label>
        <select name="paymentMethod" required>
            <option value="Cash">Tiền mặt</option>
            <option value="Bank_Transfer">Chuyển khoản</option>
            <option value="Ewallet">Ví điện tử</option>
        </select>
    </div>

    <div class="button-group">
        <a href="cart.jsp" class="back-btn">← Quay lại giỏ hàng</a>
        <button type="submit" class="checkout-btn">Thanh toán</button>
    </div>
</form>

</body>
</html>
