<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Trang lọc sản phẩm</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <!-- Tabs -->
  <div class="tabs">
    <button class="tab-btn active" data-tab="tab-pet">Thú cưng</button>
    <button class="tab-btn" data-tab="tab-product">Sản phẩm</button>
  </div>

  <!-- Sidebar lọc -->
<div class="sidebar">

  <!-- Tabs -->
  <div class="tabs">
    <button class="tab-btn active" data-tab="pets">Thú cưng</button>
    <button class="tab-btn" data-tab="products">Sản phẩm</button>
  </div>

  <!-- Nội dung tab Thú cưng -->
  <div class="tab-content active" id="tab-pets">
    <!-- Loại thú cưng -->
    <div class="filter-group">
      <h3 class="filter-header">
        Loại thú cưng
        <span class="arrow">▼</span>
      </h3>
      <div class="filter-options">
        <label><input type="checkbox" class="pettype" value="dog"> Chó</label><br>
        <label><input type="checkbox" class="pettype" value="cat"> Mèo</label><br>
      </div>
    </div>

    <!-- Mức giá -->
    <div class="filter-group">
      <h3 class="filter-header">
        Mức giá
        <span class="arrow">▼</span>
      </h3>
      <div class="filter-options">
        <!-- Thanh trượt -->
        <div class="price-slider">
          <input type="range" id="price-range" min="0" max="10000000" step="100000" value="10000000">
          <p>Giá: <span id="price-display">0 - 10,000,000</span> đồng</p>
        </div>

        <!-- Radio giá -->
        <label><input type="radio" name="price" value="all" checked> Tất cả</label><br>
        <label><input type="radio" name="price" value="0-1000000"> Dưới 1 triệu</label><br>
        <label><input type="radio" name="price" value="1000000-3000000"> 1 - 3 triệu</label><br>
        <label><input type="radio" name="price" value="3000000-10000000"> Trên 3 triệu</label><br>
      </div>
    </div>
  </div>

  <!-- Nội dung tab Sản phẩm -->
  <div class="tab-content" id="tab-products">
    <div class="filter-group">
      <h3 class="filter-header">
        Loại sản phẩm
        <span class="arrow">▼</span>
      </h3>
      <div class="filter-options">
        <label><input type="radio" name="ptype" value="all" checked> Tất cả</label><br>
        <label><input type="radio" name="ptype" value="food"> Thức ăn</label><br>
        <label><input type="radio" name="ptype" value="toy"> Đồ chơi</label><br>
        <label><input type="radio" name="ptype" value="accessory"> Phụ kiện</label><br>
      </div>
    </div>
  </div>
</div>

  <!-- Danh sách sản phẩm -->
  <div class="products" id="product-list"></div>

  <script src="js/script.js" defer></script>
</body>
</html>
