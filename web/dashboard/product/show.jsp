<%-- 
    Document   : dashboard
    Created on : Dec 25, 2024, 7:56:01 PM
    Author     : DAT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Quản lý sản phẩm</title>
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
                        <h1 class="mt-4">Quản lý sản phẩm</h1>
                        <div class="d-flex justify-content-between align-items-center">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active">Danh sách sản phẩm</li>
                            </ol>
                            <a class="btn btn-primary" href="http://localhost:8080/electro-store/admin/tao-moi-san-pham" role="button">Tạo sản phẩm mới</a>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Dữ liệu sản phẩm
                            </div>
                            <div class="card-body">
                                <table  class="table table-bordered">
                                    <thead>
                                        <tr>    
                                            <th>ID</th>
                                            <th>Ảnh</th>
                                            <th>Tên</th>
                                            <th>Số lượng</th>
                                            <th>Giá</th>
                                            <th>Cài đặt</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${products}" var="p">
                                            <tr>
                                                <td >${p.id}</td>
                                                <td ><img class="img-fluid" style="width:200px;" src="../resources/admin/img/${p.image}" alt="ảnh"/></td>
                                                <td >${p.name}</td>
                                                <td >${p.quantity}</td>
                                                <td ><fmt:formatNumber type="number">${p.price}</fmt:formatNumber> đ</td>
                                                    <td>
                                                        <a href="/electro-store/admin/chi-tiet-san-pham?ma-san-pham=${p.id}" class="btn btn-info">Xem chi tiết</a>
                                                    <a href="/electro-store/admin/cap-nhat-thong-tin-san-pham?ma-san-pham=${p.id}" class="btn btn-warning">Cập nhật</a>
                                                    <a href="/electro-store/admin/xac-nhan-xoa-san-pham?ma-san-pham=${p.id}" class="btn btn-danger">Xóa sản phẩm</a>
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
                                        <a class="page-link" href="/electro-store/admin/quan-ly-hang-hoa?trang-so=${requestScope.currentPage - 1}">Trước</a>
                                    </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${requestScope.totalPages}" var="i">
                                        <li class="page-item"><a class="page-link ${currentPage eq i ? 'active': ''}" href="/electro-store/admin/quan-ly-hang-hoa?trang-so=${i}">${i}</a></li>
                                        </c:forEach>
                                        <c:if test="${currentPage lt totalPages}">
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="/electro-store/admin/quan-ly-hang-hoa?trang-so=${requestScope.currentPage + 1}">Sau</a>
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

