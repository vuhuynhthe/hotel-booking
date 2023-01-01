<%-- 
    Document   : rooms
    Created on : Nov 30, 2022, 2:07:08 PM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Page</title>
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
                                    <h4 class="card-title float-left mt-2">All Rooms</h4>
                                    <button type="button" class="badge badge-pill badge-info float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAdd">Add Room</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <form>
                                <div class="row formtype">
                                    <div class="col-md-3">
                                    </div>
                                    <div class="col-md-3">
                                    </div>
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
                                                    <th>Room Number</th>
                                                    <th>Category</th>
                                                    <th>Position</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <p class="text-danger">${message}</p>
                                            <c:forEach items="${rooms}" var="room" varStatus="loop">
                                                <tr>
                                                    <td>${loop.count}</td>
                                                    <td>${room.roomNumber}</td>
                                                    <td>${room.roomCategory.name}</td>
                                                    <td>${room.position}</td>
                                                    <td>${room.status}</td>
                                                    <td>
                                                        <button class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formEdit${room.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Edit</button>
                                                        <c:if test="${room.bookingDetails.size() == null || room.bookingDetails.size() == 0}">
                                                            <a class="badge badge-danger" href="${pageContext.request.contextPath}/manager/delete-room?id=${room.id}"
                                                               onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <!-- Modal Edit -->
                                                <div class="modal fade" id="formEdit${room.id}">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Form Room</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <form:form action="${pageContext.request.contextPath}/manager/save-room" method="POST" modelAttribute="room">
                                                                <div class="modal-body">
                                                                    <input type="text" class="form-control" name="id" value="${room.id}" hidden="">
                                                                    <div class="form-group">
                                                                        <label for="roomNumber">Room number</label>
                                                                        <input type="text" class="form-control" id="roomNumber" name="roomNumber" required="" value="${room.roomNumber}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="position">Position</label>
                                                                        <select id="position" name="position" required="">
                                                                            <c:forEach items="${positions}" var="position">
                                                                                <c:if test="${room.position == position}">
                                                                                    <option value="${position}" selected="">${position}</option>
                                                                                </c:if>
                                                                                <c:if test="${room.position != position}">
                                                                                    <option value="${position}">${position}</option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="rCategoryId">Room category</label>
                                                                        <select id="rCategoryId" name="roomCategory.id" required="">
                                                                            <c:forEach items="${rCategories}" var="category">
                                                                                <c:if test="${room.roomCategory.id == category.id}">
                                                                                    <option value="${category.id}" selected="">${category.name}</option>
                                                                                </c:if>
                                                                                <c:if test="${room.roomCategory.id != category.id}">
                                                                                    <option value="${category.id}">${category.name}</option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="status">Status</label>
                                                                        <select id="status" required name="status">
                                                                            <c:forEach items="${statuses}" var="status">
                                                                                <c:if test="${room.status == status}">
                                                                                    <option value="${status}" selected="">${status}</option>
                                                                                </c:if>
                                                                                <c:if test="${room.status != status}">
                                                                                    <option value="${status}">${status}</option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                    <button type="submit" class="btn btn-primary" >Save</button>
                                                                </div>
                                                            </form:form>
                                                        </div>
                                                    </div>
                                                </div>
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
                                                    <input id="page" onclick="window.location.href = '<c:url value="view-room?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
        </div>
        <!-- Modal Add -->
        <div class="modal fade" id="formAdd">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Form Room</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <form:form action="${pageContext.request.contextPath}/manager/add-room" id="formAddRoom" method="POST" modelAttribute="room">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="roomNumber">Room number</label>
                                <input type="text" class="form-control" id="roomNumber" name="roomNumber" required="">
                            </div>
                            <div class="form-group">
                                <label for="position">Position</label>
                                <select id="position" name="position" required="">
                                    <c:forEach items="${positions}" var="position">
                                        <option value="${position}">${position}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="rCategoryId">Room category</label>
                                <select id="rCategoryId" name="roomCategory.id" required="">
                                    <c:forEach items="${rCategories}" var="category">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <p class="text-danger" id="message"></p>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" >Add</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-loading"></div>
    <jsp:include page="../include/admin/js-page.jsp"/>
    <script>
        $('#size').change(function () {
            let size = $('#size').val();
            window.location.href = 'view-room?size=' + size;
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
        $("#formAddRoom").submit(function (e) {

            e.preventDefault(); // avoid to execute the actual submit of the form.

            var form = $(this);

            $.ajax({
                type: "POST",
                url: 'add-room',
                data: form.serialize(), // serializes the form's elements.
                success: function (data)
                {
                    if (data == 'fail') {
                        $('#message').html('Room already exists');
                    } else {
                        alert(data);
                        window.location.href = 'view-room';
                    }
                }
            });
        });
    </script>
</body>
</html>
