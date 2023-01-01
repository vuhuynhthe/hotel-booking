<%-- 
    Document   : index
    Created on : Nov 14, 2022, 1:19:31 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Sona Template">
        <meta name="keywords" content="Sona, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sona | Hotel</title>
        <jsp:include page="include/user/css-page.jsp" />
        <!-- Google Font -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    </head>

    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <!-- Hero Section Begin -->
        <h2 style="color: red;text-align: center;">${loinhan}</h2>
        <h2 style="color: red;text-align: center;">${tinnhan}</h2>
        <h2 style="color: red;text-align: center;">${check}</h2>
        <section class="hero-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="hero-text">
                            <h1>Khách Sạn Sona A Luxury</h1>
                            <p>Chào mừng bạn đến với chúng tôi</p>
                            <a href="#" class="primary-btn">Khám phá ngay</a>
                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-5 offset-xl-2 offset-lg-1">
                        <div class="booking-form">
                            <i class="fa-solid fa-check"></i>
                            <label style="font-size: 25px;">Đặt phòng ngay</label>
                            <form action="${pageContext.request.contextPath}/searchroom"
                                  method="POST">
                                <div class="check-date">
                                    <i class="fa-solid fa-calendar-days"></i>
                                    <label for="date-in">Ngày đến:</label>
                                    <input type="text" class="date-input" id="date-in" name="datein" required>
                                    <i class="icon_calendar"></i>
                                </div>
                                <div class="check-date">
                                    <i class="fa-solid fa-calendar-days"></i>
                                    <label for="date-out">Ngày đi:</label>
                                    <input type="text" class="date-input" id="date-out" name="dateout"required>
                                    <i class="icon_calendar"></i>
                                </div>
                                <div class="check-date">
                                    <label for="guest">Loại phòng</label>
                                    <select  name="categoryId" class="" > 
                                        <c:forEach items="${categories}" var="b">
                                            <option value="${b.id}">
                                                ${b.name}
                                            </option>
                                        </c:forEach>
                                    </select>  
                                </div><br><br>
                                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i>  Tìm Kiếm</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hero-slider owl-carousel">
                <div class="hs-item set-bg" data-setbg="<c:url value="resources/img/hero/hero-1.jpg"/>"></div>
                <div class="hs-item set-bg" data-setbg="<c:url value="resources/img/hero/hero-2.jpg"/>"></div>
                <div class="hs-item set-bg" data-setbg="<c:url value="resources/img/hero/hero-3.jpg"/>"></div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- About Us Section Begin -->
        <section class="aboutus-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="about-text">
                            <div class="section-title">
                                <span>Lịch sử về chúng tôi</span>
                                <!--<h2>Intercontinental LA <br />Westlake Hotel</h2>-->
                            </div>
                            <p class="f-para">Khách sạn Sona là một trong những khách sạn hàng đầu tại Việt Nam . Lý do chúng tôi
                                xây dựng khách sạn này là bởi vì chúng tôi muốn phục vụ với mục đích du lịch của quý khách. Bạn cần nơi dừng
                                chân thì đã có chúng tôi "Sona Hotels nơi dừng chân lý tưởng".   </p>
                            <p class="s-para">Vì vậy, khi nói đến việc đặt khách sạn hoàn hảo, nhà nghỉ cho thuê, khu nghỉ dưỡng,
                                căn hộ hoặc nhà khách, chúng tôi sẽ hỗ trợ bạn. Chào mừng bạn đến với Sona Hotels.</p>
                            <a class="primary-btn about-btn"  href="<c:url value="/about-us"/>">Đọc nhiều hơn</a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="about-pic">
                            <div class="row">
                                <div class="col-sm-6">
                                    <img src="<c:url value="resources/img/about/about-1.jpg"/>" alt="">
                                </div>
                                <div class="col-sm-6">
                                    <img src="<c:url value="resources/img/about/about-2.jpg"/>" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About Us Section End -->

        <!-- Services Section End -->
        <section class="services-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <span>Chúng ta sẽ làm gì</span>
                            <h2>Hãy khám phá dịch vụ của chúng tôi</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-6">
                        <div class="service-item">
                            <i class="flaticon-036-parking"></i>
                            <h4>Kế hoạch đi du lịch</h4>
                            <p>Tour du lịch Huế - Đà Nẵng - Hội An. Hãy lên kế hoạch chúng tối sẽ phục vụ bạn.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="service-item">
                            <i class="flaticon-033-dinner"></i>
                            <h4>Dịch vụ ăn uống</h4>
                            <p>Vói tiêu chí chắm sóc sức khoẻ, dinh dưỡng cở thể. Phục vụ quý khách là niềm hân hạnh đối với chúng tôi.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="service-item">
                            <i class="flaticon-026-bed"></i>
                            <h4>Dịch vụ trông trẻ</h4>
                            <p>Nếu bạn cần người trông trẻ, hãy đến với chúng tôi.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="service-item">
                            <i class="flaticon-024-towel"></i>
                            <h4>Dịch vụ giặt ủi</h4>
                            <p>Giúp bạn tiết kiệm thời gian, phục vụ nhanh, hãy đến với dịch vụ của chúng tôi..</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="service-item">
                            <i class="flaticon-044-clock-1"></i>
                            <h4>Dịch vụ thuê tài xế</h4>
                            <p>Nếu bạn cần thuê xe hay tài xế. hãy liên hệ với chúng tôi</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="service-item">
                            <i class="flaticon-012-cocktail"></i>
                            <h4>Dịch vụ quán Bar & Drink</h4>
                            <p>Mỗi tối nếu bạn đang tìm kiếm 1 nơi để giải trí, hãy đến với Bar & Drink . Nơi thưởng thức âm nhạc, giao lưu bạn bè.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Services Section End -->

        <!-- Home Room Section Begin -->
        <section class="hp-room-section">
            <div class="container-fluid">
                <div class="hp-room-items">
                    <div class="row">
                        <c:forEach items="${categories}" var="b" end="3">
                            <div class="col-lg-3 col-md-6">
                                <c:forEach items="${b.images}" var="i">
                                    <div class="hp-room-item set-bg" data-setbg="<c:url value="resources/img/category/${i.name}"/>"/>
                                </c:forEach>
                                <div class="hr-text">
                                    <h3>${b.name}</h3>
                                    <h2> <fmt:formatNumber type = "number" 
                                                      maxFractionDigits = "3" value = "${b.price}" /> VNĐ<span>/Mỗi đêm</span></h2>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td class="r-o">Diện tích:</td>
                                                <td>${b.size} m2</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Sức chứa:</td>
                                                <td>Max persion ${b.capacity}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Kiểu giường:</td>
                                                <td>${b.bedInfo}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Tiện ích:</td>
                                                <td>Wifi, Television, Bathroom,...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <a href="<c:url value="/detail-room/${b.id}"/>" class="primary-btn">Chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>


            </div>
        </div>
    </section>
    <!-- Home Room Section End -->
    <!-- Testimonial Section Begin -->
    <section class="testimonial-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Lời bình luận của khách hàng</span>
                        <h2>Họ đã nói gì?</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 offset-lg-2">
                    <div class="testimonial-slider owl-carousel">
                        <c:forEach items="${feed}" var="i">
                            <div class="ts-item">
                                <p>${i.text}</p>
                                <div class="ti-author">
                                    <div class="rating">
                                        <p>${i.vote}/10 điểm</p>
                                    </div>
                                    <h5>${i.email}</h5>
                                </div>
                                <img src="<c:url value="resources/img/testimonial-logo.png"/>" alt="">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Testimonial Section End -->

    <!-- Blog Section Begin -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Hotel News</span>
                        <h2>Du lịch và sự kiện</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="blog-item set-bg" data-setbg="<c:url value="resources/img/blog/bai-tam-bien-my-khe-da-nang-1.jpg"/>">
                        <div class="bi-text">
                            <span class="b-tag">Travel Beach</span>
                            <h4><a href="#">Bãi tắm Mỹ Khê</a></h4>
                            <div class="b-time"><i class="icon_clock_alt"></i> 15th April, 2019</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-item set-bg" data-setbg="<c:url value="resources/img/blog/image10-2.jpg"/>">
                        <div class="bi-text">
                            <span class="b-tag">Sự kiện</span>
                            <h4><a href="#">Công viên Châu Á</a></h4>
                            <div class="b-time"><i class="icon_clock_alt"></i> 15th April, 2019</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-item set-bg" data-setbg="<c:url value="resources/img/blog/hoaphuthanh.jpg"/>">
                        <div class="bi-text">
                            <span class="b-tag">Du lịch</span>
                            <h4><a href="#">Thác trượt Hoà Phú Thành</a></h4>
                            <div class="b-time"><i class="icon_clock_alt"></i> 21th April, 2019</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="blog-item small-size set-bg" data-setbg="<c:url value="resources/img/blog/Cầu-Vàng_SW-BNH-38.jpg"/>">
                        <div class="bi-text">
                            <span class="b-tag">Du lịch</span>
                            <h4><a href="#">Cầu Vàng</a></h4>
                            <div class="b-time"><i class="icon_clock_alt"></i> 08th April, 2019</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-item small-size set-bg" data-setbg="<c:url value="resources/img/blog/chua-cau-hoi-an-3-1.jpg"/>">
                        <div class="bi-text">
                            <span class="b-tag">Du lịch</span>
                            <h4><a href="#">Phố cổ Hội An</a></h4>
                            <div class="b-time"><i class="icon_clock_alt"></i> 12th April, 2019</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->

    <jsp:include page="include/user/footer-page.jsp"/>

    <jsp:include page="include/user/js-page.jsp"/>

</body>
</html>
