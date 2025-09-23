<%-- admin/products/edit.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Sửa Sản phẩm" pageHeader="Sửa Sản phẩm">
    <jsp:body>
        <form action="${pageContext.request.contextPath}/admin/products/update" method="post">
            <input type="hidden" name="id" value="<c:out value='${requestScope.product.id}'/>">
            <div class="form-group">
                <label for="name">Tên Sản phẩm:</label>
                <input type="text" id="name" name="name" value="<c:out value='${requestScope.product.name}'/>" required>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description"><c:out value='${requestScope.product.description}'/></textarea>
            </div>
            <div class="form-group">
                <label for="price">Giá:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" value="<c:out value='${requestScope.product.price}'/>" required>
            </div>
            <div class="form-group">
                <label for="stockQuantity">Số lượng tồn:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" min="0" value="<c:out value='${requestScope.product.stockQuantity}'/>" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">URL Ảnh:</label>
                <input type="url" id="imageUrl" name="imageUrl" value="<c:out value='${requestScope.product.imageUrl}'/>">
            </div>
            <div class="form-group">
                <label for="categoryId">ID Danh mục:</label>
                <input type="number" id="categoryId" name="categoryId" min="1" value="<c:out value='${requestScope.product.categoryId}'/>" required>
            </div>
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/admin/products/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>
