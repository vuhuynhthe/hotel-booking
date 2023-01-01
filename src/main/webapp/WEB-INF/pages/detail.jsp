<%-- 
    Document   : user-detail
    Created on : Nov 3, 2022, 10:11:38 PM
    Author     : win
--%>

<%-- 
    Document   : form
    Created on : Nov 2, 2022, 2:01:06 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <jsp:include page="include/user/css-page.jsp" />
    </head>
    <body>
         <jsp:include page="include/user/header.jsp"/>
        <!-- Header Section Begin -->
        <div class="container">
            
                <div class="row">
                    <div class="col-sm-12" style="text-align: center">
                        <h1>Thông tin chi tiết của phòng</h1>
                    </div>
                </div><br><br><br>
                <div class="row">
                    <div class="col-sm-6">
                    <c:forEach items="${detail.images}" var="p">
                        <div class="mySlides">
                            <div class="numbertext"></div>
                            <img class="img-thumbnail" style="width:100%" src="<c:url value="/resources/img/room/${p.name}"/>" >
                        </div>

                        <!--                        <a style="color:black;" class="prev" onclick="plusSlides(-1)">❮</a>
                                                <a style="color:black;" class="next" onclick="plusSlides(1)">❯</a>-->

                    </c:forEach>

                </div>
                <div class="col-sm-6">
                    <h4 id="productId" hidden>${detail.id}</h4>
                    <h2>${detail.name}</h2><br><br>
                    <h3 class="text-danger"><span style="color: black">Price:</span> ${detail.price} VND/Pernight</h3><br><br>
                    <h3 class="text-danger"><span style="color: black">Size:</span>  ${detail.size} m2 </h3>
                </div>

            </div>


            <div class="row">
                <div class="col-sm-6">
                    <h3>Mô tả sản phẩm</h3>
                    <p>${detail.desciption}</p>
                </div>
                
                <div class="col-sm-6">

                    <a href="<c:url value="/bookinginfo"/>" class="bk-btn" style="font-size: 30px">Chọn Phòng</a>

                </div>

            </div>
                
        </div>
        <!-- Blog Section End -->
    </div>
    <jsp:include page="include/user/footer-page.jsp"/>

    <jsp:include page="include/user/js-page.jsp"/>
</body>
</html>

