<%-- 
    Document   : room-details
    Created on : Nov 14, 2022, 2:10:23 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Sona Template">
        <meta name="keywords" content="Sona, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sona | Hotel</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <!-- Css Styles -->
        <jsp:include page="include/user/css-page.jsp" />

    </head>
    <style>

    </style>
    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr>
        <h2 style="color: red;text-align: center;">${message}</h2>
        <div class="room-booking">
            <form action="${pageContext.request.contextPath}/searchroom"
                  method="POST">
                <!--<p>Booking Date: <fmt:formatDate pattern="dd-MM-yyyy" value="${now}" /></p>-->
                <div style="display: flex;justify-content: space-evenly;align-items: center;background-color: whitesmoke; ">
                    <div>
                        <i class="fa-solid fa-calendar-days"></i>
                        <label for="date-in">Ngày đến:</label><br>
                        <input type="text" class="date-input" value="<fmt:formatDate pattern="dd-MM-yyyy" value="" />"name="datein" style="width: 235px;
                               height: 50px;
                               text-align: center;
                               background-color: aliceblue;
                               border: none;" required="">
                    </div>
                    <div>
                        <i class="fa-solid fa-calendar-days"></i>
                        <label for="date-out">Ngày đi:</label><br>
                        <input type="text" class="date-input" value="<fmt:formatDate pattern="dd-MM-yyyy" value="" />"name="dateout"style="width: 235px;
                               height: 50px;
                               text-align: center;
                               background-color: aliceblue;
                               border: none;"required="" >
                    </div>

                    <div>
                        <label for="guest">Loại phòng:</label><br>
                        <select  name="categoryId" class="" > 
                            <c:forEach items="${categories}" var="b">
                                <option value="${b.id}">
                                    ${b.name}
                                </option>
                            </c:forEach>
                        </select> 
                    </div>
                    <div>
                        <button class="btn btn-info" style="margin-bottom: 30px;
                                background-color: aliceblue;
                                width: 150px;" type="submit"><i class="fa-solid fa-magnifying-glass"></i>  Tìm Kiếm</button>
                    </div>
                </div>

            </form>
        </div>
        <!-- Breadcrumb Section Begin -->
        <div class="breadcrumb-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-text">
                            <h2>Trang chi tiết</h2>
                            <div class="bt-option">
                                <a href="./home">Trang chủ</a>
                                <span>Phòng</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb Section End -->

        <!-- Room Details Section Begin -->
        <section class="room-details-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="room-details-item">
                            <c:forEach items="${roomCategory.images}" var="i">
                                <img class="img-thumbnail" width="800" src="<c:url value="/resources/img/category/${i.name}"/>" >
                            </c:forEach>
                        </div>
                        <div class="review-add">
                            <h4>Bình luận</h4>
                            <form action="${pageContext.request.contextPath}/comment" method="POST"
                                  modelAttribute="binhluan" class="ra-form">
                                <div class="row">
                                    <sec:authorize access="isAuthenticated()">
                                        <div class="col-lg-6">
                                            <i class="fa-solid fa-user"></i>
                                            <label style="font-size: 15px">Tên</label>
                                            <input type="text" placeholder="Tên" name="name" value="${acc.name}">
                                        </div>
                                        <div class="col-lg-6">
                                            <i class="fa-solid fa-envelope"></i>
                                            <label style="font-size: 15px">Email</label>
                                            <input type="text" placeholder="Email" name="email" value="${acc.email}">
                                        </div>


                                        <div class="col-lg-12">
                                            <label style="font-size: 15px">Đánh giá:</label>
                                            <input placeholder="1 đến 10 điểm" type="text" name="vote"required>
                                        </div>
                                        <div class="col-lg-12">
                                            <textarea placeholder="Viết vào đây...." name="text"required></textarea>
                                            <button type="submit">Xác nhận</button>
                                        </div>
                                    </sec:authorize>
                                    <sec:authorize access="!isAuthenticated()">
                                        <div class="col-lg-6">
                                            <i class="fa-solid fa-user"></i>
                                            <label style="font-size: 15px">Tên</label>
                                            <input type="text" placeholder="Tên" name="name" required>
                                        </div>
                                        <div class="col-lg-6">
                                            <i class="fa-solid fa-envelope"></i>
                                            <label style="font-size: 15px">Email</label>
                                            <input type="text" placeholder="Email" name="email"required>
                                        </div>


                                        <div class="col-lg-3">
                                            <i class="fa-solid fa-pen"></i>
                                            <label style="font-size: 15px">Đánh giá:</label>
                                            <input placeholder="1 đến 10 điểm" type="number" name="vote"required>
                                        </div>
                                        <div class="col-lg-12">
                                            <i class="fa-solid fa-comment"></i>
                                            <label style="font-size: 15px">Viết bình luận</label>
                                            <textarea placeholder="Viết vào đây...." name="text"required></textarea>
                                            <button class="btn btn-info" type="submit">Xác nhận</button>
                                        </div>
                                    </sec:authorize>  
                                </div>
                            </form>
                        </div>
                        <br>
                        <h4>Xem đánh giá</h4>
                        <c:forEach items="${feed}" var="i">
                            <div class="rd-reviews">
                                <div class="review-item">
                                    ${i.name}
                                    <div class="ri-pic">
                                        <img src="<c:url value="/resources/img/room/avatar/avatar-1.jpg"/>" alt="">
                                    </div>
                                    <div class="ri-text">
                                        <span>${i.createDate}</span>
                                        <div class="rating">
                                            <p>${i.vote}/10 điểm</p>
                                        </div>
                                        <p>${i.text}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="col-lg-5">
                        <div class="room-booking">
                            <form action="${pageContext.request.contextPath}/cart/buy"
                                  method="GET">
                                <div class="rd-text">
                                    <div class="rd-title">
                                        <h3>${roomCategory.name}</h3>
                                        <div class="rdt-right">
                                            <div class="rating" style="color: yellow;">
                                                <i class="icon_star"></i>
                                                <i class="icon_star"></i>
                                                <i class="icon_star"></i>
                                                <i class="icon_star"></i>
                                                <i class="icon_star-half_alt"></i>
                                            </div>

                                        </div>
                                    </div><br>
                                    <h2 style="color: #cf783c;"><fmt:formatNumber type = "number" 
                                                      maxFractionDigits = "3" value = "${roomCategory.price}" /> VNĐ<span>/Mỗi đêm</span></h2><br>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td class="r-o">Diện tích:</td>
                                                <td>${roomCategory.size} m2</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Sức chứa:</td>
                                                <td>Tối đa ${roomCategory.capacity} người</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Giường:</td>
                                                <td>${roomCategory.bedInfo}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Tiện ích:</td>
                                                <td>Wifi, Television, Bathroom,...</td>
                                            </tr>
                                        </tbody>
                                    </table><br>
                                    <p class="f-para">${roomCategory.description}</p>

                                </div>
                                <input hidden="" name="roomId"  id="rId" value="${roomCategory.id}">
                            </form>
                        </div><br><br><br><br>
                        <div class="container" style="margin-left: 30px;">
                            <h3>Tiện ích</h3><br>
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Tủ quần áo</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Ga trãi giường gối</label>  
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-ban-smoking"></i>
                                    <label>Phòng không hút thuốc</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-shower"></i>
                                    <label>Vòi sen</label>  
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-shop"></i>
                                    <label>Quầy bar mini</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-globe"></i>
                                    <label>Truy cập internet</label>  
                                </div>
                            </div><!-- comment -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Điều hoà</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-shower"></i>
                                    <label>Phòng tắm, vòi sen</label>  
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Dịch vụ giặt ủi</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Mấy sấy tóc</label>  
                                </div>
                            </div><!-- comment -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-bath"></i>
                                    <label>Phòng có bồn tắm</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-vault"></i>
                                    <label>Két an toàn</label>  
                                </div>
                            </div><!-- comment -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Đồ phòng tắm</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Khắn tắm</label>  
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Đèn bàn</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-cable-car"></i>
                                    <label>Truyền hình cáp</label>  
                                </div>
                            </div><!-- comment -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-table"></i>
                                    <label>Bàn làm việc</label>  
                                </div>
                                <div class="col-lg-6">
                                    <i class="fa-solid fa-wifi"></i>
                                    <label>Wife</label>  
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Room Details Section End -->

        <!-- Footer Section Begin -->
        <jsp:include page="include/user/footer-page.jsp"/>
        <!-- Js Plugins -->
        <jsp:include page="include/user/js-page.jsp"/>
    </body>

</html>
