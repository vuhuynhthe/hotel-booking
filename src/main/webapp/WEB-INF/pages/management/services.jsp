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
            <title>Service Page</title>
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
                                        <h4 class="card-title float-left mt-2">All Service</h4>
                                        <button type="button" class="badge badge-pill badge-info float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAdd">Add Service</button>
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
                                                        <th>Name</th>
                                                        <th>Position</th>
                                                        <th>Price</th>
                                                        <th>Open time</th>
                                                        <th>Close time</th>
                                                        <th>Phone number</th>
                                                        <th>Status</th>
                                                        <th>Create Date</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tank_account">
                                                    <c:forEach items="${services}" var="service" varStatus="loop">
                                                        <tr>
                                                            <td>${loop.count}</td>
                                                            <td>${service.name}</td>
                                                            <td>${service.position}</td>
                                                            <td>
                                                                <fmt:formatNumber pattern="###,###,###" value="${service.price}"/><sup>đ</sup>
                                                            </td>
                                                            <td>${service.openTime}</td>
                                                            <td>${service.closeTime}</td>
                                                            <td>${service.phoneNumber}</td>
                                                            <td>${service.status}</td>
                                                            <td>
                                                                <fmt:formatDate pattern="dd/MM/YYYY HH:mm:ss" value="${service.createDate}"/>
                                                            </td>
                                                            <td>
                                                                <button class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formEdit${service.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Edit</button>
                                                                <c:if test="${service.serviceBookings.size() == null || service.serviceBookings.size() == 0}">
                                                                    <a class="badge badge-danger" href="${pageContext.request.contextPath}/manager/delete-service?id=${service.id}"
                                                                       onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                        <!-- Modal Edit -->
                                                    <div class="modal fade" id="formEdit${service.id}">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel">Form Service</h5>
                                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                </div>
                                                                <form:form action="${pageContext.request.contextPath}/manager/save-service" method="POST" modelAttribute="service" enctype="multipart/form-data">
                                                                    <div class="modal-body">
                                                                        <input type="text" class="form-control" name="id" hidden="" value="${service.id}">
                                                                        <input type="text" class="form-control" name="createDate" hidden="" value="${service.createDate}">
                                                                        <div class="row formtype">
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="name">Name</label>
                                                                                <input type="text" class="form-control" id="name" name="name" required="" value="${service.name}">
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="price">Price</label>
                                                                                <input type="number" class="form-control" id="price" name="price" required="" value="${service.price}">
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="openTime">Open Time</label>
                                                                                <input type="text" class="form-control" id="openTime" minlength="5" maxlength="5" name="openTime" required value="${service.openTime}">
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="closeTime">Close Time</label>
                                                                                <input type="text" class="form-control" id="closeTime" minlength="5" maxlength="5" name="closeTime" required value="${service.closeTime}">
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="phoneNumber">Phone number</label>
                                                                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required="" value="${service.phoneNumber}">
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="position">Position</label>
                                                                                <select class="form-control" id="position" name="position" required>
                                                                                    <c:forEach items="${positions}" var="p">
                                                                                        <c:if test="${service.position == p}">
                                                                                            <option value="${p}" selected="">${p}</option>
                                                                                        </c:if>
                                                                                        <c:if test="${service.position != p}">
                                                                                            <option value="${p}">${p}</option>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                            <div class="form-group col-sm-12">
                                                                                <label for="description">Description</label>
                                                                                <textarea class="form-control" maxlength="2000" rows="2" id="description" name="description" required>${service.description}</textarea>
                                                                            </div>
                                                                            <div class="form-group col-sm-6">
                                                                                <label for="status">Status</label>
                                                                                <select class="form-control" id="status" required name="status">
                                                                                    <c:forEach items="${statuses}" var="status">
                                                                                        <c:if test="${service.status == status}">
                                                                                            <option value="${status}" selected="">${status}</option>
                                                                                        </c:if>
                                                                                        <c:if test="${service.status != status}">
                                                                                            <option value="${status}">${status}</option>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                            <div class="form-group col-sm-12">
                                                                                <label for="files">Images</label>
                                                                                <input type="file" class="form-control" id="files" name="files" multiple="">
                                                                                <c:forEach items="${service.images}" var="image">
                                                                                    <img src="<c:url value="/resources/img/service/${image.name}"/>" class="col-sm-2">
                                                                                </c:forEach>
                                                                            </div>
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
                                                        <input id="page" onclick="window.location.href = '<c:url value="view-service?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
                                <h5 class="modal-title" id="exampleModalLabel">Form Service</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <form:form action="${pageContext.request.contextPath}/manager/add-service" method="POST" modelAttribute="service" enctype="multipart/form-data">
                                <div class="modal-body">
                                    <div class="row formtype">
                                        <div class="form-group col-sm-6">
                                            <label for="name">Name</label>
                                            <input type="text" class="form-control" id="name" name="name" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="price">Price</label>
                                            <input type="number" class="form-control" id="price" name="price" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="openTime">Open Time</label>
                                            <input type="text" class="form-control" id="openTime" minlength="5" maxlength="5" name="openTime" required>
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="closeTime">Close Time</label>
                                            <input type="text" class="form-control" id="closeTime" minlength="5" maxlength="5" name="closeTime" required>
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="phoneNumber">Phone number</label>
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="position">Position</label>
                                            <select class="form-control" id="position" name="position" required>
                                                <c:forEach items="${positions}" var="p">
                                                    <option value="${p}">${p}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label for="description">Description</label>
                                            <textarea class="form-control" maxlength="2000" id="description" rows="2" name="description" required></textarea>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label for="files">Images</label>
                                            <input type="file" class="form-control" id="files" name="files" multiple="">
                                        </div>
                                    </div>
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
            <jsp:include page="../include/admin/js-page.jsp"/>
            <script>
                $('#size').change(function () {
                    let size = $('#size').val();
                    window.location.href = 'view-service?size=' + size;
                });
            </script>
        </body>
    </html>
