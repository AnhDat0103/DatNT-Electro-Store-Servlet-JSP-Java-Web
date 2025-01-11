<%-- 
    Document   : update
    Created on : Jan 12, 2025, 2:23:12 AM
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
        <title>${u.fullName} - Quản lý người dùng</title>
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
                                <li class="breadcrumb-item active">Cập nhật người dùng</li>
                            </ol>
                            <a class="btn btn-primary" href="http://localhost:8080/electro-store/admin/quan-ly-khach-hang" role="button">Quay lại</a>
                        </div>
                        <!--tao moi form-->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        <c:if test="${not empty u}">
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-7">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5 mb-5">
                                            <div class="card-body">
                                                <form action="/electro-store/admin/cap-nhat-thong-tin-khach-hang" method="POST">
                                                    <div>
                                                        <input type="hidden" name="id" value="${requestScope.u.userId}">
                                                    </div>
                                                    <div class="row mb-3">

                                                        <div class="col-md-6">
                                                            <div class="form-floating">
                                                                <input class="form-control ${not empty errorFullName ? 'is-invalid' : ''}" id="inputFullName" type="text"  name="fullName" value="${requestScope.u.fullName}" />
                                                                <label for="inputFullName">Họ và tên</label>
                                                                <c:if test="${not empty errorFullName}">
                                                                    <div class="invalid-feedback">
                                                                        <c:out value="${errorFullName}" />
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <input class="form-control ${not empty errorTel ? 'is-invalid' : ''} ${not empty errorTelFormat ? 'is-invalid' : ''}" id="inputForTelephone" type="text" placeholder="Nhập họ số điện thoại của bạn" name="telephone" value="${requestScope.u.telephone}"/>
                                                                <label for="inputFirstName">Điện thoại</label>
                                                                <c:if test="${not empty errorTel}">
                                                                    <div class="invalid-feedback">
                                                                        <c:out value="${errorTel}" />
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${not empty errorTelFormat}">
                                                                    <div class="invalid-feedback">
                                                                        <c:out value="${errorTelFormat}" />
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3 row">
                                                        <div class="col-md-12">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <input class="form-control ${not empty errorEmailFormat ? 'is-invalid' : ''} ${not empty errorEmailExist ? 'is-invalid' : ''}" id="inputEmail" type="email" placeholder="name@gmail.com"  name="email" value="${requestScope.u.email}" disabled="" />
                                                                <label for="inputEmail">Địa chỉ email</label>
                                                        
                                                            </div>
                                                        </div>


                                                    </div>

                                                    <div class="mb-3">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control  ${not empty errorAddress ? 'is-invalid' : ''}" id="inputPasswordConfirm" type="text" placeholder="Nhập địa chỉ của bạn" name="address" value="${requestScope.u.address}"/>
                                                            <label for="inputAddress">Địa chỉ</label>
                                                            <c:if test="${not empty errorAddress}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorAddress}" />
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>

                                                    <div class="mt-4 mb-0">
                                                        <div class="d-grid"><input type="submit" class="btn btn-primary btn-block" value="Thay đổi"/></div>
                                                    </div>
                                                </form>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                    </div>
                </main>
                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/js/scripts.js"></script>
    </body>
</html>


