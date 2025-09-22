<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Pet Shop</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f8f9fa; }
        .container { display: flex; margin: 20px; }
        .filters { width: 250px; padding: 15px; background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .products { flex: 1; margin-left: 20px; display: grid; grid-template-columns: repeat(auto-fill, minmax(200px,1fr)); gap: 15px; }
        .product { background:white; padding:10px; border-radius:8px; text-align:center; box-shadow:0 2px 6px rgba(0,0,0,0.1); }
        .product img { width:100px; height:100px; object-fit:cover; }
        .price { color:#e63946; font-weight:bold; }
        h3 { margin-top:0; }
    </style>
</head>
<body>
<div class="container">
    <div class="filters">
        <form method="get" action="products">
            <h3>Lọc sản phẩm</h3>
            <div>
                <label><input type="radio" name="petType" value="all" checked> Tất cả</label><br>
                <label><input type="radio" name="petType" value="cat"> Mèo</label><br>
                <label><input type="radio" name="petType" value="dog"> Chó</label>
            </div>
            <hr>
            <div>
                <label>Giá từ: <input type="number" name="min" placeholder="0"></label><br>
                <label>Đến: <input type="number" name="max" placeholder="10000000"></label>
            </div>
            <br>
            <button type="submit">Lọc</button>
        </form>
    </div>
    <div class="products">
        <c:forEach var="p" items="${products}">
            <div class="product">
                <img src="${p.img}" alt="${p.name}"/>
                <h4>${p.name}</h4>
                <div class="price">${p.price} đ</div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
