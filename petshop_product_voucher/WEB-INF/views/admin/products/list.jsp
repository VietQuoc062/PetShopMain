<%-- admin/products/list.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Quản lý Sản phẩm" pageHeader="Danh sách Sản phẩm">
    <jsp:body>
        <c:if test="${not empty param.message}">
            <c:choose>
                <c:when test="${param.message eq 'add_success'}"><div class="alert-success">Thêm sản phẩm thành công!</div></c:when>
                <c:when test="${param.message eq 'update_success'}"><div class="alert-success">Cập nhật sản phẩm thành công!</div></c:when>
                <c:when test="${param.message eq 'delete_success'}"><div class="alert-success">Xóa sản phẩm thành công!</div></c:when>
            </c:choose>
        </c:if>

        <p><a href="${pageContext.request.contextPath}/admin/products/new" class="btn btn-primary">Thêm Sản phẩm Mới</a></p>

        <table class="table-admin">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng tồn</th>
                    <th>Ảnh</th>
                    <th>Danh mục</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${requestScope.listProduct}">
                    <tr>
                        <td><c:out value="${product.id}"/></td>
                        <td><c:out value="${product.name}"/></td>
                        <td><c:out value="${product.price}"/> VNĐ</td>
                        <td><c:out value="${product.stockQuantity}"/></td>
                        <td>
                            <c:if test="${not empty product.imageUrl}">
                                <img src="${product.imageUrl}" alt="${product.name}" style="width: 50px; height: 50px; object-fit: cover;">
                            </c:if>
                        </td>
                        <td><c:out value="${product.categoryId}"/></td> <%-- Hiển thị tên danh mục sau --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/products/edit?id=<c:out value='${product.id}'/>" class="btn btn-warning">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/products/delete?id=<c:out value='${product.id}'/>" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </jsp:body>
</t:admin_layout>