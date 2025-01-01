<%-- 
    Document   : header.jsp
    Created on : Dec 20, 2024, 6:53:35 PM
    Author     : DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li><a href="#"><i class="fa fa-phone"></i> +021-95-51-84</a></li>
                <li><a href="#"><i class="fa fa-envelope-o"></i> email@email.com</a></li>
                <li><a href="#"><i class="fa fa-map-marker"></i> Hải Dương, Việt Nam</a></li>
            </ul>
            <c:if test="${empty sessionScope.currentUser}">
                <ul class="header-links pull-right">
                    <li><a href="http://localhost:8080/electro-store/dang-ky"><i></i>Đăng ký</a></li>
                    <li style="color:white;"> |</li>
                    <li><a href="http://localhost:8080/electro-store/dang-nhap"><i></i>Đăng nhập</a></li>
                </ul>
            </c:if>
            <c:if test="${not empty sessionScope.currentUser}">
                <ul class="header-links pull-right">
                    <li><a href="#"><i class="fa fa-dollar"></i> VNĐ</a></li> 
                    <li>
                        <div class="dropdown shows">
                            <a href="#" class="dropdown-toggle" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-user-o"></i> ${sessionScope.currentUser.fullName}
                            </a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <a class="dropdown-item" href="#">Trang cá nhân</a>
                                <a class="dropdown-item" href="dang-xuat">Đăng xuất</a>
                            </div>
                        </div>    
                    </li>
                </ul>
            </c:if>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="d-flex justify-content-between row">
                <!-- LOGO -->
                <div class="col-md-6">
                    <div class="header-logo">
                        <a href="#" class="logo">
                            <img src="./resources/client/img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->


                <!-- ACCOUNT -->
                <div class="col-md-6 clearfix">
                    <div class="header-ctn">
                        <!-- Cart -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Giỏ hàng</span>
                                <c:if test="${not empty sessionScope.currentUser}">
                                    <div class="qty">3</div>
                                </c:if>
                            </a>
                            <div class="cart-dropdown">
                                <c:if test="${empty sessionScope.currentUser}">
                                    <div class="cart-empty">
                                        <img style="width:100%;"  src="./resources/client/img/cart-empty.png" alt="">
                                    </div>
                                    <h5 style="color:#1E90FF;">Chưa có sản phẩm trong giỏ hàng</h5>
                                </c:if>	
                                <c:if test="${not empty sessionScope.currentUser}">									<div class="cart-list">
                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="./resources/client/img/product01.png" alt="">
                                            </div>
                                            <div class="product-body">
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price"><span class="qty">1x</span>$980.00</h4>
                                            </div>
                                            <button class="delete"><i class="fa fa-close"></i></button>
                                        </div>

                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="./resources/client/img/product02.png" alt="">
                                            </div>
                                            <div class="product-body">
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price"><span class="qty">3x</span>$980.00</h4>
                                            </div>
                                            <button class="delete"><i class="fa fa-close"></i></button>
                                        </div>
                                    </div>
                                    <div class="cart-summary">
                                        <small>3 Item(s) selected</small>
                                        <h5>SUBTOTAL: $2940.00</h5>
                                    </div>
                                    <div class="cart-btns">
                                        <a href="#">View Cart</a>
                                        <a href="#">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                        <!-- /Cart -->
                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
