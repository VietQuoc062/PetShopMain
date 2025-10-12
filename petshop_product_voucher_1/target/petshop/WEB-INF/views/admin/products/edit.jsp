<%-- admin/products/edit.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Sửa Sản phẩm" pageHeader="Sửa Sản phẩm">
    <jsp:body>
        <form action="${pageContext.request.contextPath}/admin/products/update" method="post">
            <input type="hidden" name="id" value="<c:out value='${requestScope.product.productID}'/>">
            <div class="form-group">
                <label for="category">Loại sản phẩm:</label>
                <input type="text" id="category" name="category" 
                       value="<c:out value='${requestScope.product.category}'/>" required>
            </div>
            <div class="form-group">
                <label for="brand">Thương hiệu:</label>
                <input type="text" id="brand" name="brand" 
                       value="<c:out value='${requestScope.product.brand}'/>">
            </div>
            <div class="form-group">
                <label for="productCategoryID">Danh mục sản phẩm:</label>
                <select id="productCategoryID" name="productCategoryID" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="category" items="${requestScope.listCategories}">
                        <option value="${category.productCategoryID}" 
                                ${category.productCategoryID == requestScope.product.productCategoryID ? 'selected' : ''}>
                            <c:out value="${category.name}" />
                        </option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật Sản phẩm</button>
            <a href="${pageContext.request.contextPath}/admin/products/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>
