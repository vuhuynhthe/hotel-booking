<%-- 
    Document   : blog
    Created on : Nov 14, 2022, 2:15:35 PM
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
                            <h2>Blog</h2>
                            <div class="bt-option">
                                <a href="./home">Trang chủ</a>
                                <span>Blog Grid</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb Section End -->

        <!-- Blog Section Begin -->
        <section class="blog-section blog-page spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-1.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Travel Trip</span>
                                <h4><a href="./blog-details.html">Tremblant In Canada</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 15th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-2.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Camping</span>
                                <h4><a href="./blog-details.html">Choosing A Static Caravan</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 15th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-3.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Event</span>
                                <h4><a href="./blog-details.html">Copper Canyon</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 21th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-4.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Trivago</span>
                                <h4><a href="./blog-details.html">A Time Travel Postcard</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 22th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-5.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Camping</span>
                                <h4><a href="./blog-details.html">A Time Travel Postcard</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 25th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-6.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Travel Trip</span>
                                <h4><a href="./blog-details.html">Virginia Travel For Kids</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 28th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-7.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Travel Trip</span>
                                <h4><a href="./blog-details.html">Bryce Canyon A Stunning</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 29th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-8.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Event & Travel</span>
                                <h4><a href="./blog-details.html">Motorhome Or Trailer</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 30th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="blog-item set-bg" data-setbg="resources/img/blog/blog-9.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Camping</span>
                                <h4><a href="./blog-details.html">Lost In Lagos Portugal</a></h4>
                                <div class="b-time"><i class="icon_clock_alt"></i> 30th April, 2019</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="load-more">
                            <a href="#" class="primary-btn">Load More</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Blog Section End -->

        <!-- Footer Section Begin -->
        <jsp:include page="include/user/footer-page.jsp"/>
        <!-- Js Plugins -->
        <jsp:include page="include/user/js-page.jsp"/>
    </body>

</html>
