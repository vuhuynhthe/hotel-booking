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
        <!--        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
                 Google Font 
                <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css?family=Cabin:400,500,600,700&display=swap" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

    </head>

    <body onload="getTotal()">
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr><!-- comment -->
        <div class="container">
            <div class="col-sm-12">
                <h2 style="color: red;text-align: center;">${mess}</h2>
                <h2 style="text-align: center;">Dịch vụ</h2>
            </div><br><br>
            <div class="room-booking">
                <div class="col-sm-12">
                    <c:set var="now" value="<%=new java.util.Date()%>" />
                    <p>Ngày đặt : <fmt:formatDate pattern="dd-MM-yyyy" value="${now}" /></p>
                    <p>Ngày đến : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkin}" /></p>
                    <p>Ngày đi : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkout}" /></p>
                </div>
                <form action="${pageContext.request.contextPath}/cart/add-service"
                      method="POST" modelAttribute="serviceBooking">
                    <div style="display: flex;justify-content: space-evenly;align-items: center;background-color: whitesmoke;padding: 10px; ">
                        <div>
                            <label for="guest">Loại dich vu:</label><br>
                            <select  name="serviceId" class="" > 
                                <c:forEach items="${services}" var="s">
                                    <option value="${s.id}">
                                        ${s.name}
                                    </option>
                                </c:forEach>
                            </select> 
                        </div><br><br>
                        <div>
                            <label for="date-in">Ngày sử dụng:</label><br>
                            <input type="text" class="date-input" id="date-out" name="usedate"required style="width: 235px;
                               height: 50px;
                               text-align: center;
                               background-color: aliceblue;
                               border: none;">
                        </div>
                        <div>
                            <label for="date-out">Số lượng:</label><br>
                            <input type="number" name="quantity" min="1" required style="width: 235px;
                               height: 50px;
                               text-align: center;
                               background-color: aliceblue;
                               border: none;">
                        </div>

                        <button  style="margin-bottom: 5px;
                                background-color: aliceblue;
                                width: 150px;"  type="submit">Thêm vào</button>
                    </div>

                </form>
            </div><br><br>    
            <div class="col-sm-12">
                <div class="col-sm-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Dịch vụ</th>
                                <th scope="col">Giá</th>
                                <th scope="col">Ngày sử dụng</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Giá sau khi nhân số lượng</th>
                                <th scope="col">Hoạt động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${bookingDetail.serviceBookings}" var="s" varStatus="loop">
                                <tr>
                                    <td>${s.service.name}</td>
                                    <td> <fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${s.price}" /><sup>đ</sup></td>
                                    <td><fmt:formatDate pattern="dd-MM-yyyy" value="${s.useDate}" /></td>
                                    <td>${s.quantity}</td>
                                    <td><fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${s.quantity*s.price}" /><sup>đ</sup></td>
                                    <td>
                                        <button onclick="location.href = '<c:url value="/cart/delete-service/${loop.index}"/>'"
                                                class="btn btn-danger">
                                            Xoá
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <th colspan="5" scope="col">Tổng giá</th>
                                <td colspan="2"><span id="total"><fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${totalService}" /></span><sup>đ</sup></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div style="display: flex;justify-content: center;" class="col-sm-12">
                <button onclick="location.href = '<c:url value="/cart/saveAll"/>'" class="btn btn-primary">Lưu</button>
            </div><br><br>
        </div>


        <!-- Footer Section Begin -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>

    </body>
<script>
            function getTotal() {
                let value = $('#status').val();
                if (value == 'CHECK_IN') {
                    $('.btnAddVisitor').show();
                } else {
                    $('.btnAddVisitor').hide();
                }
                $.ajax({
                    url: "get-totalService",
                    type: 'GET',
                    success: function (data, textStatus, jqXHR) {
                        $('#total').html(data);
                    }
                });
            }
        </script>
</html>
