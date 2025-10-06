<!-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<!DOCTYPE html>

<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cart</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="styles/index.css" />
  </head>
  <body>
    <table class="table table-bordered">
      <tr>
        <th>Mã sản phẩm</th>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Thao tác</th>
      </tr>
      <tr>
        <td>01</td>
        <td>Poodle Teacup</td>
        <td>1.800.000 vnd</td>
        <td>
          <button
            type="button"
            class="btn btn-primary add-to-cart-btn"
            data-id="01"
            data-name="Poodle Teacup"
            data-price="1800000"
            data-description="Giống chó nhỏ nhắn, đáng yêu."
          >
            Add
          </button>
        </td>
      </tr>
      <tr>
        <td>02</td>
        <td>Poodle Tiny</td>
        <td>3.800.000 vnd</td>
        <td>
          <button
            type="button"
            class="btn btn-primary add-to-cart-btn"
            data-id="02"
            data-name="Poodle Tiny"
            data-price="3800000"
            data-description="Giống chó nhỏ, lông xoăn."
          >
            Add
          </button>
        </td>
      </tr>
      <tr>
        <td>03</td>
        <td>Poodle</td>
        <td>5.800.000 vnd</td>
        <td>
          <button
            type="button"
            class="btn btn-primary add-to-cart-btn"
            data-id="03"
            data-name="Poodle"
            data-price="5800000"
            data-description="Giống chó phổ biến, thông minh."
          >
            Add
          </button>
        </td>
      </tr>
      <tr>
        <td>04</td>
        <td>Pug</td>
        <td>2.800.000 vnd</td>
        <td>
          <button
            type="button"
            class="btn btn-primary add-to-cart-btn"
            data-id="04"
            data-name="Pug"
            data-price="2800000"
            data-description="Chó mặt xệ, dễ thương."
          >
            Add
          </button>
        </td>
      </tr>
      <tr>
        <td>05</td>
        <td>Bully</td>
        <td>7.700.000 vnd</td>
        <td>
          <button
            type="button"
            class="btn btn-primary add-to-cart-btn"
            data-id="05"
            data-name="Bully"
            data-price="7700000"
            data-description="Giống chó khỏe mạnh, cơ bắp."
          >
            Add
          </button>
        </td>
      </tr>
    </table>

    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-md modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Thông tin sản phẩm</h5>
            <button
              type="button"
              class="close"
              data-bs-dismiss="modal"
              aria-label="close"
              size
              color
            >
              <span aria-hidden="true">x</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="modal-info-wrap">
              <img id="modalProductImage" src="" alt="" class="imagePet" />
              <h5 class="modal-title" id="modalProductName">Tên sản phẩm</h5>
              <div class="row">
                <p>Giá: <span id="modalProductPrice"></span></p>
                <label>Số lượng:</label>
                <input
                  type="number"
                  name="modalProductQuantity"
                  id="modalProductQuantity"
                  value="1"
                  min="1"
                />
                <p>Mô tả: <span id="modalProductDescription"></span></p>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <form action="CartServlet" method="post">
              <input type="hidden" name="action" value="add" />
              <input type="hidden" name="productId" id="modalProductCode" />
              <input
                type="hidden"
                name="productName"
                id="modalProductNameInput"
              />
              <input
                type="hidden"
                name="productPrice"
                id="modalProductPriceInput"
              />
              <input
                type="hidden"
                name="modalProductQuantity"
                id="formQuantity"
              />
              <input type="submit" value="Thêm vào giỏ hàng" />
            </form>
            <form action="buy" method="post">
              <input type="hidden" name="action" value="buy" />
              <input type="submit" value="Thanh toán" />
            </form>
          </div>
        </div>
      </div>
    </div>
    <form action="CartServlet" method="post">
      <input type="hidden" name="action" value="cart" />
      <input type="submit" value="Cart" />
    </form>
    <script src="./assets/js/cart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
