<%-- admin/products/add.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Thêm Sản phẩm Mới" pageHeader="Thêm Sản phẩm Mới">
    <jsp:body>
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'category_required'}">
                    <div class="alert-error">Lỗi: Loại sản phẩm là bắt buộc!</div>
                </c:when>
                <c:when test="${param.error eq 'invalid_input'}">
                    <div class="alert-error">Lỗi: Dữ liệu nhập vào không hợp lệ!</div>
                </c:when>
            </c:choose>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/products/insert" method="post">
            <div class="form-group">
                <label for="category">Loại sản phẩm:</label>
                <input type="text" id="category" name="category" required>
            </div>
            <div class="form-group">
                <label for="brand">Thương hiệu:</label>
                <input type="text" id="brand" name="brand">
            </div>
            <div class="form-group">
                <label for="productCategoryID">Danh mục sản phẩm:</label>
                <select id="productCategoryID" name="productCategoryID" size="1" style="max-height: 200px; overflow-y: auto;" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="category" items="${requestScope.listCategories}">
                        <option value="${category.productCategoryID}">
                            <c:out value="${category.name}" />
                        </option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Thêm Sản phẩm</button>
            <a href="${pageContext.request.contextPath}/admin/products/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>