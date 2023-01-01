<%-- 
    Document   : contact
    Created on : Nov 14, 2022, 2:17:31 PM
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

        <!-- Contact Section Begin -->
        <section class="contact-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="contact-text">
                            <h2>Thông tin liên lạc</h2>
                            <p>Chúng tôi đã có mặt ở khắp các tỉnh thành, chào mừng đến bạn đến với Khách sạn Sona</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="c-o">Địa chỉ:</td>
                                        <td>668 Nguyễn Tất Thành, Phường Chính Gián, Quận Thanh Khê, Đà Nẵng</td>
                                    </tr>
                                    <tr>
                                        <td class="c-o">Điện thoại:</td>
                                        <td>(12) 345 67890</td>
                                    </tr>
                                    <tr>
                                        <td class="c-o">Email:</td>
                                        <td>info.colorlib@gmail.com</td>
                                    </tr>
                                    <tr>
                                        <td class="c-o">Fax:</td>
                                        <td>+(12) 345 67890</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-7 offset-lg-1">
                        <form action="#" class="contact-form">
                            <div class="row">
                                <div class="col-lg-6">
                                    <input type="text" placeholder="Your Name">
                                </div>
                                <div class="col-lg-6">
                                    <input type="text" placeholder="Your Email">
                                </div>
                                <div class="col-lg-12">
                                    <textarea placeholder="Your Message"></textarea>
                                    <button type="submit">Xác nhân</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="map">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3022.0606825994123!2d-72.8735845851828!3d40.760690042573295!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89e85b24c9274c91%3A0xf310d41b791bcb71!2sWilliam%20Floyd%20Pkwy%2C%20Mastic%20Beach%2C%20NY%2C%20USA!5e0!3m2!1sen!2sbd!4v1578582744646!5m2!1sen!2sbd"
                        height="470" style="border:0;" allowfullscreen=""></iframe>
                </div>
            </div>
        </section>
        <!-- Footer Section Begin -->
        <jsp:include page="include/user/footer-page.jsp"/>
        <!-- Js Plugins -->
        <jsp:include page="include/user/js-page.jsp"/>
    </body>

</html>
