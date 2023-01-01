<%-- 
    Document   : register
    Created on : Dec 2, 2022, 6:57:40 AM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/user/css-page.jsp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    </head>
    <style>span {
            color:red;
        }</style>
    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End --><hr>
        <div class="container" style=" margin: auto">
            <div class="row">
                <div class="col-sm-8">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group" style="text-align: center;">
                                <label for=""style="font-size: 35px;color:red;">${loinhan}</label>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label for=""style="font-size: 35px;">Đăng ký tại đây</label>

                            </div>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/result" 
                          method="POST">

                        <div class="row">
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <i class="fa-solid fa-user"></i>
                                    <label for="">Tên<span>*</span></label>
                                    <input type="tẽt" class="form-control" id="name" name="name"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"
                                           required/>    
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <i class="fa-solid fa-envelope"></i>
                                    <label for="">Email<span>*</span></label>
                                    <input type="email" class="form-control" id="email" name="email"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"
                                           required  />  
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <i class="fa-solid fa-lock"></i>
                                    <label for="">Mật khẩu<span>*</span></label>
                                    <input type="password" class="form-control" id="password" name="password"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"
                                           required  />  
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <i class="fa-solid fa-venus-mars"></i>
                                    <label for="">Giới tính</label><br>
                                    <div style="display: flex;align-items: baseline;
                                         justify-content: space-evenly;">
                                        <input type="radio" id="male" name="gender" required value="false">
                                        <label for="male">Nam</label><br>
                                        <input type="radio" id="female" name="gender" required value="true">
                                        <label for="css">Nữ</label><br>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <i class="fa-solid fa-cake-candles"></i>
                                    <label for="">Ngày sinh<span>*</span></label><br>
                                    <input type="date" id="birthDate" name="birthDate"style="width: 358px;height: calc(1.5em + 0.75rem + 9px);font-size: 17px;border: 1px solid #ced4da;border-radius: 4px;""
                                           required  />  
                                </div>
                            </div>
                        </div>
                        <div class="row">

                        </div>
                        <div class="row">
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <i class="fa-solid fa-phone"></i>
                                    <label for="">Số điện thoại<span>*</span></label>
                                    <input class="form-control" id="phoneNumber" name="phoneNumber"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"
                                           required />  
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <button type="submit"class="form-control"style="height: calc(1.5em + 0.75rem + 9px);
                                            font-size: 17px;background-color: #dfa974; color: #FFF">Lưu</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-sm-4">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <img style="margin-top: 150px;" src="resources/img/about/about-2.jpg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Blog Section End -->

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
    </body>
</html>
