<%-- 
    Document   : create
    Created on : Jan 12, 2025, 12:05:23 AM
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
                                <li class="breadcrumb-item active">Tạo mới người dùng</li>
                            </ol>
                            <a class="btn btn-primary" href="http://localhost:8080/electro-store/admin/quan-ly-khach-hang" role="button">Quay lại</a>
                        </div>
                        <!--tao moi form-->
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-7">
                                    <div class="card shadow-lg border-0 rounded-lg mt-5">
                                        <div class="card-body">
                                            <form action="/electro-store/admin/tao-moi-khach-hang" method="POST">
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="inputFirstName" type="text" placeholder="Nhập họ của bạn" name="firstName" />
                                                            <label for="inputFirstName">Họ</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-floating">
                                                            <input class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}" id="inputLastName" type="text" placeholder="Nhập tên bạn" name="lastName" />
                                                            <label for="inputLastName">Tên</label>
                                                            <c:if test="${not empty errorFirstName}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorFirstName}" />
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3 row">
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control ${not empty errorEmailFormat ? 'is-invalid' : ''} ${not empty errorEmailExist ? 'is-invalid' : ''}" id="inputEmail" type="email" placeholder="name@gmail.com"  name="email"/>
                                                            <label for="inputEmail">Địa chỉ email</label>
                                                            <c:if test="${not empty errorEmailFormat}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorEmailFormat}" />
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${not empty errorEmailExist}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorEmailExist}" />
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control ${not empty errorTel ? 'is-invalid' : ''} ${not empty errorTelFormat ? 'is-invalid' : ''}" id="inputForTelephone" type="text" placeholder="Nhập họ số điện thoại của bạn" name="telephone" />
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
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control ${not empty errorPass2 ? 'is-invalid' : ''}" id="inputPassword" type="password" placeholder="Nhập mật khẩu của bạn" name="pass"/>
                                                            <label for="inputPassword">Mật khẩu</label>
                                                            <c:if test="${not empty errorPass2}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorPass2}" />
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control  ${not empty errorPass ? 'is-invalid' : ''}" id="inputPasswordConfirm" type="password" placeholder="Nhập lại mật khẩu của bạn" name="confirPass"  />
                                                            <label for="inputPasswordConfirm">Nhập lại mật khẩu</label>
                                                            <c:if test="${not empty errorPass}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorPass}" />
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control  ${not empty errorAddress ? 'is-invalid' : ''}" id="inputPasswordConfirm" type="text" placeholder="Nhập địa chỉ của bạn" name="address"  />
                                                        <label for="inputAddress">Địa chỉ</label>
                                                        <c:if test="${not empty errorAddress}">
                                                                <div class="invalid-feedback">
                                                                    <c:out value="${errorAddress}" />
                                                                </div>
                                                            </c:if>
                                                    </div>
                                                </div>
                                                <div class="mb-3 col-md-4">
                                                    <select class="form-select" aria-label="Default select example" name="role_id">
                                                        <option value="1" selected>QUẢN TRỊ VIÊN</option>
                                                        <option value="2">KHÁCH HÀNG</option>
                                                    </select>
                                                </div>
                                                <div class="mt-4 mb-0">
                                                    <div class="d-grid"><input type="submit" class="btn btn-primary btn-block" value="Tạo mới"/></div>
                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                </div>
                            </div>
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

