<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:admin_layout title="Thêm Mặt hàng Mới" pageHeader="Thêm Mặt hàng Mới">
    <jsp:body>
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'invalid_input'}">
                    <div class="alert-error">Lỗi: Dữ liệu nhập vào không hợp lệ!</div>
                </c:when>
            </c:choose>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/items/insert" method="post">
            <div class="form-group">
                <label for="name">Tên mặt hàng:</label>
                <input type="text" id="name" name="name" required 
                       placeholder="VD: Hạt Pedigree vị bò 1.5kg">
            </div>
            <div class="form-group">
                <label for="price">Giá (VNĐ):</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">Hình ảnh:</label>
                <div style="margin-bottom: 10px;">
                    <img id="imagePreview" src="" alt="Preview" 
                         style="max-width: 200px; max-height: 200px; border: 1px solid #ddd; border-radius: 8px; display: none;"
                         onerror="this.style.display='none'; document.getElementById('imageError').style.display='block';">
                    <div id="imageError" style="display: none; padding: 20px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 8px; text-align: center; color: #6c757d;">
                        <i class="fas fa-exclamation-triangle"></i><br>
                        <small>Hình ảnh không tìm thấy<br>Vui lòng đảm bảo file ảnh tồn tại trong thư mục /images</small>
                    </div>
                </div>
                <select id="imageUrl" name="imageUrl" onchange="updateImagePreview()">
                    <option value="">-- Chọn hình ảnh --</option>
                    <option value="/images/dogfood1.jpg">Thức ăn chó 1</option>
                    <option value="/images/dogfood2.jpg">Thức ăn chó 2</option>
                    <option value="/images/catfood1.jpg">Thức ăn mèo 1</option>
                    <option value="/images/catfood2.jpg">Thức ăn mèo 2</option>
                    <option value="/images/fishfood1.jpg">Thức ăn cá 1</option>
                    <option value="/images/fishfood2.jpg">Thức ăn cá 2</option>
                    <option value="/images/birdfood1.jpg">Thức ăn chim 1</option>
                    <option value="/images/birdfood2.jpg">Thức ăn chim 2</option>
                    <option value="/images/rabbit1.jpg">Thức ăn thỏ</option>
                    <option value="/images/dogleash1.jpg">Dây dắt chó</option>
                    <option value="/images/dogcollar1.jpg">Vòng cổ chó</option>
                    <option value="/images/catlitter1.jpg">Cát vệ sinh</option>
                    <option value="/images/cathouse1.jpg">Nhà mèo</option>
                    <option value="/images/fishfilter1.jpg">Máy lọc nước</option>
                    <option value="/images/birdcage1.jpg">Lồng chim</option>
                    <option value="/images/shampoo1.jpg">Sữa tắm</option>
                    <option value="/images/vitamin1.jpg">Vitamin</option>
                    <option value="/images/cage1.jpg">Lồng sắt</option>
                    <option value="/images/toy1.jpg">Đồ chơi</option>
                    <option value="/images/snack1.jpg">Snack</option>
                    <option value="/images/brush1.jpg">Lược chải</option>
                    <option value="/images/cleaner1.jpg">Nước khử mùi</option>
                    <option value="/images/tray1.jpg">Khay vệ sinh</option>
                    <option value="/images/clothes1.jpg">Quần áo</option>
                    <option value="/images/bed1.jpg">Giường nệm</option>
                    <option value="/images/bag1.jpg">Balo</option>
                </select>
                <small style="color: #6c757d; display: block; margin-top: 5px;">
                    <i class="fas fa-info-circle"></i> 
                    Lưu ý: Cần đặt file ảnh vào thư mục <code>/src/main/webapp/images/</code>
                </small>
            </div>
            <div class="form-group">
                <label for="status">Trạng thái:</label>
                <select id="status" name="status" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="Còn hàng">Còn hàng</option>
                    <option value="Hết hàng">Hết hàng</option>
                    <option value="Ngừng kinh doanh">Ngừng kinh doanh</option>
                </select>
            </div>
            <div class="form-group">
                <label for="productID">Sản phẩm liên kết:</label>
                <select id="productID" name="productID">
                    <option value="">-- Chọn sản phẩm (tùy chọn) --</option>
                    <c:forEach var="product" items="${requestScope.listProducts}">
                        <option value="${product.productID}">
                            <c:out value="${product.category}" /> - <c:out value="${product.brand}" />
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" rows="4" 
                          placeholder="Mô tả chi tiết về mặt hàng..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Thêm Mặt hàng</button>
            <a href="${pageContext.request.contextPath}/admin/items/list" class="btn">Hủy</a>
        </form>

        <script>
            function updateImagePreview() {
                const select = document.getElementById('imageUrl');
                const img = document.getElementById('imagePreview');
                const errorDiv = document.getElementById('imageError');
                
                if (select.value) {
                    img.src = '${pageContext.request.contextPath}' + select.value;
                    img.style.display = 'block';
                    errorDiv.style.display = 'none';
                } else {
                    img.style.display = 'none';
                    errorDiv.style.display = 'none';
                }
            }
        </script>
    </jsp:body>
</t:admin_layout>