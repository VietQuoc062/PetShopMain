<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Thêm Voucher Mới" pageHeader="Thêm Voucher Mới">
    <jsp:body>
        <form action="${pageContext.request.contextPath}/admin/vouchers/insert" method="post">
            <div class="form-group">
                <label for="code">Mã Voucher:</label>
                <input type="text" id="code" name="code" required>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description"></textarea>
            </div>
            <div class="form-group">
                <label for="discountAmount">Số tiền giảm giá:</label>
                <input type="number" id="discountAmount" name="discountAmount" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="minOrderValue">Giá trị đơn hàng tối thiểu:</label>
                <input type="number" id="minOrderValue" name="minOrderValue" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="startDate">Ngày bắt đầu:</label>
                <input type="datetime-local" id="startDate" name="startDate" required>
            </div>
            <div class="form-group">
                <label for="endDate">Ngày kết thúc:</label>
                <input type="datetime-local" id="endDate" name="endDate" required>
            </div>
            <div class="form-group">
                <label for="active">Trạng thái:</label>
                <select id="active" name="active" required>
                    <option value="true">Hoạt động</option>
                    <option value="false">Không hoạt động</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Thêm Voucher</button>
            <a href="${pageContext.request.contextPath}/admin/vouchers/list" class="btn">Hủy</a>
        </form>
    </jsp:body>
</t:admin_layout>