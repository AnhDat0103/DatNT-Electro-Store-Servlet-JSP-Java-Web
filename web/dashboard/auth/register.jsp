<%-- 
    Document   : register
    Created on : Dec 25, 2024, 7:59:58 PM
    Author     : DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Register - Electro store</title>
        <link href="./resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Tạo tài khoản</h3></div>
                                    <div class="card-body">
                                        <form action="dang-ky" method="POST">
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
                                            <div class="form-floating mb-3">
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
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid"><input type="submit" class="btn btn-primary btn-block" value="Đăng ký"/></div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="http://localhost:8080/electro-store/dang-nhap">Bạn đã có tài khoản? Đăng nhập</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="./resources/admin/js/scripts.js"></script>
    </body>
</html>

