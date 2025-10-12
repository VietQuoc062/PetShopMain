<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Sửa Mặt hàng" pageHeader="Sửa Mặt hàng">
    <jsp:body>
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'invalid_input'}">
                    <div class="alert-error">Lỗi: Dữ liệu nhập vào không hợp lệ!</div>
                </c:when>
            </c:choose>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/items/update" method="post">
            <input type="hidden" name="id" value="<c:out value='${requestScope.item.itemID}'/>">
            <div class="form-group">
                <label for="name">Tên mặt hàng:</label>
                <input type="text" id="name" name="name" value="<c:out value='${requestScope.item.name}'/>" required>
            </div>
            <div class="form-group">
                <label for="price">Giá (VNĐ):</label>
                <input type="number" id="price" name="price" step="0.01" min="0" value="<c:out value='${requestScope.item.price}'/>" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">Hình ảnh:</label>
                <div style="margin-bottom: 10px;">
                    <c:if test="${not empty requestScope.item.imageUrl}">
                        <img id="currentImage" src="${pageContext.request.contextPath}${requestScope.item.imageUrl}" 
                             alt="Current image" style="max-width: 200px; max-height: 200px; border: 1px solid #ddd; border-radius: 8px;">
                    </c:if>
                </div>
                <select id="imageUrl" name="imageUrl" onchange="updateImagePreview()">
                    <option value="">-- Chọn hình ảnh --</option>
                    <option value="/images/dogfood1.jpg" ${requestScope.item.imageUrl == '/images/dogfood1.jpg' ? 'selected' : ''}>Thức ăn chó 1</option>
                    <option value="/images/dogfood2.jpg" ${requestScope.item.imageUrl == '/images/dogfood2.jpg' ? 'selected' : ''}>Thức ăn chó 2</option>
                    <option value="/images/catfood1.jpg" ${requestScope.item.imageUrl == '/images/catfood1.jpg' ? 'selected' : ''}>Thức ăn mèo 1</option>
                    <option value="/images/catfood2.jpg" ${requestScope.item.imageUrl == '/images/catfood2.jpg' ? 'selected' : ''}>Thức ăn mèo 2</option>
                    <option value="/images/fishfood1.jpg" ${requestScope.item.imageUrl == '/images/fishfood1.jpg' ? 'selected' : ''}>Thức ăn cá 1</option>
                    <option value="/images/fishfood2.jpg" ${requestScope.item.imageUrl == '/images/fishfood2.jpg' ? 'selected' : ''}>Thức ăn cá 2</option>
                    <option value="/images/birdfood1.jpg" ${requestScope.item.imageUrl == '/images/birdfood1.jpg' ? 'selected' : ''}>Thức ăn chim 1</option>
                    <option value="/images/birdfood2.jpg" ${requestScope.item.imageUrl == '/images/birdfood2.jpg' ? 'selected' : ''}>Thức ăn chim 2</option>
                    <option value="/images/rabbit1.jpg" ${requestScope.item.imageUrl == '/images/rabbit1.jpg' ? 'selected' : ''}>Thức ăn thỏ</option>
                    <option value="/images/dogleash1.jpg" ${requestScope.item.imageUrl == '/images/dogleash1.jpg' ? 'selected' : ''}>Dây dắt chó</option>
                    <option value="/images/dogcollar1.jpg" ${requestScope.item.imageUrl == '/images/dogcollar1.jpg' ? 'selected' : ''}>Vòng cổ chó</option>
                    <option value="/images/catlitter1.jpg" ${requestScope.item.imageUrl == '/images/catlitter1.jpg' ? 'selected' : ''}>Cát vệ sinh</option>
                    <option value="/images/cathouse1.jpg" ${requestScope.item.imageUrl == '/images/cathouse1.jpg' ? 'selected' : ''}>Nhà mèo</option>
                    <option value="/images/fishfilter1.jpg" ${requestScope.item.imageUrl == '/images/fishfilter1.jpg' ? 'selected' : ''}>Máy lọc nước</option>
                    <option value="/images/birdcage1.jpg" ${requestScope.item.imageUrl == '/images/birdcage1.jpg' ? 'selected' : ''}>Lồng chim</option>
                    <option value="/images/shampoo1.jpg" ${requestScope.item.imageUrl == '/images/shampoo1.jpg' ? 'selected' : ''}>Sữa tắm</option>
                    <option value="/images/vitamin1.jpg" ${requestScope.item.imageUrl == '/images/vitamin1.jpg' ? 'selected' : ''}>Vitamin</option>
                    <option value="/images/cage1.jpg" ${requestScope.item.imageUrl == '/images/cage1.jpg' ? 'selected' : ''}>Lồng sắt</option>
                    <option value="/images/toy1.jpg" ${requestScope.item.imageUrl == '/images/toy1.jpg' ? 'selected' : ''}>Đồ chơi</option>
                    <option value="/images/snack1.jpg" ${requestScope.item.imageUrl == '/images/snack1.jpg' ? 'selected' : ''}>Snack</option>
                    <option value="/images/brush1.jpg" ${requestScope.item.imageUrl == '/images/brush1.jpg' ? 'selected' : ''}>Lược chải</option>
                    <option value="/images/cleaner1.jpg" ${requestScope.item.imageUrl == '/images/cleaner1.jpg' ? 'selected' : ''}>Nước khử mùi</option>
                    <option value="/images/tray1.jpg" ${requestScope.item.imageUrl == '/images/tray1.jpg' ? 'selected' : ''}>Khay vệ sinh</option>
                    <option value="/images/clothes1.jpg" ${requestScope.item.imageUrl == '/images/clothes1.jpg' ? 'selected' : ''}>Quần áo</option>
                    <option value="/images/bed1.jpg" ${requestScope.item.imageUrl == '/images/bed1.jpg' ? 'selected' : ''}>Giường nệm</option>
                    <option value="/images/bag1.jpg" ${requestScope.item.imageUrl == '/images/bag1.jpg' ? 'selected' : ''}>Balo</option>
                </select>
            </div>
            <div class="form-group">
                <label for="status">Trạng thái:</label>
                <select id="status" name="status" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="Còn hàng" ${requestScope.item.status == 'Còn hàng' ? 'selected' : ''}>Còn hàng</option>
                    <option value="Hết hàng" ${requestScope.item.status == 'Hết hàng' ? 'selected' : ''}>Hết hàng</option>
                    <option value="Ngừng kinh doanh" ${requestScope.item.status == 'Ngừng kinh doanh' ? 'selected' : ''}>Ngừng kinh doanh</option>
                </select>
            </div>
            <div class="form-group">
                <label for="productID">Sản phẩm liên kết:</label>
                <select id="productID" name="productID">
                    <option value="">-- Chọn sản phẩm (tùy chọn) --</option>
                    <c:forEach var="product" items="${requestScope.listProducts}">
                        <option value="${product.productID}" ${product.productID == requestScope.item.productID ? 'selected' : ''}>
                            <c:out value="${product.category}" /> - <c:out value="${product.brand}" />
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" rows="4"><c:out value='${requestScope.item.description}'/></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật Mặt hàng</button>
            <a href="${pageContext.request.contextPath}/admin/items/list" class="btn">Hủy</a>
        </form>

        <script>
            function updateImagePreview() {
                const select = document.getElementById('imageUrl');
                const img = document.getElementById('currentImage');
                if (select.value && img) {
                    img.src = '${pageContext.request.contextPath}' + select.value;
                    img.style.display = 'block';
                } else if (img) {
                    img.style.display = select.value ? 'block' : 'none';
                }
            }
        </script>
    </jsp:body>
</t:admin_layout>
