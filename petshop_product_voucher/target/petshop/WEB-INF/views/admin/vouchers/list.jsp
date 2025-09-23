<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Quản lý Voucher" pageHeader="Danh sách Voucher">
  <jsp:body>
    <c:if test="${not empty param.message}">
      <c:choose>
        <c:when test="${param.message eq 'add_success'}"
          ><div class="alert-success">Thêm voucher thành công!</div></c:when
        >
        <c:when test="${param.message eq 'update_success'}"
          ><div class="alert-success">Cập nhật voucher thành công!</div></c:when
        >
        <c:when test="${param.message eq 'delete_success'}"
          ><div class="alert-success">Xóa voucher thành công!</div></c:when
        >
      </c:choose>
    </c:if>

    <p>
      <a
        href="${pageContext.request.contextPath}/admin/vouchers/new"
        class="btn btn-primary"
        >Thêm Voucher Mới</a
      >
    </p>

    <table class="table-admin">
      <thead>
        <tr>
          <th>ID</th>
          <th>Mã Voucher</th>
          <th>Mô tả</th>
          <th>Giảm giá</th>
          <th>Đơn tối thiểu</th>
          <th>Ngày bắt đầu</th>
          <th>Ngày kết thúc</th>
          <th>Trạng thái</th>
          <th>Hành động</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="voucher" items="${requestScope.listVoucher}">
          <tr>
            <td><c:out value="${voucher.id}" /></td>
            <td><c:out value="${voucher.code}" /></td>
            <td><c:out value="${voucher.description}" /></td>
            <td><c:out value="${voucher.discountAmount}" /> VNĐ</td>
            <td><c:out value="${voucher.minOrderValue}" /> VNĐ</td>
            <td><c:out value="${voucher.startDate}" /></td>
            <td><c:out value="${voucher.endDate}" /></td>
            <td>
              <c:out
                value="${voucher.active ? 'Hoạt động' : 'Không hoạt động'}"
              />
            </td>
            <td>
              <a
                href="${pageContext.request.contextPath}/admin/vouchers/edit?id=<c:out value='${voucher.id}'/>"
                class="btn btn-warning"
                >Sửa</a
              >
              <a
                href="${pageContext.request.contextPath}/admin/vouchers/delete?id=<c:out value='${voucher.id}'/>"
                class="btn btn-danger"
                onclick="return confirm('Bạn có chắc muốn xóa voucher này không?');"
                >Xóa</a
              >
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </jsp:body>
</t:admin_layout>
