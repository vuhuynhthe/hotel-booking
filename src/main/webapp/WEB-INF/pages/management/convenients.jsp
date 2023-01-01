<%-- 
    Document   : convenients
    Created on : Nov 30, 2022, 2:07:35 PM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Convenient Page</title>
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
                                    <h4 class="card-title float-left mt-2">All Convenients</h4>
                                    <button type="button" class="badge badge-pill badge-info float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAdd">Add Convenient</button>
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
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tank_account">
                                                <c:forEach items="${convenients}" var="convenient" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>${convenient.name}</td>
                                                        <td>
                                                            <button class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formEdit${convenient.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Edit</button>
                                                            <c:if test="${convenient.roomCategorys.size() == null || convenient.roomCategorys.size() == 0}">
                                                                <a class="badge badge-danger" href="${pageContext.request.contextPath}/manager/delete-convenient?id=${convenient.id}" onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <!-- Modal Edit -->
                                                <div class="modal fade" id="formEdit${convenient.id}">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Form Convenient</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <form:form action="${pageContext.request.contextPath}/manager/update-convenient" method="POST" modelAttribute="convenient">
                                                                <div class="modal-body">
                                                                    <input type="text" class="form-control" id="id" name="id" hidden="" value="${convenient.id}">
                                                                    <div class="form-group">
                                                                        <label for="name">Name</label>
                                                                        <input type="text" class="form-control" id="name" name="name" required="" value="${convenient.name}">
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
                                                    <input id="page" onclick="window.location.href = '<c:url value="view-convenient?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
                        <h5 class="modal-title" id="exampleModalLabel">Form Convenient</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <form:form action="${pageContext.request.contextPath}/manager/add-convenient" method="POST" modelAttribute="convenient">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required="">
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
        <jsp:include page="../include/admin/js-page.jsp"/>
        <script>
            $('#size').change(function () {
                let size = $('#size').val();
                window.location.href = 'view-convenient?size=' + size;
            });
        </script>
    </body>
</html>
