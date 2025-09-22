<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="styles/cart.css">
    <title>Giỏ Hàng</title>
  </head>

  <body>
    <h1>Giỏ hàng của bạn</h1>
    <div class="cart-container">
      <table>
        <thead>
          <tr>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Tổng</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${sessionScope.cart.items}">
            <tr>
              <td>
                <div class="product-info">
                  <div class="product-image">🐾</div>
                  <div>
                    <div class="product-name">${item.product.name}</div>
                    <div class="product-code" style="font-size: 0.8em; color: var(--text-light);">ID: ${item.product.code}</div>
                  </div>
                </div>
              </td>
              <td>
                <form action="CartServlet" method="post" class="quantity-control">
                  <input type="hidden" name="action" value="update">
                  <input type="hidden" name="productCode" value="${item.product.code}">
                  <input type="text" name="quantity" value="${item.quantity}">
                  <input type="submit" value="Cập nhật" class="update-btn">
                </form>
              </td>
              <td>${item.product.priceCurrencyFormat}</td>
              <td>${item.totalCurrencyFormat}</td>
              <td>
                <form action="CartServlet" method="post">
                  <input type="hidden" name="productCode" value="${item.product.code}">
                  <input type="hidden" name="action" value="remove" />
                  <input type="submit" value="Xóa" class="remove-btn">
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <div class="cart-actions">
        <form action="CartServlet" method="post">
          <input type="hidden" name="action" value="shop">
          <input type="submit" value="Tiếp tục mua sắm" class="btn btn-continue">
        </form>
        <form action="checkout.jsp" method="post">
          <input type="hidden" name="action" value="checkout">
          <input type="submit" value="Thanh toán" class="btn btn-checkout">
        </form>
      </div>
    </div>
  </body>
</html>