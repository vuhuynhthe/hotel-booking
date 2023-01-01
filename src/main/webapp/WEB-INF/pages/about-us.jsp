<%-- 
    Document   : about-us
    Created on : Nov 14, 2022, 2:05:17 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Sona Template">
        <meta name="keywords" content="Sona, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sona | Template</title>
        <!-- Google Font -->
        <!--        <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css?family=Cabin:400,500,600,700&display=swap" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

        <!-- Css Styles -->
        <jsp:include page="include/user/css-page.jsp" />

    </head>

    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->

        <!-- Breadcrumb Section Begin -->
        <div class="breadcrumb-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-text">
                            <h2>Lịch sử</h2>
                            <div class="bt-option">
                                <a href="./home">Trang chủ</a>
                                <span>Lịch sử</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb Section End -->

        <!-- About Us Page Section Begin -->
        <section class="aboutus-page-section spad">
            <div class="container">
                <div class="about-page-text">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="ap-title">
                                <h2>Welcome To Sona.</h2>
                                <p>Được xây dựng vào năm 2019 trong thời kỳ dịch Covid,
                                    khách sạn này nằm ở trung tâm của Thành Phố Đà Nẵng,
                                    dễ dàng tiếp cận các điểm tham quan du lịch của thành phố.
                                    Nơi đây cung cấp các phòng được trang trí trang nhã.</p>
                            </div>
                        </div>
                        <div class="col-lg-5 offset-lg-1">
                            <ul class="ap-services">
                                <li><i class="icon_check"></i> Giảm 20% cho chổ ở.</li>
                                <li><i class="icon_check"></i> Bữa sáng hàng ngày miễn phí</li>
                                <li><i class="icon_check"></i> Dọn dẹp 3 lần mỗi ngày</li>
                                <li><i class="icon_check"></i> Wifi miễn phí.</li>
                                <li><i class="icon_check"></i> Miễn giảm 20% trên Facebook</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="about-page-services">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="ap-service-item set-bg" data-setbg="resources/img/about/about-p1.jpg">
                                <div class="api-text">
                                    <h3>Dịch vụ nhà hàng</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="ap-service-item set-bg" data-setbg="resources/img/about/about-p2.jpg">
                                <div class="api-text">
                                    <h3>Du lịch và cắm trại</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="ap-service-item set-bg" data-setbg="resources/img/about/about-p3.jpg">
                                <div class="api-text">
                                    <h3>Sự kiện và tiệc tùng</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About Us Page Section End -->

        <!-- Video Section Begin -->
        <section class="video-section set-bg" data-setbg="resources/img/video-bg.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="video-text">
                            <h2>Khám phá khách sạn và dịch vụ của chúng tôi</h2>
                            <p>Video review khách san bằng flycam</p>
                            <a href="https://www.youtube.com/watch?v=qOIj1Wynbi8" class="play-btn video-popup"><img
                                    src="resources/img/play.png" alt=""></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Video Section End -->

        <!-- Gallery Section Begin -->
        <section class="gallery-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <span>Thư viện của chúng tôi</span>
                            <h2>Khám phá công việc của chúng tôi</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="gallery-item set-bg" data-setbg="resources/img/gallery/gallery-1.jpg">
                            <div class="gi-text">
                                <h3>Room Luxury</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="gallery-item set-bg" data-setbg="resources/img/gallery/gallery-3.jpg">
                                    <div class="gi-text">
                                        <h3>Room Luxury</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="gallery-item set-bg" data-setbg="resources/img/gallery/gallery-4.jpg">
                                    <div class="gi-text">
                                        <h3>Room Luxury</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="gallery-item large-item set-bg" data-setbg="resources/img/gallery/gallery-2.jpg">
                            <div class="gi-text">
                                <h3>Room Luxury</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Gallery Section End -->

        <!-- Footer Section Begin -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
    </body>

</html>
