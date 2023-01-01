<%-- 
    Document   : booking-detail
    Created on : Dec 9, 2022, 8:30:09 AM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail Page</title>
        <jsp:include page="../include/admin/css-page.jsp"/>
    </head>
    <body>
        <jsp:include page="../include/admin/header.jsp"/>
        <jsp:include page="../include/admin/menu.jsp"/>
        <div class="main-wrapper">
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <div class="col">
                                <h3 class="page-title mt-5">Edit Booking</h3>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <c:if test="${booking.status == 'BOOKED'}">
                                <form:form action="${pageContext.request.contextPath}/manager/update-booking" method="POST" modelAttribute="booking">
                                    <div class="row formtype">
                                        <input type="text" hidden="" id="bookingId" name="id" value="${booking.id}">
                                        <input type="text"  hidden="" name="bookingDate" value="${booking.bookingDate}">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Name</label>
                                                <input type="text" class="form-control" name="name" value="${booking.name}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Arrival Date</label>
                                                <input type="date" class="form-control" readonly="" name="checkin" value="${booking.checkin}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Depature Date</label>
                                                <input type="date" class="form-control" readonly="" name="checkout" value="${booking.checkout}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="email" class="form-control" name="email" value="${booking.email}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Phone Number</label>
                                                <input type="text" class="form-control" name="phoneNumber" value="${booking.phoneNumber}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Birth Date</label>
                                                <input type="date" class="form-control" name="birthDate" value="${booking.birthDate}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Note</label>
                                                <textarea class="form-control" rows="5" name="note">${booking.note}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary buttonedit">Save</button>
                                </form:form>
                            </c:if>
                            <c:if test="${booking.status != 'BOOKED'}">
                                <form>
                                    <div class="row formtype">
                                        <input class="form-control" hidden="" id="bookingId" name="id" value="${booking.id}">
                                        <input class="form-control" hidden="" name="bookingDate" value="${booking.bookingDate}">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Name</label>
                                                <input type="text" class="form-control" readonly="" name="name" value="${booking.name}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Arrival Date</label>
                                                <div class="cal-icon">
                                                    <input type="date" class="form-control" readonly="" name="checkin" value="${booking.checkin}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Depature Date</label>
                                                <div class="cal-icon">
                                                    <input type="date" class="form-control" readonly="" name="checkout" value="${booking.checkout}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="email" class="form-control" name="email"readonly="" value="${booking.email}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Phone Number</label>
                                                <input type="text" class="form-control" name="phoneNumber" readonly="" value="${booking.phoneNumber}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Birth Date</label>
                                                <div class="cal-icon">
                                                    <input type="date" class="form-control" readonly="" name="birthDate" value="${booking.birthDate}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Note</label>
                                                <textarea class="form-control" rows="5" readonly="" name="note">${booking.note}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:if>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="status">Status: </label>
                        <select id="status">
                            <c:forEach items="${statuses}" var="status">
                                <c:if test="${booking.status == status}">
                                    <option value="${status}" selected="">${status}</option>
                                </c:if>
                                <c:if test="${booking.status != status}">
                                    <c:if test="${booking.status == 'CHECK_IN' && status == 'BOOKED' || booking.status == 'CHECK_IN' && status == 'CANCEL'}">
                                        <option value="${status}" disabled="">${status}</option>
                                    </c:if>
                                    <c:if test="${booking.status == 'CHECK_IN' && status != 'BOOKED' && status != 'CANCEL'}">
                                        <option value="${status}">${status}</option>
                                    </c:if>
                                    <c:if test="${booking.status == 'CHECK_OUT' && status != 'COMPLETED'}">
                                        <option value="${status}" disabled="">${status}</option>
                                    </c:if>
                                    <c:if test="${booking.status == 'CHECK_OUT' && status == 'COMPLETED'}">
                                        <option value="${status}">${status}</option>
                                    </c:if>
                                    <c:if test="${booking.status == 'COMPLETED'}">
                                        <option value="${status}" disabled="">${status}</option>
                                    </c:if>
                                    <c:if test="${booking.status == 'BOOKED' && status != 'CHECK_OUT' && status != 'COMPLETED'}">
                                        <option value="${status}">${status}</option>
                                    </c:if>
                                    <c:if test="${booking.status == 'BOOKED' && status == 'CHECK_OUT' || booking.status == 'BOOKED' && status == 'COMPLETED'}">
                                        <option value="${status}" disabled="">${status}</option>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card card-table">
                                <div class="card-body booking_card">
                                    <div class="table-responsive">
                                        <table class="table-stripped table table-bordered table-hover table-center mb-0">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Room number</th>
                                                    <th>Image</th>
                                                    <th>Service</th>
                                                    <th>Price</th>
                                                    <th>Unit price</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${booking.bookingDetails}" var="bookingDetail" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>${bookingDetail.room.roomCategory.name}</td>
                                                        <td>
                                                            <c:forEach items="${bookingDetail.room.roomCategory.images}" var="image" end="0">
                                                                <img style="width: 80px;" src="<c:url value="/resources/img/category/${image.name}"/>">
                                                            </c:forEach>
                                                        </td>
                                                        <td class="col-sm-3">
                                                            <c:forEach items="${bookingDetail.showServiceBookings()}" var="serviceBooking">
                                                                <div class="border border-info">
                                                                    <div>Name: ${serviceBooking.service.name}</div>
                                                                    <div>Price: <fmt:formatNumber type = "number" pattern="###,###,###" value = "${serviceBooking.service.price}"/><sup>đ</sup></div>
                                                                    <div>Quantity: ${serviceBooking.quantity}</div>
                                                                </div>
                                                            </c:forEach>
                                                            <c:if test="${booking.status == 'CHECK_IN' || booking.status == 'BOOKED'}">
                                                                <button onclick="loadService(${bookingDetail.id})" class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formService${bookingDetail.id}" >
                                                                    <i class="fas fa-university m-r-5"></i>Add Service
                                                                </button>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber type = "number" pattern="###,###,###" value = "${bookingDetail.price}"/><sup>đ</sup>
                                                        </td>
                                                        <td>
                                                            <c:set var="unitPrice" value="${bookingDetail.price * day}"/>
                                                            <c:forEach items="${bookingDetail.serviceBookings}" var="serviceBooking">
                                                                <c:set var="unitPrice" value="${unitPrice + (serviceBooking.price * serviceBooking.quantity)}"/>
                                                            </c:forEach>
                                                            <fmt:formatNumber type = "number" pattern="###,###,###" value = "${unitPrice}"/><sup>đ</sup>
                                                        </td>
                                                        <td>
                                                            <c:if test="${booking.status == 'CHECK_IN'}">
                                                                <button onclick="loadVisitor(${bookingDetail.id})" class="badge badge-pill badge-success btnAddVisitor" data-toggle="modal" data-target="#formVisitor${bookingDetail.id}" >
                                                                    <i class="fas fa-user-alt m-r-5"></i>Add Visitor
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${booking.status == 'CHECK_OUT'}">
                                                                <button onclick="loadVisitor(${bookingDetail.id})" class="badge badge-pill badge-success btnAddVisitor" data-toggle="modal" data-target="#formVisitor${bookingDetail.id}" >
                                                                    <i class="fas fa-user-alt m-r-5"></i>View Visitor
                                                                </button>
                                                            </c:if>
                                                        </td>
                                                        <c:set var="id" value="${bookingDetail.id}"/>
                                                    </tr>
                                                    <!-- Modal service -->
                                                <div class="modal fade" id="formService${id}">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Service</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="form-group col-sm-12 text-black-50 text-center">
                                                                    About: <fmt:formatDate pattern="dd/MM/YYYY" value="${booking.checkin}"/> - <fmt:formatDate pattern="dd/MM/YYYY" value="${booking.checkout}"/>
                                                                </div>
                                                                <div class="row formtype">
                                                                    <form id="formServiceDetail">
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="serviceId${id}">Service</label>
                                                                            <select class="form-control" id="serviceId${id}" required>
                                                                                <c:forEach items="${services}" var="service">
                                                                                    <option value="${service.id}">${service.name}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="useDate${id}">Use day</label>
                                                                            <input class="form-control" type="date" id="useDate${id}" required>
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="quantity${id}">Quantity</label>
                                                                            <input class="form-control" type="number" id="quantity${id}" required>
                                                                        </div>
                                                                        <div class="col-sm-6">
                                                                            <br>
                                                                            <br>
                                                                            <p id="errorUsedate${id}" class="text-danger"></p>
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <input class="btn btn-warning" onclick="addService(${id})" type="button" value="Add">
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                                <div class="row col-sm-12">
                                                                    <div class="col-sm-4 border">Service</div>
                                                                    <div class="col-sm-2 border">Price</div>
                                                                    <div class="col-sm-2 border">Use Date</div>
                                                                    <div class="col-sm-2 border">Quantity</div>
                                                                    <div class="col-sm-2 border">Action</div>
                                                                </div>
                                                                <div id="tankServiceDetail${id}">

                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Back</button>
                                                                <button onclick="confirmBookingDetail()" type="button" class="btn btn-primary" data-dismiss="modal">Confirm</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Modal vistor -->
                                                <div class="modal fade" id="formVisitor${id}">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Vistor</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="form-group col-sm-12 text-black-50 text-center">
                                                                    Maximum number of people in room : ${bookingDetail.room.roomCategory.capacity}
                                                                </div>
                                                                <c:if test="${booking.status == 'CHECK_IN'}">
                                                                    <div class="row formtype">
                                                                        <form class="formVisitor">
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="name">Name: </label>
                                                                                <input class="form-control" type="text" name="name" id="name${id}" required>
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="idCard">Id card: </label>
                                                                                <input class="form-control" type="text" maxlength="12" minlength="12" name="idCard" id="idCard${id}" required>
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="phoneNumber">Phone number: </label>
                                                                                <input class="form-control" type="tel" maxlength="15" name="phoneNumber" id="phoneNumber${id}" required>
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="birthDate">Birth: </label>
                                                                                <input class="form-control" type="date" name="birthDate" id="birthDate${id}" required>
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="gender">Gender: </label>
                                                                                <select class="form-control" id="gender${id}" name="gender" required>
                                                                                    <option value="false">Male</option>
                                                                                    <option value="true">Female</option>
                                                                                </select>
                                                                            </div>
                                                                            <div class="col-sm-6">
                                                                                <br>
                                                                                <p id="errorVisitor${id}" class="text-danger"></p>
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <input class="btn btn-warning" onclick="addVisitor(${id})" type="button" value="Add">
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </c:if>
                                                                <div class="col-sm-12">
                                                                    <div class="row col-sm-12">
                                                                        <c:if test="${booking.status == 'CHECK_OUT'}">
                                                                            <div class="col-sm-2 border">#</div>
                                                                        </c:if>
                                                                        <div class="col-sm-2 border">Name</div>
                                                                        <div class="col-sm-2 border">Id card</div>
                                                                        <div class="col-sm-2 border">Phone number</div>
                                                                        <div class="col-sm-2 border">Birth</div>
                                                                        <div class="col-sm-2 border">Gender</div>
                                                                        <c:if test="${booking.status != 'CHECK_OUT'}">
                                                                            <div class="col-sm-2 border">Action</div>
                                                                        </c:if>
                                                                    </div>
                                                                    <div id="tankVisitor${id}">
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Back</button>
                                                                <c:if test="${booking.status == 'CHECK_IN'}">
                                                                    <button onclick="confirmBookingDetail()" type="button" class="btn btn-primary" data-dismiss="modal">Confirm</button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <tr>
                                                <td colspan="5"></td>
                                                <td>Total:</td>
                                                <td>
                                                    <strong>${total} VND</strong>
                                                    <c:if test="${booking.status == 'COMPLETED'}">
                                                        <p class="text-danger">(Discount ${booking.discount}%)</p>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <div class="text-center">
                                            <c:if test="${booking.status == 'CHECK_OUT'}">
                                                <button class="btn btn-outline-primary btn-lg" id="btnFormAdd" data-toggle="modal" data-target="#formPayment">Payment</button>
                                            </c:if>
                                        </div>
                                        <c:if test="${booking.status == 'COMPLETED'}">
                                            <div class="col-sm-12">
                                                <br>
                                                <a class="btn btn-outline-warning btn-sm float-right" href="<c:url value="/manager/booking/invoice-export?id=${booking.id}"/>">Print invoice</a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <a class="btn btn-outline-secondary btn-sm float-left" href="<c:url value="/manager/view-booking"/>">Back to view</a>
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <!-- Modal Payment -->
            <div class="modal fade" id="formPayment">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Payment</h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <form id="formPayment">
                            <input hidden="" type="text" id="bookingId" name="bookingId" value="${booking.id}">
                            <div class="modal-body">
                                <div class="row formtype">
                                    <div class="form-group col-sm-6">
                                        <label for="fullName">Full name</label>
                                        <input type="text" class="form-control" id="fullName" required="">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="cardNumber">Card number</label>
                                        <input type="text" class="form-control" id="cardNumber" name="cardNumber" required="">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label>Expiry date</label>
                                        <div style="display: flex;">
                                            <input type="number" class="form-control text-center border-right-0 col-sm-6" minlength="2" maxlength="2" min="1" max="12" id="month" placeholder="MM" required="">
                                            <span style="margin-top: 4px">/</span>
                                            <input type="number" class="form-control text-center border-left-0 col-sm-5" minlength="2" maxlength="2" min="00" max="99" id="year" placeholder="YY" required="">
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="cvcCode">CVC CODE</label>
                                        <input type="number" class="form-control" minlength="4" maxlength="4" id="cvcCode" required="">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="amount">Amount</label>
                                        <input type="text" class="form-control" id="amount" readonly value="${total}">
                                        <input type="text" class="form-control" id="amountDiscount" readonly>
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="note">Note</label>
                                        <textarea class="form-control" id="note" rows="2" name="note"></textarea>
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="code">Promotion Code</label>
                                        <input type="text" class="form-control" minlength="5" maxlength="5" oninput="checkPromotion(this)">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <br>
                                        <p id="messPromotion" class="text-danger"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button type="submit" id="btnPayment" class="btn btn-primary" >Payment</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-loading"></div>
        <jsp:include page="../include/admin/js-page.jsp"/>
        <script>
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

            function loadService(id) {
                $.ajax({
                    url: "create-session-bdetail",
                    type: 'GET',
                    data: {
                        id: id
                    },
                    success: function (data, textStatus, jqXHR) {
                        showServiceDetail(id);
                    }
                });
            }

            function showServiceDetail(id) {
                $.ajax({
                    url: "load-service-detail",
                    type: 'GET',
                    success: function (data, textStatus, jqXHR) {
                        $('#tankServiceDetail' + id).html(data);
                    }
                });
            }
        </script>
        <script>
            function addService(id) {
                let serviceId = $('#serviceId' + id).val();
                let useDate = $('#useDate' + id).val();
                let quantity = $('#quantity' + id).val();
                $.ajax({
                    url: "add-service-detail",
                    type: 'POST',
                    data: {
                        serviceId: serviceId,
                        useDate: useDate,
                        quantity: quantity
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data == '1') {
                            $('#errorUsedate' + id).html("Use date must be within the booking period!");
                        } else {
                            $('#errorUsedate' + id).html("");
                            showServiceDetail(id);
                            $("#quantity").trigger('reset');
                        }
                    }
                });
            }

            function deletService(index, id) {
                $.ajax({
                    url: "delete-service-detail",
                    type: 'POST',
                    data: {
                        index: index
                    },
                    success: function (data, textStatus, jqXHR) {
                        alert(data);
                        showServiceDetail(id);
                    }
                });
            }
        </script>
        <script>
            function confirmBookingDetail() {
                $.ajax({
                    url: "update-bdetail",
                    type: 'POST',
                    success: function (data, textStatus, jqXHR) {
                        location.reload();
                    }
                });
            }
        </script>
        <script>
            $('#status').change(function () {
                let value = $('#status').val();
                let bookingId = $('#bookingId').val();
                $.ajax({
                    url: "booking-status",
                    type: 'POST',
                    data: {
                        bookingId: bookingId,
                        status: value
                    },
                    success: function (data, textStatus, jqXHR) {
                        location.reload();
                    }
                });
            });
        </script>
        <!--Visitor-->
        <script>
            function loadVisitor(id) {
                $.ajax({
                    url: "create-session-bdetail",
                    type: 'GET',
                    data: {
                        id: id
                    },
                    success: function (data, textStatus, jqXHR) {
                        showVisitor(id);
                    }
                });
            }

            function showVisitor(id) {
                $.ajax({
                    url: "load-visitor",
                    type: 'GET',
                    success: function (data, textStatus, jqXHR) {
                        $('#tankVisitor' + id).html(data);
                    }
                });
            }
        </script>
        <script>
            function addVisitor(id) {
                let name = $('#name' + id).val();
                let idCard = $('#idCard' + id).val();
                let phoneNumber = $('#phoneNumber' + id).val();
                let birthDate = $('#birthDate' + id).val();
                let gender = $('#gender' + id).val();
                $.ajax({
                    url: "add-visitor",
                    type: 'POST',
                    data: {
                        name: name,
                        idCard: idCard,
                        phoneNumber: phoneNumber,
                        birthDate: birthDate,
                        gender: gender
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data == 'fail') {
                            $('#errorVisitor' + id).html("The room has reached the maximum number of people!");
                        }
                        showVisitor(id);
                        $(".formVisitor").trigger('reset');
                    }
                });
            }

            function deletVisitor(index, id) {
                $.ajax({
                    url: "delete-visitor",
                    type: 'POST',
                    data: {
                        index: index
                    },
                    success: function (data, textStatus, jqXHR) {
                        alert(data);
                        showVisitor(id);
                    }
                });
            }
        </script>
        <script>
            $('#amountDiscount').hide();
            function checkPromotion(param) {
                let code = param.value;
                if (code.length == 5) {
                    let bookingId = $("#bookingId").val();
                    $.ajax({
                        url: "check-promotion",
                        type: 'POST',
                        data: {
                            bookingId: bookingId,
                            code: code
                        },
                        success: function (data, textStatus, jqXHR) {
                            if (data == 'error1') {
                                $('#messPromotion').html("Code has not been applied!");
                                $('#amountDiscount').hide();
                                $('#amount').show();
                            } else if (data == 'error2') {
                                $('#messPromotion').html("Expired code!");
                                $('#amountDiscount').hide();
                                $('#amount').show();
                            } else if (data == 'error3') {
                                $('#messPromotion').html("Not enough quantity!");
                                $('#amountDiscount').hide();
                                $('#amount').show();
                            } else if (data == 'error4') {
                                $('#messPromotion').html("Code has been applied before!");
                                $('#amountDiscount').hide();
                                $('#amount').show();
                            } else if (data == 'error5') {
                                $('#messPromotion').html("Code does not exist!");
                                $('#amountDiscount').hide();
                                $('#amount').show();
                            } else {
                                $('#amount').hide();
                                $('#amountDiscount').val(data);
                                $('#amountDiscount').show();
                                $('#messPromotion').html("Code applied successfully!");
                            }
                        }
                    });
                }
            }
        </script>
        <script>
            $('#formPayment').submit(function (e) {
                e.preventDefault();
                let bookingId = $('#bookingId').val();
                let cardNumber = $('#cardNumber').val();
                let note = $('#note').val();
                $.ajax({
                    url: "payment",
                    type: 'POST',
                    data: {
                        bookingId: bookingId,
                        cardNumber: cardNumber,
                        note: note
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data == 'ERROR1') {
                            $('#messPromotion').html("Incorrect card information!");
                        } else if (data == 'ERROR2') {
                            $('#messPromotion').html("The balance in the account is not enough!");
                        } else {
                            alert(data);
                            location.reload();
                        }
                    }
                });
            });
        </script>
    </body>
</html>
