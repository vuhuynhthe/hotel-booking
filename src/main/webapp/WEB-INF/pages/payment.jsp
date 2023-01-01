<%-- 
    Document   : payment
    Created on : Nov 29, 2022, 4:35:27 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/user/css-page.jsp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    </head>
    <style>
        span{
            color: red;
        }
    </style>
    <body>
        <jsp:include page="include/user/header.jsp"/>
        <hr>
        <form action="${pageContext.request.contextPath}/payment" 
              method="POST">
            <div class="container" style=" margin: auto">
                <h2 style="color:red;text-align: center;">${tinnhan}</h2><br>

                <div class="row">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group" style="text-align: center;">
                                    <i style="font-size: 35px;" class="fa-solid fa-landmark"></i>
                                    <label for=""style="font-size: 35px;">Thông tin thanh toán</label>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group" style="text-align: center;">
                                    <i style="font-size: 35px;" class="fa-solid fa-money-bill"></i>
                                    <label for=""style="font-size: 35px;">Số tiền thanh toán</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <i class="fa-brands fa-discord"></i>
                            <label for="">Số thẻ<span>*</span></label>
                            <input class="form-control" id="cardNumber" name="cardNumber"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;" required
                                   value=""/>    
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <i class="fa-solid fa-user"></i>
                            <label for="">Tên chủ thẻ<span>*</span></label>
                            <input class="form-control" style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"
                                   required   value=""/>  
                        </div>
                    </div>
                    <div class="col-sm-1"></div>
                    <div class="col-sm-5">
                        <div class="form-group">
                            <i class="fa-solid fa-money-bill"></i>
                            <label for="">Tồng tiền thanh toán :</label>

                            <fmt:formatNumber type = "number" 
                                              maxFractionDigits = "3" value = "${total}" /> VNĐ
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <i class="fa-brands fa-discord"></i>
                            <label for="">CVCcode<span>*</span></label>
                            <input class="form-control" style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"required
                                   value=""/>  
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">
                            <i class="fa-solid fa-calendar-days"></i>
                            <label for="">Tháng/Năm phát hành<span>*</span></label><br><!-- comment -->
                            <input type="text" class="date-input" id="date-out" required style="height: calc(1.5em + 0.75rem + 9px);
                                   font-size: 17px;border: 1px solid #ced4da;border-radius: 4px;width: 263px;">
                        </div>
                    </div>
                    <div class="col-sm-1">

                    </div>
                    <div class="col-sm-3">
                        <div class="form-group">

                            <img style="width: 50px;" src="resources/img/the-mastercard.png" alt="">
                            <img style="width: 50px;" src="resources/img/visa-card.png" alt="">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <input required="" type="checkbox"  value="Boat">
                            <label for="vehicle3">Xác nhận thông tin thẻ.</label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2">
                        <div class="form-group">
                            <button class="btn btn-warning" type="submit" style="color:#fff;">Thanh toán</button>
                        </div>
                    </div>
                    <div class="col-sm-8">
                    </div>
                    <div class="col-sm-2">
                        <div class="form-group">
                            <a  href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-info"  style="color:#000;">Thay đổi đặt phòng</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!-- Footer Section Begin -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
    </body>
</html>
