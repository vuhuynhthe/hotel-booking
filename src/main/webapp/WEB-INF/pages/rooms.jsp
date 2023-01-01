<%-- 
    Document   : rooms
    Created on : Nov 14, 2022, 1:57:22 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Sona Template">
        <meta name="keywords" content="Sona, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sona | Hotel</title>
        <jsp:include page="include/user/css-page.jsp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    </head>

    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr>
        <c:if test="${bookingSession != null && roomId != null}">
            <div class="room-booking">
                <form action="${pageContext.request.contextPath}/search-more"
                      method="POST">
                    <!--<p>Booking Date: <fmt:formatDate pattern="dd-MM-yyyy" value="${now}" /></p>-->
                    <div style="display: flex;justify-content: space-evenly;align-items: center;background-color: whitesmoke; ">
                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="date-in">Ngày đến:</label><br>
                            <input type="text"  value=" <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkin}" />"name="datein" style="width: 235px;
                                   height: 50px;
                                   text-align: center;
                                   background-color: aliceblue;
                                   border: none;"readonly="">
                        </div>
                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="date-out">Ngày đi:</label><br>
                            <input type="text"  value="<fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkout}"/>"name="dateout"style="width: 235px;
                                   height: 50px;
                                   text-align: center;
                                   background-color: aliceblue;
                                   border: none;"readonly="">
                        </div>

                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
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
                            <button style="margin-bottom: 30px;
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
                                <h2>Danh Sách Phòng</h2>
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
            <c:set var="now" value="<%=new java.util.Date()%>" />
            <div class="col-lg-12">

            </div>

            <!-- Rooms Section Begin -->
            <section class="rooms-section spad">
                <div class="container">
                    <div class="row">
                        <c:if test="${fn:length(room)>0}">
                            <c:forEach items="${room}" var="b">
                                <div class="col-lg-4 col-md-6">
                                    <div class="room-item">
                                        <c:forEach items="${b.roomCategory.images}" var="i" end="0">
                                            <img class="img-thumbnail" width="100" src="<c:url value="resources/img/category/${i.name}"/>" >
                                        </c:forEach>
                                        <div class="ri-text">
                                            <h4>${b.roomCategory.name}</h4>
                                            <h3> <fmt:formatNumber type = "number" 
                                                              maxFractionDigits = "3" value = "${b.roomCategory.price}" /> VNĐ<span>/Mỗi đêm</span></h3>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td class="r-o">Số phòng :</td>
                                                        <td><span style="color:red;">${b.roomNumber}</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="r-o">Diện tích :</td>
                                                        <td>${b.roomCategory.size} m2</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="r-o">Sức chứa</td>
                                                        <td>Tối đa  ${b.roomCategory.capacity} người</td>
                                                    </tr>
                                                    <tr>
                                                <i class="fa-solid fa-house"></i>
                                                <td class="r-o">Giường:</td>
                                                <td>${b.roomCategory.bedInfo}</td>
                                                </tr>
                                                <tr>
                                                    <td class="r-o">Dịch vụ:</td>
                                                    <td>Wifi, Television, Bathroom,...</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <!--<a href="#" class="primary-btn">More Details</a>-->
                                            <button onclick="location.href = '<c:url value="/cart/buy/${b.id}"/>'"
                                                    class="btn btn-info">
                                                Đặt phòng
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${fn:length(room)<=0}">
                            <span colspan="8" style="color: red; margin: auto; font-size: 30px;">Rất tiếc, không có phòng nào theo lựa chọn của quý khách!</span>
                        </c:if>      
                    </div>
                </div>
            </section>
        </c:if>
        <c:if test="${bookingSession != null && roomId == null}">
            <div class="room-booking">
                <form action="${pageContext.request.contextPath}/searchroom"
                      method="POST">
                    <!--<p>Booking Date: <fmt:formatDate pattern="dd-MM-yyyy" value="${now}" /></p>-->
                    <div style="display: flex;justify-content: space-evenly;align-items: center;background-color: whitesmoke; ">
                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="date-in">Ngày đến:</label><br>
                            <input type="text" class="date-input" value=" <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkin}" />"name="datein" style="width: 235px;
                                   height: 50px;
                                   text-align: center;
                                   background-color: aliceblue;
                                   border: none;">
                        </div>
                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="date-out">Ngày đi:</label><br>
                            <input type="text" class="date-input" value="<fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkout}"/>"name="dateout"style="width: 235px;
                                   height: 50px;
                                   text-align: center;
                                   background-color: aliceblue;
                                   border: none;">
                        </div>

                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
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
                            <button style="margin-bottom: 30px;
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
                                <h2>Danh Sách Phòng</h2>
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
            <c:set var="now" value="<%=new java.util.Date()%>" />
            <div class="col-lg-12">

            </div>

            <!-- Rooms Section Begin -->
            <section class="rooms-section spad">
                <div class="container">
                    <div class="row">
                        <c:if test="${fn:length(room)>0}">
                            <c:forEach items="${room}" var="b">
                                <div class="col-lg-4 col-md-6">
                                    <div class="room-item">
                                        <c:forEach items="${b.roomCategory.images}" var="i" end="0">
                                            <img class="img-thumbnail" width="100" src="<c:url value="resources/img/category/${i.name}"/>" >
                                        </c:forEach>
                                        <div class="ri-text">
                                            <h4>${b.roomCategory.name}</h4>
                                            <h3> <fmt:formatNumber type = "number" 
                                                              maxFractionDigits = "3" value = "${b.roomCategory.price}" /> VNĐ<span>/Mỗi đêm</span></h3>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td class="r-o">Số phòng :</td>
                                                        <td><span style="color:red;">${b.roomNumber}</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="r-o">Diện tích :</td>
                                                        <td>${b.roomCategory.size} m2</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="r-o">Sức chứa</td>
                                                        <td>Tối đa  ${b.roomCategory.capacity} người</td>
                                                    </tr>
                                                    <tr>
                                                <i class="fa-solid fa-house"></i>
                                                <td class="r-o">Giường:</td>
                                                <td>${b.roomCategory.bedInfo}</td>
                                                </tr>
                                                <tr>
                                                    <td class="r-o">Dịch vụ:</td>
                                                    <td>Wifi, Television, Bathroom,...</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <!--<a href="#" class="primary-btn">More Details</a>-->
                                            <button onclick="location.href = '<c:url value="/cart/buy/${b.id}"/>'"
                                                    class="btn btn-info">
                                                Đặt phòng
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${fn:length(room)<=0}">
                            <span colspan="8" style="color: red; margin: auto; font-size: 30px;">Rất tiếc, không có phòng nào theo lựa chọn của quý khách!</span>
                        </c:if>      
                    </div>
                </div>
            </section>
        </c:if>
        <c:if test="${bookingSession == null}">
            <div class="room-booking">
                <form action="${pageContext.request.contextPath}/searchroom"
                      method="POST">
                    <div style="display: flex;justify-content: space-evenly;align-items: center;background-color: whitesmoke; ">
                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="date-in">Ngày đến:</label><br>
                            <input type="text" class="date-input" name="datein" style="width: 235px;
                                   height: 50px;
                                   text-align: center;
                                   background-color: aliceblue;
                                   border: none;"readonly="">
                        </div>
                        <div>
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="date-out">Ngày đi:</label><br>
                            <input type="text" class="date-input" name="dateout"style="width: 235px;
                                   height: 50px;
                                   text-align: center;
                                   background-color: aliceblue;
                                   border: none;"readonly="">
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
                            <button style="margin-bottom: 30px;
                                    background-color: aliceblue;
                                    width: 150px;" type="submit"> <i class="fa-solid fa-magnifying-glass"></i>  Tìm Kiếm</button>
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
                                <h2>Danh Sách Phòng</h2>
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
            <c:set var="now" value="<%=new java.util.Date()%>" />
            <div class="col-lg-12">

            </div>

            <!-- Rooms Section Begin -->
            <section class="rooms-section spad">
                <div class="container">
                    <div class="row">
                            <c:forEach items="${categories}" var="b">
                                <div class="col-lg-4 col-md-6">
                                    <div class="room-item">
                                        <c:forEach items="${b.images}" var="i" end="0">
                                            <img class="img-thumbnail" width="100" src="<c:url value="resources/img/category/${i.name}"/>" >
                                        </c:forEach>
                                        <div class="ri-text">
                                            <h4>${b.name}</h4>
                                            <h3> <fmt:formatNumber type = "number" 
                                                              maxFractionDigits = "3" value = "${b.price}" /> VNĐ<span>/Mỗi đêm</span></h3>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td class="r-o">Diện tích :</td>
                                                        <td>${b.size} m2</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="r-o">Sức chứa</td>
                                                        <td>Tối đa  ${b.capacity} người</td>
                                                    </tr>
                                                    <tr>
                                                <i class="fa-solid fa-house"></i>
                                                <td class="r-o">Giường:</td>
                                                <td>${b.bedInfo}</td>
                                                </tr>
                                                <tr>
                                                    <td class="r-o">Dịch vụ:</td>
                                                    <td>Wifi, Television, Bathroom,...</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <!--<a href="#" class="primary-btn">More Details</a>-->
                                            <button onclick="location.href = '<c:url value="/detail-room/${b.id}"/>'"
                                                    class="btn btn-info">
                                                Trang chi tiết
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>




        <!-- Rooms Section End -->

        <!-- Footer Section Begin -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
    </body>

</html>
