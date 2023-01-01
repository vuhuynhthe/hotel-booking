<%-- 
    Document   : bookinginfo
    Created on : Nov 19, 2022, 1:13:08 PM
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
        <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/4.6.2/css/bootstrap.min.css"/>"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <title>JSP Page</title>
        <!-- Css Styles -->
        <jsp:include page="include/user/css-page.jsp" />
    </head>
    <style>
        label {
            font-size: 15px;
        }

        hr{
            background-color: #e5e5e5;
        }
    </style>
    <body>
        <!-- Header Section Begin -->
        <jsp:include page="include/user/header.jsp"/>
        <!-- Header End -->
        <hr>
        <form action="${pageContext.request.contextPath}/bookinged" 
                method="POST">
            <div class="container" style=" margin: auto">
                <h2 style="color:red;text-align: center;">${tinnhan}</h2><br>
                <h2 style="color:red;text-align: center;">${tinnhan1}</h2><br>
                <h2 style="color:red;text-align: center;">${tinnhan2}</h2><br>
                <h2 style="color:red;text-align: center;">${tinnhan3}</h2><br>
                <sec:authorize access="!isAuthenticated()">
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group" style="text-align: center;">
                                        <label style="font-size: 35px;">Thông tin liên hệ</label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <i class="fa-solid fa-venus-mars"></i>
                                        <label>Tiêu Đề</label><br>
                                        <select  name="gender" class="" > 
                                            <option value="false" selected>
                                                Anh
                                            </option>
                                            <option value="true">
                                                Chị
                                            </option>
                                        </select>       
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <i class="fa-solid fa-user"></i>
                                        <label>Tên</label>
                                        <input class="form-control" name="name"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;" required
                                               />    
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <i class="fa-solid fa-phone"></i>
                                        <label>Số điện thoại</label>
                                        <input class="form-control" name="phoneNumber"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"
                                               required  />  
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <i class="fa-solid fa-envelope"></i>
                                        <label>Email</label>
                                        <input type="email" class="form-control" name="email"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"required
                                               />  
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <i class="fa-solid fa-cake-candles"></i>
                                        <label>Ngày sinh</label><br>
                                        <input type="date"  name="birthDate" required="" 
                                               style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;border: 1px solid #ced4da;border-radius: 4px;width: 312px;">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-pen-nib"></i>
                                        <label>Yêu cầu thêm</label>
                                        <textarea class="form-control"
                                                  name="note" style="font-size: 17px;"required >Ví dụ: Sở thích về giường địa điểm đón hoặc trả khách </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-1">

                        </div>
                        <div class="col-sm-4">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group"style="text-align: center;font-size: 25px;">
                                        <label style="color: #000;font-size: 27px;">Yêu cầu đặt phòng của bạn</label>

                                    </div>
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-check"></i>
                                        <label>Nhận phòng<span> : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkin}" /></span></label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-check"></i>
                                        <label>Trả phòng<span> :<fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkout}" /></span></label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-check"></i>
                                        <label>Số đêm: <span> ${day}</span></label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>Nhập mã khuyến mại/ mã voucher(nếu không có mã không cần nhập)</label><br><!-- comment -->
                                         <input class="form-control" placeholder="Mã khuyến mãi" maxlength="5"minlength="5" name="code" type="text" style="height: calc(1.5em + 0.75rem + 9px);
                                               font-size: 17px;border: 1px solid #ced4da;border-radius: 4px;width: 312px;">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-money-bill"></i>
                                        <label style="color:red">Tổng giá : </label>
                                        <fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${total}" /> VNĐ
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group" style="text-align: center;">
                                        <label style="font-size: 35px;">Thông tin liên hệ</label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <i class="fa-solid fa-venus-mars"></i>
                                        <label>Tiêu Đề</label><br>
                                        <select  name="gender"> 
                                            <c:if test="${acc.gender}">
                                                <option value="false">
                                                    Nam
                                                </option>
                                            </c:if>
                                            <c:if test="${!acc.gender}">
                                                <option value="true">
                                                    Nữ
                                                </option>
                                            </c:if>
                                        </select>       
                                    </div>
                                </div>
                                <!----------------id------------------------------------------->
                                <input hidden class="form-control" id="id" name="id"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;" 
                                       value="${acc.id}"/>
                                <!----------------id------------------------------------------->
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <i class="fa-solid fa-user"></i>
                                        <label for="">Tên</label>
                                        <input class="form-control" name="name"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;" readonly
                                               value="${acc.name}"/>    
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <i class="fa-solid fa-phone"></i>
                                        <label>Số điện thoại</label>
                                        <input class="form-control" name="phoneNumber"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"readonly
                                               value="${acc.phoneNumber}"/>  
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <i class="fa-solid fa-envelope"></i>
                                        <label>Email</label>
                                        <input class="form-control"name="email"style="height: calc(1.5em + 0.75rem + 9px);font-size: 17px;"readonly
                                               value="${acc.email}"/>  
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <i class="fa-solid fa-cake-candles"></i>
                                        <label>Ngày sinh</label><br>
                                        <input type="date" name="birthDate"  style="height: calc(1.5em + 0.75rem + 9px);
                                               font-size: 17px;border: 1px solid #ced4da;border-radius: 4px;width: 312px;" readonly
                                               value="${acc.birthDate}">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-pen-nib"></i>
                                        <label>Yêu cầu thêm</label>
                                        <textarea class="form-control"
                                                  name="note" style="font-size: 17px;"required >Ví dụ: Sở thích về giường địa điểm đón hoặc trả khách </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-1">

                        </div>
                        <div class="col-sm-4">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group"style="text-align: center;font-size: 25px;">
                                        <label style="color: #000;font-size: 27px;">Yêu cầu đặt phòng của bạn</label>

                                    </div>
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-check"></i>
                                        <label>Nhận phòng<span> : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkin}" /></span></label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-check"></i>
                                        <label>Trả phòng<span> : <fmt:formatDate pattern="dd-MM-yyyy" value="${bookingSession.checkout}" /></span></label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-check"></i>
                                        <label>Số đêm : <span> ${day}</span></label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>Nhập mã khuyến mại/ mã voucher(nếu không có mã không cần nhập)</label><br><!-- comment -->
                                        <input class="form-control" placeholder="Mã khuyến mãi" maxlength="5"minlength="5" name="code" type="text" style="height: calc(1.5em + 0.75rem + 9px);
                                               font-size: 17px;border: 1px solid #ced4da;border-radius: 4px;width: 312px;">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <i class="fa-solid fa-money-bill"></i>
                                        <label style="color:red">Tổng giá : </label>
                                        <fmt:formatNumber type = "number" 
                                                          maxFractionDigits = "3" value = "${total}" /> VNĐ
                                    </div>
                                </div>
                            </div>

                        </div>            

                    </div>
                </sec:authorize>
                <hr><br>
                <div class="row">
                    <div class="col-sm-7">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group"style="text-align: center;font-size: 25px;">
                                    <label style="color: #000;font-size: 25px;">Chính sách đặt phòng</label>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Khách sạn Sona</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Nhận phòng: 14:00</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Trả phòng: 12:00</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Phụ thu người lớn: 320,000 VNĐ/ đêm </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Phụ thu trẻ em: 180,000 VNĐ/ đêm (trẻ em dưới 5 tuổi sẽ được miễn phí)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Huỷ :<span style="font-weight: 100"> Nếu hủy, thay đổi hoặc không đến, khách sẽ trả toàn bộ giá trị tiền đặt phòng.</span></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Thanh toán :<span style="font-weight: 100"> Thanh toán toàn bộ giá trị tiền đặt phòng.</span></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <i class="fa-solid fa-check"></i>
                                    <label>Đã bao gồm ăn sáng </label>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-sm-1">

                    </div>
                    <div class="col-sm-4">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group"style="text-align: center;font-size: 25px;">
                                    <label  style="color: #000;font-size: 25px;">Phương thức thanh toán</label>

                                </div>
                            </div>
                        </div>
                        <hr><br>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <select> 
                                        <option value="#" selected>
                                            Internet Banking
                                        </option>
                                    </select>      
                                </div>
                            </div>
                        </div>
                        <br><br>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <input required="" type="checkbox"  value="Boat">
                                    <label for="vehicle3"> Vui lòng đọc kỹ và đồng ý với điều khoản đặt phòng bằng cách đánh dấu vào ô bên cạnh.</label><br><br>
                                </div>
                            </div>
                        </div> 
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">

                                    <button type="submit"style="font-size: 25px;
                                            background-color: orange;
                                            color: white;
                                            border: none;">
                                        <i class="fa-solid fa-key" style="color:black;"></i>
                                        THỰC HIỆN ĐẶT PHÒNG
                                    </button>
                                </div>
                            </div>
                        </div>  
                    </div>
                </div>
            </div>
        </form>

        <jsp:include page="include/user/footer-page.jsp"/>

        <jsp:include page="include/user/js-page.jsp"/>
<!--        <script>
            $("#btnSubmitFormBooking").click(function () {
                $('#formBooking').submit();
            });
        </script>-->
    </body>
</html>
