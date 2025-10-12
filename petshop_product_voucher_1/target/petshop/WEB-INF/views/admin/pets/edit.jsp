<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Sửa Thú cưng" pageHeader="Sửa Thú cưng">
    <jsp:body>
        <c:if test="${not empty param.error}">
            <c:when test="${param.error eq 'invalid_input'}">
                <div class="alert-error">Lỗi: Dữ liệu nhập vào không hợp lệ!</div>
            </c:when>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/pets/update" method="post">
            <input type="hidden" name="id" value="<c:out value='${requestScope.pet.petID}'/>">
            <div class="form-group">
                <label for="species">Loài:</label>
                <select id="species" name="species" required>
                    <option value="">-- Chọn loài --</option>
                    <option value="Chó" ${requestScope.pet.species == 'Chó' ? 'selected' : ''}>Chó</option>
                    <option value="Mèo" ${requestScope.pet.species == 'Mèo' ? 'selected' : ''}>Mèo</option>
                    <option value="Chim" ${requestScope.pet.species == 'Chim' ? 'selected' : ''}>Chim</option>
                    <option value="Cá" ${requestScope.pet.species == 'Cá' ? 'selected' : ''}>Cá</option>
                    <option value="Thỏ" ${requestScope.pet.species == 'Thỏ' ? 'selected' : ''}>Thỏ</option>
                </select>
            </div>
            <div class="form-group">
                <label for="breed">Giống:</label>
                <input type="text" id="breed" name="breed" value="<c:out value='${requestScope.pet.breed}'/>" required>
            </div>
            <div class="form-group">
                <label for="age">Tuổi:</label>
                <input type="number" id="age" name="age" min="0" max="30" value="<c:out value='${requestScope.pet.age}'/>" required>
            </div>
            <div class="form-group">
                <label for="gender">Giới tính:</label>
                <select id="gender" name="gender" required>
                    <option value="">-- Chọn giới tính --</option>
                    <option value="Male" ${requestScope.pet.gender == 'Male' ? 'selected' : ''}>Đực</option>
                    <option value="Female" ${requestScope.pet.gender == 'Female' ? 'selected' : ''}>Cái</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật Thú cưng</button>
            <a href="${pageContext.request.contextPath}/admin/pets/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>
