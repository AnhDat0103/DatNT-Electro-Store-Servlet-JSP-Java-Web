<%-- 
    Document   : create
    Created on : Jan 1, 2025, 9:03:29 PM
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
        <title>${product.name} - Quản lý sản phẩm</title>
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
                    <div class="container-fluid px-4 mb-3">
                        <h1 class="mt-4">Quản lý sản phẩm</h1>
                        <div class="d-flex justify-content-between align-items-center">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active">Xem chi tiết sản phẩm</li>
                            </ol>
                            <a class="btn btn-primary" href="http://localhost:8080/electro-store/admin/quan-ly-hang-hoa" role="button">Quay lại</a>
                        </div>
                        <c:if test="${not empty product}">
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-7">
                                        <div class="card border-1 rounded-lg mt-5">
                                            <div class="card-body card-body-detail-product">
                                                <div class="container">
                                                    <div class="detail-header">
                                                        <div class="header-left">
                                                            <h5> <i class="fa-solid fa-circle-info"></i> Thông tin</h5>
                                                        </div>
                                                        <div class="header-right">
                                                            Trạng thái: 

                                                            <c:if test="${product.quantity > 0}">
                                                                <span class="status">
                                                                    <c:out value="Còn hàng"/>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${product.quantity <= 0}">
                                                                <span class="status bg-warning text-dark">
                                                                    <c:out value="Hết hàng"/>
                                                                </span>
                                                            </c:if>

                                                        </div>
                                                    </div>
                                                    <div class="detail-body">
                                                        <div class="d-flex row mb-3" >
                                                            <div class="col-6"><strong>ID:</strong> ${product.id} </div>
                                                            <div class="col-6"><strong>Loại mặt hàng:</strong> ${product.category.name} </div>
                                                        </div>
                                                        <div class="d-flex row mb-3" >
                                                            <div class="col-6"><strong>name:</strong> ${product.name} </div>
                                                            <div class="col-6"><strong>Nhãn hàng:</strong> ${product.brand.name} </div>
                                                        </div>
                                                        <div class="d-flex row mb-3" >
                                                            <div class="col-6"><strong>Giá tiền:</strong> <fmt:formatNumber type="number">${product.price}</fmt:formatNumber> đ </div>
                                                            <div class="col-6"><strong>Số lượng:</strong> ${product.quantity} </div>
                                                        </div>
                                                        <div class="col-12 mb-3">
                                                            <strong>Miêu tả chi tiết:</strong>
                                                            ${product.description}
                                                        </div>
                                                        <div class="col-12 mb-3 d-flex justify-content-center">
                                                            <img style="max-height: 250px;" src="../resources/admin/img/${product.image}" alt="alt"/>
                                                        </div>
                                                    </div>
                                                </div>  
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                Sản phẩm không tồn tại.
                            </div>
                        </c:if>
                    </div>
                </main>
                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/assets/demo/chart-area-demo.js"></script>
        <script src="../resources/admin/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/js/datatables-simple-demo.js"></script>
    </body>
</html>

