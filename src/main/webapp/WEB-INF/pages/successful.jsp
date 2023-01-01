<%-- 
    Document   : successful
    Created on : Dec 14, 2022, 10:39:35 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sona | Hotel</title>
        <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/4.6.2/css/bootstrap.min.css"/>"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <jsp:include page="include/user/css-page.jsp" />
    </head>
    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr>
        <div class="container" style=" margin: auto">
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                        <label for="" style="color: #000;font-size: 25px;">
                            SONA HOTEL
                        </label>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                            <h1  style="color: greenyellow;"><i class="fa-solid fa-check"></i></h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                        <label for="" style="color: orange;font-size: 25px;">
                            Hãy kiểm tra email của bạn !
                        </label>
                    </div>
                </div>
            </div>
             <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                        <label for="" style="color: orange;font-size: 25px;">
                            Đặt phòng của bạn đã được xác nhận và hoàn tất!
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                        <label for="" style="color: #000;font-size: 25px;">
                            Mã đặt phòng : 58686
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                        <label for="" style="color: #000;font-size: 25px;">
                            Rất hân hạnh được phục vụ quý khách !
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"style="text-align: center;font-size: 25px;">
                        <button class="btn btn-info" onclick="location.href = '<c:url value="/home"/>'"">Trở về trang chủ</button>
                    </div>
                </div>
            </div>
            <hr>
        </div>
    </body>
     <!-- Footer Section Begin -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
</html>
