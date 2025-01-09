<%-- 
    Document   : laptop_location
    Created on : Jan 8, 2025, 10:11:01 PM
    Author     : DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Electro - HTML Ecommerce Template</title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="./resources/client/css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="./resources/client/css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="./resources/client/css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="./resources/client/css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="./resources/client/css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="./resources/client/css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>
        <!-- HEADER -->
        <%@include file="layout/header.jsp" %>
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <%@include file="layout/nav.jsp" %>  
        <!-- /NAVIGATION -->

        <!-- BREADCRUMB -->
        <!-- /BREADCRUMB -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- ASIDE -->
                    <div id="aside" class="col-md-3">
                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Loại sản phẩm</h3>
                            <div class="checkbox-filter">

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-1">
                                    <label for="category-1">
                                        <span></span>
                                        Laptops
                                        <small>(120)</small>
                                    </label>
                                </div>

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-3">
                                    <label for="category-3">
                                        <span></span>
                                        Máy ảnh
                                        <small>(1450)</small>
                                    </label>
                                </div>

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-6">
                                    <label for="category-6">
                                        <span></span>
                                        Phụ kiện
                                        <small>(740)</small>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Price</h3>
                            <div class="price-filter">
                                <div id="price-slider"></div>
                                <div class="input-number price-min">
                                    <input id="price-min" type="number">
                                    <span class="qty-up">+</span>
                                    <span class="qty-down">-</span>
                                </div>
                                <span>-</span>
                                <div class="input-number price-max">
                                    <input id="price-max" type="number">
                                    <span class="qty-up">+</span>
                                    <span class="qty-down">-</span>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Brand</h3>
                            <div class="checkbox-filter">
                                <div class="input-checkbox">
                                    <input type="checkbox" id="brand-1">
                                    <label for="brand-1">
                                        <span></span>
                                        SAMSUNG
                                        <small>(578)</small>
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input type="checkbox" id="brand-2">
                                    <label for="brand-2">
                                        <span></span>
                                        LG
                                        <small>(125)</small>
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input type="checkbox" id="brand-3">
                                    <label for="brand-3">
                                        <span></span>
                                        SONY
                                        <small>(755)</small>
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input type="checkbox" id="brand-4">
                                    <label for="brand-4">
                                        <span></span>
                                        SAMSUNG
                                        <small>(578)</small>
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input type="checkbox" id="brand-5">
                                    <label for="brand-5">
                                        <span></span>
                                        LG
                                        <small>(125)</small>
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input type="checkbox" id="brand-6">
                                    <label for="brand-6">
                                        <span></span>
                                        SONY
                                        <small>(755)</small>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <!-- /aside Widget -->
                    </div>
                    <!-- /ASIDE -->

                    <!-- STORE -->
                    <div id="store" class="col-md-9">
                        <!-- store top filter -->
                        <div class="store-filter clearfix">
                            <div class="store-sort">
                                <label>
                                    Sắp xếp:
                                    <select class="input-select">
                                        <option value="0">Giá cả</option>
                                        <option value="1">Mới nhất</option>
                                    </select>
                                </label>

                            </div>
                        </div>
                        <!-- /store top filter -->

                        <!-- store products -->
                        <div class="row">
                            <c:forEach items="${products}" var="product" varStatus="status">
                                <div class="col-md-4">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="./resources/admin/img/${product.image}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${product.category.name}</p>
                                            <h3 class="product-name"><a href="#">${product.name}</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number"/> đ</h4>
                                            <!--<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>-->
                                            <div class="product-rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${status.index % 3 == 2}">
                                    <div class="clearfix"></div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <!-- /store products -->

                        <!-- store bottom filter -->
                        <div class="store-filter clearfix">
                            <ul class="store-pagination">
                                <c:forEach begin="1" end="${requestScope.totalPages}" var="i">
                                    <li class="${currentPage eq i ? 'active': ''}"> 
                                        <a href="/electro-store/kho-hang?action=${action}&trang-so=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="${currentPage == totalPages ? 'disabled' : ''}"><a href="/electro-store/kho-hang?action=${action}&trang-so=${currentPage + 1}"><i class="fa fa-angle-right" ></i></a></li>
                            </ul>
                        </div>
                        <!-- /store bottom filter -->
                    </div>
                    <!-- /STORE -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- NEWSLETTER -->
        <!-- /NEWSLETTER -->

        <!-- FOOTER -->
        <%@include file="layout/footer.jsp" %> 
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="./resources/client/js/jquery.min.js"></script>
        <script src="./resources/client/js/bootstrap.min.js"></script>
        <script src="./resources/client/js/slick.min.js"></script>
        <script src="./resources/client/js/nouislider.min.js"></script>
        <script src="./resources/client/js/jquery.zoom.min.js"></script>
        <script src="./resources/client/js/main.js"></script>

    </body>
</html>
