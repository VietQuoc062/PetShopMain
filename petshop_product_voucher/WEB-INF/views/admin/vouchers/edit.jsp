<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<t:admin_layout title="Sửa Voucher" pageHeader="Sửa Voucher">
    <jsp:body>
        <form action="${pageContext.request.contextPath}/admin/vouchers/update" method="post">
            <input type="hidden" name="id" value="<c:out value='${requestScope.voucher.id}'/>">
            <div class="form-group">
                <label for="code">Mã Voucher:</label>
                <input type="text" id="code" name="code" value="<c:out value='${requestScope.voucher.code}'/>" required>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description"><c:out value='${requestScope.voucher.description}'/></textarea>
            </div>
            <div class="form-group">
                <label for="discountAmount">Số tiền giảm giá:</label>
                <input type="number" id="discountAmount" name="discountAmount" step="0.01" min="0" value="<c:out value='${requestScope.voucher.discountAmount}'/>" required>
            </div>
            <div class="form-group">
                <label for="minOrderValue">Giá trị đơn hàng tối thiểu:</label>
                <input type="number" id="minOrderValue" name="minOrderValue" step="0.01" min="0" value="<c:out value='${requestScope.voucher.minOrderValue}'/>" required>
            </div>
            <div class="form-group">
                <label for="startDate">Ngày bắt đầu:</label>
                <input type="datetime-local" id="startDate" name="startDate"
                    value="${startDateFormatted}" required>
            </div>
            <div class="form-group">
                <label for="endDate">Ngày kết thúc:</label>
                <input type="datetime-local" id="endDate" name="endDate" value="${endDateFormatted}" required>
            </div>
            <div class="form-group">
                <label for="active">Trạng thái:</label>
                <select id="active" name="active" required>
                    <option value="true" ${requestScope.voucher.active ? 'selected' : ''}>Hoạt động</option>
                    <option value="false" ${!requestScope.voucher.active ? 'selected' : ''}>Không hoạt động</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật Voucher</button>
            <a href="${pageContext.request.contextPath}/admin/vouchers/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>