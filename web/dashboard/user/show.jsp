<%-- 
    Document   : show
    Created on : Jan 11, 2025, 10:59:23 PM
    Author     : DAT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Quản lý người dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <%@include file="../layout/header.jsp" %>
        <div id="layoutSidenav">
            <%@include file="../layout/navigation.jsp" %>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Quản lý người dùng</h1>
                        <div class="d-flex justify-content-between align-items-center">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active">Danh sách khách hàng</li>
                            </ol>
                            <a class="btn btn-primary" href="http://localhost:8080/electro-store/admin/tao-moi-khach-hang" role="button">Tạo khách hàng mới</a>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Dữ liệu người dùng
                            </div>
                            <div class="card-body">
                                <table  class="table table-bordered">
                                    <thead>
                                        <tr>    
                                            <th>ID</th>
                                            <th>Họ và tên</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>địa chỉ</th>
                                            <th>Cài đặt</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${users}" var="u">
                                            <tr>
                                                <td >${u.userId}</td>
                                                <td >${u.fullName}</td>
                                                <td >${u.email}</td>
                                                <td >${u.telephone}</td>
                                                <td >${u.address}</td>
                                                <td>
                                                    <a href="/electro-store/admin/cap-nhat-thong-tin-khach-hang?ma-khach-hang=${u.userId}" class="btn btn-warning">Cập nhật</a>
                                                    <a href="/electro-store/admin/xac-nhan-xoa-khach-hang?ma-khach-hang=${u.userId}" class="btn btn-danger">Xóa khách hàng</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <nav aria-label="...">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${currentPage != 1}">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/electro-store/admin/quan-ly-khach-hang?trang-so=${requestScope.currentPage - 1}">Trước</a>
                                    </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.totalPages}" var="i">
                                        <li class="page-item"><a class="page-link ${currentPage eq i ? 'active': ''}" href="/electro-store/admin/quan-ly-khach-hang?trang-so=${i}">${i}</a></li>
                                        </c:forEach>
                                        <c:if test="${currentPage lt totalPages}">
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="/electro-store/admin/quan-ly-khach-hang?trang-so=${requestScope.currentPage + 1}">Sau</a>
                                        </li>
                                    </c:if>

                                </ul>
                            </nav>
                        </div>
                    </div>
                </main>
                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/js/scripts.js"></script>
    </body>
</html>

