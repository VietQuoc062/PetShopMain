<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách Sản phẩm PetShop</title>

<style>
/* CSS cho Menu Đa cấp và Layout (Nên tách ra file styles.css) */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}
.container {
    width: 90%;
    margin: 20px auto;
    overflow: hidden; /* Dùng để chứa các phần tử float */
}
.sidebar {
    width: 250px;
    float: left;
    padding-right: 20px;
}
.product-area {
    margin-left: 270px; /* Dịch chuyển nội dung chính để tránh menu */
}

/* ----------------- MENU CSS ----------------- */
.category-menu {
    border: 1px solid #ddd;
    padding: 10px 0;
}
.category-menu h3 {
    padding: 0 10px 10px;
    margin: 0;
    border-bottom: 1px solid #eee;
}

.root-list {
    list-style: none;
    padding: 0;
    margin: 0;
}
.root-list > li {
    position: relative; /* Quan trọng cho việc định vị sub-list */
}
.root-list a {
    display: block;
    padding: 8px 10px;
    text-decoration: none;
    color: #333;
    border-bottom: 1px solid #eee;
    transition: background-color 0.2s;
}
.root-list a:hover {
    background-color: #f0f0f0;
}

/* CẤP CON (Sub-list) */
.sub-list {
    list-style: none;
    padding: 0;
    margin: 0;
    /* MẶC ĐỊNH ẨN */
    display: none; 
    
    /* Vị trí xổ ra */
    position: absolute;
    left: 100%; /* Đặt menu con nằm bên phải menu cha */
    top: 0;
    background-color: white;
    min-width: 200px;
    border: 1px solid #ccc;
    box-shadow: 3px 3px 5px rgba(0,0,0,0.1);
    z-index: 1000;
}

/* HIỆU ỨNG RÊ CHUỘT */
.root-list > li:hover > .sub-list {
    display: block; /* Hiện menu con khi rê chuột vào menu cha */
}

/* ----------------- PRODUCT CSS ----------------- */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
}
.product-card {
    border: 1px solid #ddd;
    text-align: center;
    padding: 15px;
    box-shadow: 1px 1px 5px rgba(0,0,0,0.05);
}
.product-image {
    width: 100%;
    height: 150px; /* Chiều cao cố định cho ảnh */
    object-fit: cover;
    margin-bottom: 10px;
}
.product-name {
    margin: 5px 0;
    font-size: 1em;
}
.product-price {
    color: #e60000;
    font-weight: bold;
}
.btn-buy {
    display: inline-block;
    background-color: #ff6600;
    color: white;
    padding: 8px 15px;
    text-decoration: none;
    border-radius: 4px;
    margin-top: 10px;
}
</style>
</head>
<body>

<div class="container">
    
    <div class="sidebar">
        <div class="category-menu">
            <h3>DANH MỤC SẢN PHẨM</h3>
            <ul class="root-list">
                <%-- LẶP CẤP CHA (Root Categories) --%>
                <c:forEach var="rootCat" items="${categories}">
                    <li>
                        <%-- Link đến Servlet, lọc theo ID của danh mục Cha --%>
                        <a href="products?categoryID=${rootCat.id}">${rootCat.name}</a>

                        <%-- KIỂM TRA VÀ LẶP CẤP CON (NẾU CÓ) --%>
                        <c:if test="${not empty rootCat.subCategories}">
                            <ul class="sub-list">
                                <c:forEach var="subCat" items="${rootCat.subCategories}">
                                    <li>
                                        <%-- Link đến Servlet, lọc theo ID của danh mục Con --%>
                                        <a href="products?categoryID=${subCat.id}">${subCat.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="product-area">
        <h2>Sản phẩm Dành cho Thú cưng</h2>
        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="item" items="${productList}">
                        <div class="product-card">
                            <%-- Giả định bạn có Servlet chi tiết sản phẩm map tới /detail --%>
                            <a href="detail?itemID=${item.id}">
                                <img src="${item.imageUrl}" alt="${item.name}" class="product-image">
                            </a>
                            <div class="product-info">
                                <h5 class="product-name">${item.name}</h5>
                                <p class="product-price">${item.price} VND</p>
                                <a href="add-to-cart?itemID=${item.id}" class="btn-buy">MUA NGAY</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>Không tìm thấy sản phẩm nào trong danh mục này.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
</div>
</body>
</html>