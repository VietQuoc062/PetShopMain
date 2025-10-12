<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Sửa Khuyến Mãi" pageHeader="Sửa Khuyến Mãi">
    <jsp:body>
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'invalid_date_range'}">
                    <div class="alert-error">Lỗi: Ngày bắt đầu phải nhỏ hơn ngày kết thúc!</div>
                </c:when>
            </c:choose>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/vouchers/update" method="post" onsubmit="return validateDates()">
            <input type="hidden" name="id" value="<c:out value='${requestScope.voucher.promotionID}'/>">
            <div class="form-group">
                <label for="name">Tên khuyến mãi:</label>
                <input type="text" id="name" name="name" value="<c:out value='${requestScope.voucher.name}'/>" required>
            </div>
            <div class="form-group">
                <label for="code">Mã khuyến mãi:</label>
                <input type="text" id="code" name="code" value="<c:out value='${requestScope.voucher.code}'/>" required>
            </div>
            <div class="form-group">
                <label for="discountPercent">Phần trăm giảm giá (%):</label>
                <input type="number" id="discountPercent" name="discountPercent" step="0.01" min="0" max="100" value="<c:out value='${requestScope.voucher.discountPercent}'/>" required>
            </div>
            <div class="form-group">
                <label for="startDate">Ngày bắt đầu:</label>
                <input type="date" id="startDate" name="startDate" value="${startDateFormatted}" required onchange="validateDateRange()">
            </div>
            <div class="form-group">
                <label for="endDate">Ngày kết thúc:</label>
                <input type="date" id="endDate" name="endDate" value="${endDateFormatted}" required onchange="validateDateRange()">
            </div>
            <div id="dateError" class="alert-error" style="display: none;">
                Ngày bắt đầu phải nhỏ hơn ngày kết thúc!
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật Khuyến Mãi</button>
            <a href="${pageContext.request.contextPath}/admin/vouchers/list" class="btn">Hủy</a>
        </form>

        <script>
            function validateDateRange() {
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;
                const errorDiv = document.getElementById('dateError');
                
                if (startDate && endDate && startDate >= endDate) {
                    errorDiv.style.display = 'block';
                    return false;
                } else {
                    errorDiv.style.display = 'none';
                    return true;
                }
            }

            function validateDates() {
                return validateDateRange();
            }
        </script>
    </jsp:body>
</t:admin_layout>