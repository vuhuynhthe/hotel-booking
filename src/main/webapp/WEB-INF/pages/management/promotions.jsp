<%-- 
    Document   : promotions
    Created on : Dec 2, 2022, 8:29:50 PM
    Author     : Administrator
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                                    <h4 class="card-title float-left mt-2">All Promotion</h4>
                                    <button type="button" class="badge badge-pill badge-info float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAdd">Add Promotion</button>
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
                                                    <th>Image</th>
                                                    <th>Name</th>
                                                    <th>Code</th>
                                                    <th>Start Date</th>
                                                    <th>End Date</th>
                                                    <th>Discount</th>
                                                    <th>Quantity</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tank_account">
                                                <c:forEach items="${promotions}" var="promotion" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>
                                                            <img class="col-sm-6" src="<c:url value="/resources-management/img/promotion/${promotion.image}"/>">
                                                        </td>
                                                        <td>${promotion.name}</td>
                                                        <td>${promotion.code}</td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY" value="${promotion.startDate}"/>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY" value="${promotion.endDate}"/>
                                                        </td>
                                                        <td>${promotion.discount}%</td>
                                                        <td>${promotion.quantity}</td>
                                                        <td>
                                                            <button class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formEdit${promotion.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Edit</button>
                                                            <c:if test="${promotion.bookings.size() == null || promotion.bookings.size() == 0}">
                                                                <a class="badge badge-danger" href="${pageContext.request.contextPath}/manager/delete-promotion?id=${promotion.id}" 
                                                                   onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <!-- Modal Edit -->
                                                <div class="modal fade" id="formEdit${promotion.id}">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Form Promotion</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <form:form action="${pageContext.request.contextPath}/manager/update-promotion" method="POST" modelAttribute="promotion" enctype="multipart/form-data">
                                                                <div class="modal-body">
                                                                    <input type="text" class="form-control" name="id" hidden="" value="${promotion.id}">
                                                                    <div class="row formtype">
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="name">Name</label>
                                                                            <input type="text" class="form-control" id="name" name="name" required="" value="${promotion.name}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="code">Code</label>
                                                                            <input type="text" class="form-control" id="code" minlength="5" maxlength="5" name="code" required="" value="${promotion.code}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="startDate">Start Date</label>
                                                                            <input type="date" class="form-control date-input" id="startDate" name="startDate" required="" value="${promotion.startDate}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="endDate">End Date</label>
                                                                            <input type="date" class="form-control date-input" id="endDate" name="endDate" required value="${promotion.endDate}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="discount">Discount</label>
                                                                            <input type="number" class="form-control" id="discount" name="discount" required value="${promotion.discount}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="quantity">Quantity</label>
                                                                            <input type="number" class="form-control" id="quantity" name="quantity" required value="${promotion.quantity}">
                                                                        </div>
                                                                        <div class="form-group col-sm-12">
                                                                            <label for="description">Description</label>
                                                                            <textarea class="form-control" maxlength="2000" id="description" name="description" rows="2" required>${promotion.description}</textarea>
                                                                        </div>
                                                                        <div class="form-group col-sm-12">
                                                                            <label for="file">Image</label>
                                                                            <input type="file" class="form-control" id="file" name="file" value="${promotion.image}">
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
                                                    <input id="page" onclick="window.location.href = '<c:url value="view-promotion?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
                            <h5 class="modal-title" id="exampleModalLabel">Form Promotion</h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <form:form action="${pageContext.request.contextPath}/manager/add-promotion" method="POST" modelAttribute="promotion" enctype="multipart/form-data">
                            <div class="modal-body">
                                <div class="row formtype">
                                    <div class="form-group col-sm-6">
                                        <label for="name">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" required="">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="code">Code</label>
                                        <input type="text" class="form-control" minlength="5" maxlength="5" id="code" name="code" required="">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="startDate">Start Date</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" required="">
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="endDate">End Date</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="discount">Discount</label>
                                        <input type="number" class="form-control" id="discount" name="discount" required>
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label for="quantity">Quantity</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" required >
                                    </div>
                                    <div class="form-group col-sm-12">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" maxlength="2000" id="description" rows="2" name="description" required></textarea>
                                    </div>
                                    <div class="form-group col-sm-12">
                                        <label for="file">Image</label>
                                        <input type="file" class="form-control" id="file" name="file">
                                    </div>
                                </div>
                            </div>
                            <div>${message}</div>
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
                window.location.href = 'view-promotion?size=' + size;
            });
        </script>
    </body>
</html>
