<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Quản lý Mặt hàng" pageHeader="Danh sách Mặt hàng">
    <jsp:body>
        <c:if test="${not empty param.message}">
            <c:choose>
                <c:when test="${param.message eq 'add_success'}">
                    <div class="alert-success">Thêm mặt hàng thành công!</div>
                </c:when>
                <c:when test="${param.message eq 'update_success'}">
                    <div class="alert-success">Cập nhật mặt hàng thành công!</div>
                </c:when>
                <c:when test="${param.message eq 'delete_success'}">
                    <div class="alert-success">Xóa mặt hàng thành công!</div>
                </c:when>
            </c:choose>
        </c:if>

        <p>
            <c:choose>
                <c:when test="${sessionScope.role == 'Owner'}">
                    <a href="${pageContext.request.contextPath}/admin/items/new" class="btn btn-primary">Thêm Mặt hàng Mới</a>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-primary" disabled style="opacity: 0.5; cursor: not-allowed;">Thêm Mặt hàng Mới</button>
                </c:otherwise>
            </c:choose>
        </p>

        <table class="table-admin">
            <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên mặt hàng</th>
                    <th>Giá</th>
                    <th>Trạng thái</th>
                    <th>Sản phẩm</th>
                    <th>Mô tả</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${requestScope.listItem}">
                    <tr>
                        <td style="text-align: center; padding: 10px;">
                            <c:choose>
                                <c:when test="${not empty item.imageUrl}">
                                    <img src="${pageContext.request.contextPath}${item.imageUrl}" 
                                         alt="<c:out value='${item.name}'/>"
                                         style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px; border: 1px solid #ddd;"
                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #4ecdc4, #44a08d); border-radius: 8px; display: none; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                        <i class="fas fa-image"></i>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #6c757d, #545b62); border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                        <i class="fas fa-box"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><strong><c:out value="${item.name}" /></strong></td>
                        <td style="color: #e74c3c; font-weight: bold;"><c:out value="${item.price}" /> VNĐ</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.status eq 'Còn hàng'}">
                                    <span style="background: #d4edda; color: #155724; padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold;">Còn hàng</span>
                                </c:when>
                                <c:when test="${item.status eq 'Hết hàng'}">
                                    <span style="background: #f8d7da; color: #721c24; padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold;">Hết hàng</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="background: #fff3cd; color: #856404; padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold;"><c:out value="${item.status}" /></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.product != null}">
                                    <small><c:out value="${item.product.category}" /></small><br>
                                    <small style="color: #6c757d;"><c:out value="${item.product.brand}" /></small>
                                </c:when>
                                <c:otherwise>
                                    <small style="color: #6c757d;">Chưa phân loại</small>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td style="max-width: 200px;">
                            <c:choose>
                                <c:when test="${item.description.length() > 60}">
                                    <small><c:out value="${item.description.substring(0, 60)}" />...</small>
                                </c:when>
                                <c:otherwise>
                                    <small><c:out value="${item.description}" /></small>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${sessionScope.role == 'Owner'}">
                                    <a href="${pageContext.request.contextPath}/admin/items/edit?id=<c:out value='${item.itemID}'/>" 
                                       class="btn btn-warning" style="margin-right: 5px;">Sửa</a>
                                    <a href="${pageContext.request.contextPath}/admin/items/delete?id=<c:out value='${item.itemID}'/>" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa mặt hàng này không?');">Xóa</a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-warning" disabled style="opacity: 0.5; cursor: not-allowed; margin-right: 5px;">Sửa</button>
                                    <button class="btn btn-danger" disabled style="opacity: 0.5; cursor: not-allowed;">Xóa</button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination-container" style="margin-top: 30px; text-align: center;">
            <div class="pagination-info" style="margin-bottom: 15px;">
                Hiển thị ${(page-1)*10+1} - ${page*10 > totalItems ? totalItems : page*10} của ${totalItems} kết quả
            </div>
            
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${page > 1}">
                        <a href="?page=${page-1}" class="btn btn-secondary">« Trước</a>
                    </c:if>
                    
                    <c:set var="startPage" value="${page - 2 < 1 ? 1 : page - 2}"/>
                    <c:set var="endPage" value="${startPage + 4 > totalPages ? totalPages : startPage + 4}"/>
                    <c:set var="startPage" value="${endPage - 4 < 1 ? 1 : endPage - 4}"/>
                    
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:choose>
                            <c:when test="${i == page}">
                                <span class="btn btn-primary" style="background-color: #007bff; color: white;">${i}</span>
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
    </jsp:body>
</t:admin_layout>
