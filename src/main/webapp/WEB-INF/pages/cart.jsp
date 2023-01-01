<%-- 
    Document   : cart
    Created on : Nov 11, 2022, 4:24:30 PM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/4.6.2/css/bootstrap.min.css"/>"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" type="text/javascript"></script>
        <jsp:include page="include/user/css-page.jsp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    </head>
    <body onload="getTotal()">
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr>
        <div class="container">
            <div class="col-sm-12">
                <div class="col-sm-12">
                    <h2 style="color: red;text-align: center;">${mess}</h2>
                    <h2 style="text-align: center;">Đặt phòng</h2>
                </div><br><br>
                <div class="col-sm-12">
                    <c:set var="now" value="<%=new java.util.Date()%>" />
                    <p>Ngày đặt : <fmt:formatDate pattern="dd-MM-yyyy" value="${now}" /></p>
                    <p>Ngày đến : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkin}" /></p>
                    <p>Ngày đi : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkout}" /></p>
                </div>

                <div class="col-sm-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Số phòng</th>
                                <th scope="col">Ảnh phòng</th>
                                <th scope="col">Dịch vụ</th>
                                <th scope="col">Giá</th>
                                <th scope="col">Tổng giá từng phòng & dịch vụ</th>
                                <th scope="col">Hoạt động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${bookingDetails}" var="i" varStatus="loop">
                                <tr>
                                    <td>${i.room.roomNumber}</td>
                                    <td>
                                        <c:forEach items="${i.room.roomCategory.images}" var="m">
                                            <img class="img-thumbnail" width="100" src="<c:url value="/resources/img/category/${m.name}"/>" >
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <c:forEach items="${i.serviceBookings}" var="s">
                                            <div>Tên: ${s.service.name}</div>
                                            <div>Giá: <fmt:formatNumber type = "number" 
                                                              maxFractionDigits = "3" value = "${s.price}" />
                                                <sup>đ</sup></div>
                                            <div>Số lượng: ${s.quantity}</div>
                                        </c:forEach>
                                        <button class="btn btn-info" onclick="location.href = '<c:url value="/cart/service/${loop.index}"/>'"">Thêm dịch vụ</button>
                                    </td>
                                    <td><fmt:formatNumber type = "number" 
                                                      maxFractionDigits = "3" value = "${i.room.roomCategory.price}" />
                                        <sup>đ</sup></td>
                                    <td>
                                        <c:set var="unitPrice" value="${i.room.roomCategory.price*day}"/>
                                        <c:forEach items="${i.serviceBookings}" var="serviceBooking">
                                            <c:set var="unitPrice" value="${unitPrice + (serviceBooking.price * serviceBooking.quantity)}"/>
                                        </c:forEach>
                                        <fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${unitPrice}" />
                                        <sup>đ</sup></td>
                                    </td>
                                    <td>
                                        <button onclick="location.href = '<c:url value="/cart/delete-room/${loop.index}"/>'"
                                                class="btn btn-danger">
                                            Xoá
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <th colspan="5" scope="col">Tổng giá</th>
                                <td colspan="2"><span id="total"> <fmt:formatNumber type = "number" 
                                                  maxFractionDigits = "3" value = "${total}" /></span><sup>đ</sup></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div style="display: flex; justify-content: space-between; align-items: center;" class="col-sm-12">
                <button onclick="location.href = '<c:url value="/buy-more"/>'"
                        class="btn btn-primary">
                    Chọn thêm phòng
                </button>
                <c:if test="${bookingSession != null && roomId != null}">
                    <form action="${pageContext.request.contextPath}/checked"
                          method="POST" >
                        <button type="submit" class="btn btn-primary">Tiếp tục</button>
                    </form>
                </c:if>
            </div>
            <div id="content"></div>
        </div><br><br>
        <!-- Footer Section Begin -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
        <script>
            function getTotal() {
                let value = $('#status').val();
                if (value == 'CHECK_IN') {
                    $('.btnAddVisitor').show();
                } else {
                    $('.btnAddVisitor').hide();
                }
                $.ajax({
                    url: "get-total",
                    type: 'GET',
                    success: function (data, textStatus, jqXHR) {
                        $('#total').html(data);
                    }
                });
            }
        </script>
    </body>
</html>
