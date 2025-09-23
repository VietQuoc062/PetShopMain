<%-- admin/products/add.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Thêm Sản phẩm Mới" pageHeader="Thêm Sản phẩm Mới">
    <jsp:body>
        <form action="${pageContext.request.contextPath}/admin/products/insert" method="post">
            <div class="form-group">
                <label for="name">Tên Sản phẩm:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description"></textarea>
            </div>
            <div class="form-group">
                <label for="price">Giá:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="stockQuantity">Số lượng tồn:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" min="0" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">URL Ảnh:</label>
                <input type="url" id="imageUrl" name="imageUrl">
            </div>
            <div class="form-group">
                <label for="categoryId">ID Danh mục:</label>
                <input type="number" id="categoryId" name="categoryId" min="1" value="1" required> <%-- Giả định ID danh mục là 1 --%>
            </div>
            <button type="submit" class="btn btn-primary">Thêm Sản phẩm</button>
            <a href="${pageContext.request.contextPath}/admin/products/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>