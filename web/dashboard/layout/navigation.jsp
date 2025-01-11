<%-- 
    Document   : navigation
    Created on : Dec 25, 2024, 8:20:54 PM
    Author     : DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Bảng</div>
                            <a class="nav-link" href="http://localhost:8080/electro-store/admin/trang-quan-tri">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Bảng điều khiển
                            </a>
                            <div class="sb-sidenav-menu-heading">Chi tiết</div>
                            <a class="nav-link" href="http://localhost:8080/electro-store/admin/quan-ly-hang-hoa">
                                <div class="sb-nav-link-icon"><i class="fa-brands fa-product-hunt"></i></div>
                                Sản phẩm
                            </a>
                            <a class="nav-link" href="/electro-store/admin/quan-ly-khach-hang">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-person"></i></div>
                                khách hàng
                            </a>
                            <a class="nav-link" href="#">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-cart-shopping"></i></div>
                                Đơn hàng
                            </a>
                            <a class="nav-link" href="#">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-money-bill"></i></div>
                                Khuyến mãi
                            </a>
                           
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-gear"></i></div>
                                Cấp quyền 
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link" href="http://localhost:8080/electro-store/dang-ky">
                                        Đăng ký
                                    </a>
                                    <a class="nav-link" href="#">
                                        Lấy lại mật khẩu
                                    </a>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">Tiện ích bổ sung</div>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Biểu đồ
                            </a>
                            <a class="nav-link" href="tables.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Bảng biểu
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Đăng nhập với tư cách:</div>
                        Quản trị viên
                    </div>
                </nav>
            </div>