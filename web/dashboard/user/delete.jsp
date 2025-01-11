<%-- 
    Document   : delete
    Created on : Jan 12, 2025, 1:45:37 AM
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
                    <div class="container-fluid px-4 mb-3">
                        <h1 class="mt-4">Quản lý người dùng</h1>
                        <div class="d-flex justify-content-between align-items-center">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active">Xóa khách hàng</li>
                            </ol>
                            <a class="btn btn-primary" href="/electro-store/admin/quan-ly-khach-hang" role="button">Quay lại</a>
                        </div>
                        <c:if test="${not empty u}">
                            <div class="alert alert-danger" role="alert">
                                Bạn chắc chắn muốn xóa vĩnh viễn người dùng ${requestScope.u.fullName}
                                <br>
                                - Lưu ý: Sẽ không thể lấy lại dữ liệu sau khi xóa!
                                <br>
                                - Hãy cân nhắc kỹ trước khi ấn xác nhận xóa.
                            </div>
                            <form action="/electro-store/admin/xac-nhan-xoa-khach-hang" method="POST">
                                <input type="hidden" name="user_id" value="${requestScope.u.userId}"/>
                                <button type="submit" class="btn btn-danger">Xóa</button>                                   
                            </form>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        <c:choose>
                            <c:when test="${param.error == '1'}">
                                <div class="alert alert-danger" role="alert">
                                    Xóa sản phẩm thất bại!Hãy thử lại!
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </main>
                <%@include file="../layout/footer.jsp" %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../resources/admin/js/scripts.js"></script>
    </body>
</html>

