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
      <c:choose>
        <c:when test="${sessionScope.role == 'Owner'}">
          <a
            href="${pageContext.request.contextPath}/admin/vouchers/new"
            class="btn btn-primary"
            >Thêm Voucher Mới</a
          >
        </c:when>
        <c:otherwise>
          <button
            class="btn btn-primary"
            disabled
            style="opacity: 0.5; cursor: not-allowed"
          >
            Thêm Voucher Mới
          </button>
        </c:otherwise>
      </c:choose>
    </p>

    <table class="table-admin">
      <thead>
        <tr>
          <th>ID</th>
          <th>Tên khuyến mãi</th>
          <th>Mã khuyến mãi</th>
          <th>Giảm giá (%)</th>
          <th>Ngày bắt đầu</th>
          <th>Ngày kết thúc</th>
          <th>Thuộc danh mục</th>
          <th>Hành động</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="voucher" items="${requestScope.listVoucher}">
          <tr>
            <td><c:out value="${voucher.promotionID}" /></td>
            <td><c:out value="${voucher.name}" /></td>
            <td><c:out value="${voucher.code}" /></td>
            <td><c:out value="${voucher.discountPercent}" />%</td>
            <td><c:out value="${voucher.startDate}" /></td>
            <td><c:out value="${voucher.endDate}" /></td>
            <td>
              <c:choose>
                <c:when test="${voucher.productCategory != null}">
                  <c:out value="${voucher.productCategory.name}" />
                </c:when>
                <c:otherwise> Chưa phân loại </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${sessionScope.role == 'Owner'}">
                  <a
                    href="${pageContext.request.contextPath}/admin/vouchers/edit?id=<c:out value='${voucher.promotionID}'/>"
                    class="btn btn-warning"
                    >Sửa</a
                  >
                  <a
                    href="${pageContext.request.contextPath}/admin/vouchers/delete?id=<c:out value='${voucher.promotionID}'/>"
                    class="btn btn-danger"
                    onclick="return confirm('Bạn có chắc muốn xóa khuyến mãi này không?');"
                    >Xóa</a
                  >
                </c:when>
                <c:otherwise>
                  <button
                    class="btn btn-warning"
                    disabled
                    style="opacity: 0.5; cursor: not-allowed"
                  >
                    Sửa
                  </button>
                  <button
                    class="btn btn-danger"
                    disabled
                    style="opacity: 0.5; cursor: not-allowed"
                  >
                    Xóa
                  </button>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- Pagination -->
    <div
      class="pagination-container"
      style="margin-top: 20px; text-align: center"
    >
      <div class="pagination-info" style="margin-bottom: 10px">
        Hiển thị ${(page-1)*10+1} - ${page*10 > totalItems ? totalItems :
        page*10} của ${totalItems} kết quả
      </div>

      <c:if test="${totalPages > 1}">
        <div class="pagination">
          <!-- Previous button -->
          <c:if test="${page > 1}">
            <a href="?page=${page-1}" class="btn btn-secondary">« Trước</a>
          </c:if>

          <!-- Page numbers -->
          <c:set var="startPage" value="${page - 2 < 1 ? 1 : page - 2}" />
          <c:set
            var="endPage"
            value="${startPage + 4 > totalPages ? totalPages : startPage + 4}"
          />
          <c:set var="startPage" value="${endPage - 4 < 1 ? 1 : endPage - 4}" />

          <c:if test="${startPage > 1}">
            <a href="?page=1" class="btn btn-secondary">1</a>
            <c:if test="${startPage > 2}">
              <span>...</span>
            </c:if>
          </c:if>

          <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
              <c:when test="${i == page}">
                <span
                  class="btn btn-primary"
                  style="background-color: #007bff; color: white"
                  >${i}</span
                >
              </c:when>
              <c:otherwise>
                <a href="?page=${i}" class="btn btn-secondary">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>

          <c:if test="${endPage < totalPages}">
            <c:if test="${endPage < totalPages - 1}">
              <span>...</span>
            </c:if>
            <a href="?page=${totalPages}" class="btn btn-secondary"
              >${totalPages}</a
            >
          </c:if>

          <!-- Next button -->
          <c:if test="${page < totalPages}">
            <a href="?page=${page+1}" class="btn btn-secondary">Tiếp »</a>
          </c:if>
        </div>
      </c:if>
    </div>

    <style>
      .pagination-container {
        margin-top: 20px;
      }
      .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 5px;
      }
      .pagination .btn {
        padding: 8px 12px;
        text-decoration: none;
        border: 1px solid #ddd;
        color: #333;
        display: inline-block;
      }
      .pagination .btn:hover {
        background-color: #f5f5f5;
      }
      .pagination span {
        padding: 8px 12px;
      }
    </style>
  </jsp:body>
</t:admin_layout>
