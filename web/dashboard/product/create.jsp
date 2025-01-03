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
        <title>Quản lý sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(() => {
                const avatarFile = $("#avatarFile");
                avatarFile.change(function (e) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({"display": "block"});
                });
            });
        </script>

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
                                <li class="breadcrumb-item active">Tạo sản phẩm mới</li>
                            </ol>
                            <a class="btn btn-primary" href="http://localhost:8080/electro-store/admin/quan-ly-hang-hoa" role="button">Quay lại</a>
                        </div>
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-7">
                                    <div class="card border-1 rounded-lg mt-5">
                                        <div class="card-body">
                                            <form action="/electro-store/admin/tao-moi-san-pham" method="POST" enctype="multipart/form-data">
                                                <div class="mb-3">
                                                    <label for="exampleFormControlInput1" class="form-label">Tên sản phẩm:</label>
                                                    <input type="text" class="form-control ${not empty nameError ? 'is-invalid' : ''}" id="exampleFormControlInput1" name="name">
                                                    <c:if test="${not empty nameError}">
                                                        <div class="invalid-feedback">
                                                            <c:out value="${nameError}" />
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col">
                                                        <label class="form-label">Giá cả (VNĐ):</label>
                                                        <input type="number" class="form-control ${not empty emptyError ? 'is-invalid' : ''} ${not empty errorPrice ? 'is-invalid' : ''}" name="price">
                                                        <c:if test="${not empty emptyError}">
                                                            <div class="invalid-feedback">
                                                                <c:out value="${emptyError}" />
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${not empty errorPrice}">
                                                            <div class="invalid-feedback">
                                                                <c:out value="${errorPrice}" />
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="col">
                                                        <label class="form-label">Số lượng:</label>
                                                        <input type="number" class="form-control ${not empty emptyError ? 'is-invalid' : ''} ${not empty errorQuantity ? 'is-invalid' : ''}" name="quantity">
                                                        <c:if test="${not empty emptyError}">
                                                            <div class="invalid-feedback">
                                                                <c:out value="${emptyError}" />
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${not empty errorQuantity}">
                                                            <div class="invalid-feedback">
                                                                <c:out value="${errorQuantity}" />
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Miêu tả chi tiết sản phẩm:</label>
                                                    <textarea class="form-control ${not empty desError ? 'is-invalid' : ''}" placeholder="Hãy nêu sự nổi bật của sản phẩm tại đây" id="floatingTextarea2" style="height: 100px" name="description"></textarea>
                                                    <c:if test="${not empty desError}">
                                                        <div class="invalid-feedback">
                                                            <c:out value="${desError}" />
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="mb-3 row">
                                                    <div class="col">
                                                        <label class="form-label">Hãng sản phẩm:</label>
                                                        <select class="form-select" aria-label="Default select example" name="brand">
                                                            <c:forEach items="${sessionScope.brands}" var="brand">
                                                                <option value="${brand.id}" >${brand.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col">
                                                        <label class="form-label">Loại sản phẩm:</label>
                                                        <div class="mt-1">
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked    >
                                                                <label class="form-check-label" for="inlineRadio1">Laptop</label>
                                                            </div>
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                                                <label class="form-check-label" for="inlineRadio2">Máy ảnh</label>
                                                            </div>
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3" >
                                                                <label class="form-check-label" for="inlineRadio3">Phụ kiện</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="mb-3">
                                                    <label for="formFile" class="form-label">Ảnh sản phẩm:</label>
                                                    <input class="form-control ${not empty imgError ? 'is-invalid' : ''}" type="file"  id="avatarFile"  accept=".png, .jpg, .jpeg" name="fileImage" >
                                                    <c:if test="${not empty imgError}">
                                                        <div class="invalid-feedback">
                                                            <c:out value="${imgError}" />
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="col-12 mb-3 d-flex justify-content-center">
                                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                         id="avatarPreview" />
                                                </div>
                                                <div style="color:green;">${requestScope.successMessage}</div>
                                                <div class="d-flex justify-content-between">
                                                    <input class="btn btn-primary" type="submit" value="Tạo sản phẩm" formenctype="multipart/form-data" >
                                                    <a class="btn btn-secondary" href="http://localhost:8080/electro-store/admin/quan-ly-hang-hoa" role="button">Hủy bỏ</a>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/assets/demo/chart-area-demo.js"></script>
        <script src="../resources/admin/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/js/datatables-simple-demo.js"></script>
    </body>
</html>

