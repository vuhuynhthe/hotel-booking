<%-- 
    Document   : setting
    Created on : Nov 28, 2022, 7:41:17 PM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Edit Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <%--<jsp:include page="include/admin/css-page.jsp"/>--%>
        <jsp:include page="include/user/css-page.jsp" />
    </head>
    <body>
        <jsp:include page="include/user/header.jsp"/>
        <hr>
        <div class="container" style=" margin: auto">
            <div class="main-wrapper">

                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title mt-5">Thông tin khách hàng</h3> </div>
                            </div>
                        </div><br>
                        <div class="row">
                            <div class="col-sm-8">
                                <form:form action="${pageContext.request.contextPath}/update" method="POST" modelAttribute="account">
                                    <input value="${account.id}" name="id" hidden="">
                                    <input value="${account.createDate}" name="createDate" hidden="">
                                    <div hidden="" class="form-group">
                                        <label for="status">Status</label>
                                        <select id="status" required name="status">
                                            <option value="${account.status}" selected="">${account.status}</option>
                                        </select>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <i class="fa-solid fa-user"></i>
                                            <label for="name">Tên khách hàng</label>
                                            <input type="text" class="form-control" id="name" name="name" value="${account.name}" required="">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <i class="fa-solid fa-envelope"></i>
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" value="${account.email}" readonly="">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <i class="fa-solid fa-lock"></i>
                                            <label for="password">Mật khẩu</label>
                                            <input type="password" class="form-control" id="password" name="password" value="${account.password}" readonly="">
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="form-group col-sm-4">
                                            <label for="changePassword">Click vào nếu bạn muốn:</label>
                                            <input id="sendEmail"  class="btn btn-primary" type="button" value="Thay đổi mật khẩu">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div  class="form-group col-sm-6">
                                            <i class="fa-solid fa-venus-mars"></i>
                                            <label for="">Giới tính</label><br>
                                            <c:if test="${!account.gender}">
                                                <div style="display: flex;align-items: baseline;
                                                     justify-content: space-evenly;">
                                                    <input type="radio" id="male" name="gender" checked="" value="false">
                                                    <label for="male">Nam</label><br>
                                                    <input type="radio" id="female" name="gender" value="true">
                                                    <label for="css">Nữ</label><br>
                                                </div>
                                            </c:if>
                                            <c:if test="${account.gender}">
                                                <div style="display: flex;justify-content: space-evenly;
                                                     align-items: baseline;">
                                                    <input type="radio" id="male" name="gender" value="false">
                                                    <label for="male">Nam</label><br>
                                                    <input type="radio"" id="female" name="gender" checked="" value="true">
                                                    <label for="css">Nữ</label><br>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <i class="fa-solid fa-phone"></i>
                                            <label for="phoneNumber">Số điện thoại</label>
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${account.phoneNumber}" required="" max="15" min="10">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <i class="fa-solid fa-cake-candles"></i>
                                            <label for="birth">Ngày sinh</label>
                                            <input type="date" class="form-control" id="birthDate" name="birthDate" value="${account.birthDate}" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <input class="btn btn-danger" type="submit" value="Lưu">
                                    </div>
                                </form:form>
                            </div>
                            <div class="col-sm-4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <img style="width: 100%;" src="resources/img/about/about-2.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div><br><br>
        <div class="modal-loading"></div>

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
        <script>
            $('#sendEmail').click(function () {
                let email = $('#email').val();
                $.ajax({
                    url: "send-email",
                    type: 'POST',
                    data: {
                        email: email
                    },
                    success: function (data, textStatus, jqXHR) {
                        alert(data);
                    }
                });
            });

            $body = $("body");

            $(document).on({
                ajaxStart: function () {
                    $body.addClass("loading");
                    $body.removeClass("modal-open");
                },
                ajaxStop: function () {
                    $body.removeClass("loading");
                    $body.addClass("modal-open");
                }
            });
        </script>
</html>
