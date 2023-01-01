<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .dropbtn {
        background-color: #dfa974;
        color: white;
        padding: 12px;
        font-size: 16px;
        border: none;
    }

    .dropdown {
        position: relative;
        display: inline-block;
    }

    /*    .dropdown-content::after{
            content: "";
            position: absolute;
            right: 40px;
            top: -30px;
            border-width: 20px;
            border-style: solid;
            border-color: transparent transparent #000 transparent;
            }*/

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f1f1f1;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1000;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {
        background-color: #ddd;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .dropdown:hover .dropbtn {
        background-color: #3e8e41;
    }
</style>
<header class="header-section">
    <div class="top-nav">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <ul class="tn-left">
                        <li><i class="fa fa-phone"></i> (12) 345 67890</li>
                        <li><i class="fa fa-envelope"></i> info.sonahotel@gmail.com</li>
                    </ul>
                </div>
                <div class="col-lg-6">
                    <div class="tn-right">
                        <a href="#"><i  style="color: #000" class="fa-brands fa-facebook"></i></a>
                        <a href="#"><i  style="color: #000" class="fa-brands fa-twitter"></i></a>
                        <a href="#"><i  style="color: #000" class="fa-brands fa-instagram"></i></a>
<!--                        <a href="<c:url value="/rooms"/>" class="bk-btn">Đặt phòng ngay</a>-->
                        <sec:authorize access="isAuthenticated()">
                            <sec:authorize access="hasRole('ROLE_USER')">
                                <img class="img-thumbnail" width="50" src="<c:url value="/resources/img/room/avatar/avatar-1.jpg"/>" />
                                <div class="dropdown">
                                    <button class="dropbtn"> <sec:authentication property="principal.username" /> </button>
                                    <div class="dropdown-content">
                                        <a href="<c:url value="/setting"/>">Tài khoản</a>
                                        <a href="<c:url value="/booking-history"/>">Lịch sử đặt phòng</a>
                                        <a href="<c:url value="/logout" />">Đăng xuất</a>
                                    </div>    
                                </div>
                            </sec:authorize>
                            <span class="spanLogin"></span>
                        </sec:authorize>
                        <sec:authorize access="!isAuthenticated()">
                            <a href="<c:url value="/login"/>" class="btn btn-info" style="background-color: red;">Đăng nhập</a>
                            <a href="<c:url value="/register"/>" class="btn btn-info" style="background-color: red;">Đăng ký</a>
                        </sec:authorize>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="menu-item">
        <div class="container">
            <div class="row">
                <div class="col-lg-2">
                    <div class="logo">
                        <a href="<c:url value="/home"/>">
                            <img class="img-thumbnail" width="100" src="<c:url value="/resources/img/logo.png"/>" >
                        </a>
                    </div>
                </div>
                <div class="col-lg-10">
                    <div class="nav-menu">
                        <nav class="mainmenu">
                            <ul>
                                <li class="active"><a href="<c:url value="/home"/>">Trang chủ</a></li>
                                 <li><a href="<c:url value="/rooms"/>">Danh sách phòng</a></li>
                                <li><a href="<c:url value="/about-us"/>">Chi tiết về khách sạn</a></li>
                                <li><a href="<c:url value="/blog-details"/>">Trang blog</a></li>
                                <li><a href="<c:url value="/blog"/>">Tin tức</a></li>
                                <li><a href="<c:url value="/contact"/>">Liên lạc</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <marquee style="color:#dfa974;" behavior="alternate"><i class="fa-solid fa-heart"></i>Rất hân hạnh được đón tiếp quý khách !
        Chào mừng quý khách đến với Sona Hotel. <i class="fa-solid fa-heart"></i></marquee>
</header><br>