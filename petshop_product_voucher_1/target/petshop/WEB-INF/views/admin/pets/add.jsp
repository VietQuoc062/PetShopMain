<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Thêm Thú cưng Mới" pageHeader="Thêm Thú cưng Mới">
    <jsp:body>
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'invalid_input'}">
                    <div class="alert-error">Lỗi: Dữ liệu nhập vào không hợp lệ!</div>
                </c:when>
            </c:choose>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/pets/insert" method="post">
            <div class="form-group">
                <label for="species">Loài:</label>
                <select id="species" name="species" required>
                    <option value="">-- Chọn loài --</option>
                    <option value="Chó">Chó</option>
                    <option value="Mèo">Mèo</option>
                    <option value="Chim">Chim</option>
                    <option value="Cá">Cá</option>
                    <option value="Thỏ">Thỏ</option>
                </select>
            </div>
            <div class="form-group">
                <label for="breed">Giống:</label>
                <input type="text" id="breed" name="breed" required>
            </div>
            <div class="form-group">
                <label for="age">Tuổi:</label>
                <input type="number" id="age" name="age" min="0" max="30" required>
            </div>
            <div class="form-group">
                <label for="gender">Giới tính:</label>
                <select id="gender" name="gender" required>
                    <option value="">-- Chọn giới tính --</option>
                    <option value="Male">Đực</option>
                    <option value="Female">Cái</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Thêm Thú cưng</button>
            <a href="${pageContext.request.contextPath}/admin/pets/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>
