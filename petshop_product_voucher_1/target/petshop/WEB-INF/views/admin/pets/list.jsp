<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Quản lý Thú cưng" pageHeader="Danh sách Thú cưng">
  <jsp:body>
    <c:if test="${not empty param.message}">
      <c:choose>
        <c:when test="${param.message eq 'add_success'}">
          <div class="alert-success">Thêm thú cưng thành công!</div>
        </c:when>
        <c:when test="${param.message eq 'update_success'}">
          <div class="alert-success">Cập nhật thú cưng thành công!</div>
        </c:when>
        <c:when test="${param.message eq 'delete_success'}">
          <div class="alert-success">Xóa thú cưng thành công!</div>
        </c:when>
      </c:choose>
    </c:if>

    <p>
      <c:choose>
        <c:when test="${sessionScope.role == 'Owner'}">
          <a
            href="${pageContext.request.contextPath}/admin/pets/new"
            class="btn btn-primary"
            >Thêm Thú cưng Mới</a
          >
        </c:when>
        <c:otherwise>
          <button
            class="btn btn-primary"
            disabled
            style="opacity: 0.5; cursor: not-allowed"
          >
            Thêm Thú cưng Mới
          </button>
        </c:otherwise>
      </c:choose>
    </p>

    <table class="table-admin">
      <thead>
        <tr>
          <th>ID</th>
          <th>Loài</th>
          <th>Giống</th>
          <th>Tuổi</th>
          <th>Giới tính</th>
          <th>Hành động</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="pet" items="${requestScope.listPet}">
          <tr>
            <td><c:out value="${pet.petID}" /></td>
            <td><c:out value="${pet.species}" /></td>
            <td><c:out value="${pet.breed}" /></td>
            <td><c:out value="${pet.age}" /> tuổi</td>
            <td>
              <c:choose>
                <c:when test="${pet.gender eq 'Male'}">Đực</c:when>
                <c:when test="${pet.gender eq 'Female'}">Cái</c:when>
                <c:otherwise><c:out value="${pet.gender}" /></c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${sessionScope.role == 'Owner'}">
                  <a
                    href="${pageContext.request.contextPath}/admin/pets/edit?id=<c:out value='${pet.petID}'/>"
                    class="btn btn-warning"
                    >Sửa</a
                  >
                  <a
                    href="${pageContext.request.contextPath}/admin/pets/delete?id=<c:out value='${pet.petID}'/>"
                    class="btn btn-danger"
                    onclick="return confirm('Bạn có chắc muốn xóa thú cưng này không?');"
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
          <c:if test="${page > 1}">
            <a href="?page=${page-1}" class="btn btn-secondary">« Trước</a>
          </c:if>

          <c:set var="startPage" value="${page - 2 < 1 ? 1 : page - 2}" />
          <c:set
            var="endPage"
            value="${startPage + 4 > totalPages ? totalPages : startPage + 4}"
          />
          <c:set var="startPage" value="${endPage - 4 < 1 ? 1 : endPage - 4}" />

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
