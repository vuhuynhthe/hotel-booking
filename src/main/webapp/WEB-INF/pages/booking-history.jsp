<%-- 
    Document   : booking-history
    Created on : Dec 4, 2022, 8:52:23 AM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <title>JSP Page</title>
        <!-- Css Styles -->
        <jsp:include page="include/user/css-page.jsp" />
    </head>
    <body>

        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr><!-- comment -->
        <div class="container">
            <div class="row" style="padding-top: 10px">
                <div class="col-sm-12">
                    <h2>Lịch sử đặt phòng</h2>
                </div>
            </div>
            <div class="row" style="padding-top: 10px">
                <div class="col-sm-12">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered">
                            <tr>
                                <th style="text-align: center;">Đơn đặt hàng số</th>
                                <th style="text-align: center;">Người đặt</th>
                                <th style="text-align: center;">Kiểu phòng</th>
                                <th style="text-align: center;">Ngày đặt</th>
                                <th style="text-align: center;">Nhận phòng</th>
                                <th style="text-align: center;">Trả phòng</th>
                                <th style="text-align: center;">Tổng tiền</th>
                            </tr>
                            <c:if test="${fn:length(bookingHistory)>0}">
                                <c:forEach items="${bookingHistory}" var="b" varStatus="loop">
                                    <tr style="text-align: center;">
                                        <td>${loop.count}</td>
                                        <td>
                                            ${b.name}
                                        </td>
                                        <td>
                                            <c:forEach items="${b.bookingDetails}" var="bd">
                                                ${bd.room.roomCategory.name}<br>
                                            </c:forEach>
                                        </td>
                                        <td>${b.bookingDate}</td>
                                        <td>${b.checkin}</td>
                                        <td>${b.checkout}</td>
                                        <td><fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${b.total()}" /> VNĐ</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${fn:length(bookingHistory)<=0}">
                                <span colspan="8" style="color: red; margin: auto; font-size: 30px;">Rất tiếc, không có phòng nào theo lựa chọn của quý khách!</span>
                            </c:if>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer Section Begin -->
        <jsp:include page="include/user/footer-page.jsp"/>
        <!-- Js Plugins -->
        <jsp:include page="include/user/js-page.jsp"/>
    </body>
</html>
