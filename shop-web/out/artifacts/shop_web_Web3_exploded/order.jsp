<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Danh sách đơn hàng</title></head>
<body>
<h2>Danh sách đơn hàng</h2>
<table border="1" cellpadding="5">
    <tr>
        <th>Mã đơn</th><th>Khách hàng</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Trạng thái</th>
    </tr>
    <c:forEach var="o" items="${orders}">
        <tr>
            <td>${o.maDH}</td>
            <td>${o.tenKH}</td>
            <td>${o.ngayDat}</td>
            <td>${o.tongTien}</td>
            <td>${o.trangThai}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
