<%-- 
    Document   : services
    Created on : Nov 30, 2022, 2:07:14 PM
    Author     : Administrator
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Booking Page</title>
            <jsp:include page="../include/admin/css-page.jsp"/>
        </head>
        <body>
            <div class="main-wrapper">
                <jsp:include page="../include/admin/header.jsp"/>
                <jsp:include page="../include/admin/menu.jsp"/>
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="mt-5">
                                        <h4 class="card-title float-left mt-2">All Booking</h4>
                                        <button class="badge badge-pill badge-info float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAdd">Add Booking</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <select id="searchBy" class="form-control form-group col-sm-2">
                                    <option >Search</option>
                                    <option value="1">Search by email</option>
                                    <option value="2">Search by check in</option>
                                    <option value="3">Search by check out</option>
                                </select>
                                <form class="form-group" action="${pageContext.request.contextPath}/manager/search-booking" method="POST" id="searchByEmail">
                                    <div class="form-inline">
                                        <input class="form-control mr-sm-2" type="email" name="email" placeholder="Email..." aria-label="Search">
                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                    </div>
                                </form>
                                <form class="form-group" action="${pageContext.request.contextPath}/manager/search-booking" method="POST" id="searchByCheckin">
                                    <div class="form-inline">
                                        <label for="checkinSearch">Checkin:</label>
                                        <input class="form-control mr-sm-2" type="date" name="checkin" id="checkinSearch"  aria-label="Search">
                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                    </div>
                                </form>
                                <form class="form-group" action="${pageContext.request.contextPath}/manager/search-booking" method="POST" id="searchByCheckout">
                                    <div class="form-inline">
                                        <label for="checkoutSearch">Checkout:</label>
                                        <input class="form-control mr-sm-2" type="date" name="checkout" id="checkoutSearch" aria-label="Search">
                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card card-table">
                                    <div class="card-body booking_card">
                                        <div class="row">
                                            <div class="form-group col-sm-2">
                                                <label for="size">Display:</label>
                                                <select id="size">
                                                    <option>${size}</option>
                                                    <option value="10">10</option>
                                                    <option value="20">20</option>
                                                    <option value="50">50</option>
                                                    <option value="100">100</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="datatable table table-stripped table table-hover table-center mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Name</th>
                                                        <th>Phone number</th>
                                                        <th>Email</th>
                                                        <th>Arrive</th>
                                                        <th>Depart</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <p class="text-danger">${errorSearch}</p>
                                                <c:forEach items="${bookings}" var="booking" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>${booking.name}</td>
                                                        <td>${booking.phoneNumber}</td>
                                                        <td>${booking.email}</td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY" value="${booking.checkin}"/>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY" value="${booking.checkout}"/>
                                                        </td>
                                                        <td>${booking.status}</td>
                                                        <td>
                                                            <button class="badge badge-pill badge-success" onclick="window.location.href = '${pageContext.request.contextPath}/manager/booking/${booking.id}'"><i class="fas fa-sticky-note m-r-5"></i>View detail</button>
                                                            <c:if test="${booking.status == 'COMPLETED' && booking.account == null || booking.status == 'CANCEL' && booking.account == null}">
                                                                <a class="badge badge-danger" href="${pageContext.request.contextPath}/manager/delete-booking?id=${booking.id}" onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="tank_paging" class="col-sm-12">
                                        <ul class="pagination">
                                            <c:forEach begin="0" end="${pages}" var="i">
                                                <li class="page-item">
                                                    <c:if test="${i == page}">
                                                        <input disabled="" type="button" value="${i+1}">
                                                    </c:if>
                                                    <c:if test="${i != page}">
                                                        <input id="page" onclick="window.location.href = '<c:url value="view-booking?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
                                                    </c:if>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal Add -->
                <div class="modal fade" id="formAdd">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Form Booking</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <form id="formAddBooking">
                                <div class="modal-body">
                                    <div class="row formtype">
                                        <div class="form-group col-sm-6">
                                            <label for="name">Name</label>
                                            <input type="text" class="form-control" id="name" name="name" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="email">Email</label>
                                            <input type="text" class="form-control" id="email" name="email" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="phoneNumber">Phone number</label>
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="birthDate">Birth</label>
                                            <input type="date" class="form-control" id="birthDate" name="birthDate" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="checkin">Arrival Date</label>
                                            <input type="date" class="form-control" id="checkin" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="checkout">Depature Date</label>
                                            <input type="date" class="form-control" id="checkout" required="">
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label for="note">Note</label>
                                            <textarea class="form-control" id="note" rows="2" name="note"></textarea>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label for="categories">Room Categories</label>
                                            <select class="form-control" id="categoryId" name="categoryId" required="">
                                                <c:forEach items="${roomCategories}" var="category">
                                                    <option value="${category.id}">${category.name} : <fmt:formatNumber type="number" pattern="###,###,###" value="${category.price}"/><sup>đ</sup>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="quantity">Quantity</label>
                                            <input type="number" class="form-control" id="quantity" name="quantity" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <br>
                                            <p id="errorBooking" class="text-danger"></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary" >Add</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../include/admin/js-page.jsp"/>
            <div class="modal-loading"></div>
            <script>
                $('#size').change(function () {
                    let size = $('#size').val();
                    window.location.href = 'view-booking?size=' + size;
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
            <script>
                $('#formAddBooking').submit(function (event) {
                    event.preventDefault();
                    let name = $('#name').val();
                    let email = $('#email').val();
                    let phoneNumber = $('#phoneNumber').val();
                    let birthDate = $('#birthDate').val();
                    let checkin = $('#checkin').val();
                    let checkout = $('#checkout').val();
                    let note = $('#note').val();
                    let categoryId = $('#categoryId').val();
                    let quantity = $('#quantity').val();
                    $.ajax({
                        url: "add-booking",
                        type: 'POST',
                        data: {
                            name: name,
                            email: email,
                            phoneNumber: phoneNumber,
                            birthDate: birthDate,
                            checkin: checkin,
                            checkout: checkout,
                            note: note,
                            categoryId: categoryId,
                            quantity: quantity
                        },
                        success: function (data, textStatus, jqXHR) {
                            if (data == 'error2') {
                                $('#errorBooking').html("Not enough number of rooms as selected!");
                            } else if (data == 'error1') {
                                $('#errorBooking').html("Departure date must be greater than arrival date!");
                            } else {
                                alert("Add successfully!");
                                location.href = 'booking/' + data;
                            }
                        }
                    });
                });
            </script>
            <!--Search-->
            <script>
                $('#searchByEmail').hide();
                $('#searchByCheckin').hide();
                $('#searchByCheckout').hide();
                $('#searchBy').change(function () {
                    {
                        let value = $('#searchBy').val();
                        if (value == 1) {
                            $('#searchByCheckin').hide();
                            $('#searchByCheckout').hide();
                            $('#searchByEmail').show();
                        } else if (value == 2) {
                            $('#searchByEmail').hide();
                            $('#searchByCheckin').show();
                            $('#searchByCheckout').hide();
                        } else if (value == 3) {
                            $('#searchByEmail').hide();
                            $('#searchByCheckin').hide();
                            $('#searchByCheckout').show();
                        } else {
                            $('#searchByEmail').hide();
                            $('#searchByCheckin').hide();
                            $('#searchByCheckout').hide();
                        }
                    }
                });
            </script>
        </body>
    </html>
