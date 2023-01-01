<%-- 
    Document   : categories
    Created on : Nov 30, 2022, 2:30:03 PM
    Author     : Administrator
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categories Page</title>
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
                                    <h4 class="card-title float-left mt-2">All Category</h4>
                                    <button class="badge badge-pill badge-info float-right" type="button" class="btn btn-primary float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAdd">Add Room Category</button>
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
                                                    <th>Price</th>
                                                    <th>Size</th>
                                                    <th>Bed info</th>
                                                    <th>Capacity</th>
                                                    <th>Create Date</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${categories}" var="category" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>${category.name}</td>
                                                        <td>
                                                            <fmt:formatNumber type = "number" pattern="###,###,###" value = "${category.price}"/><sup>đ</sup>
                                                        </td>
                                                        <td>${category.size}</td>
                                                        <td>${category.bedInfo}</td>
                                                        <td>${category.capacity}</td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY HH:mm:ss" value="${category.createDate}"/>
                                                        </td>
                                                        <td>${category.status}</td>
                                                        <td>
                                                            <button class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formEdit${category.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Edit</button>
                                                            <button class="badge badge-pill badge-primary" data-toggle="modal" data-target="#formConvenient${category.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Add Convenient</button>

                                                            <c:set var="contain" value="false"/>
                                                            <c:forEach items="${category.rooms}" var="room">
                                                                <c:if test="${room.bookingDetails.size() != null || room.bookingDetails.size() > 0}">
                                                                    <c:set var="contain" value="true"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${!contain && category.convenients.size() == null || !contain && category.convenients.size() == 0}">
                                                                <a class="badge badge-danger" href="${pageContext.request.contextPath}/manager/delete-rcategory?id=${category.id}"
                                                                   onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <!-- Modal Edit -->
                                                <div class="modal fade" id="formEdit${category.id}">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Form Staff</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <form:form action="${pageContext.request.contextPath}/manager/update-rcategory" method="POST" modelAttribute="roomCategory" enctype="multipart/form-data">
                                                                <div class="modal-body">
                                                                    <input type="text" class="form-control" id="id" name="id" hidden="" value="${category.id}">
                                                                    <input type="text" class="form-control" id="createDate" name="createDate" hidden="" value="${category.createDate}">
                                                                    <div class="row formtype">
                                                                        <div class="form-group col-sm-12">
                                                                            <label for="name">Name</label>
                                                                            <input type="text" class="form-control" id="name" name="name" required="" value="${category.name}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6">
                                                                            <label for="price">Price</label>
                                                                            <input type="number" class="form-control" pattern="###,###,###"  id="price" name="price" required value="${category.price}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6"">
                                                                            <label for="sizeCategory">Size</label>
                                                                            <input type="text" class="form-control" min="4" max="4" id="sizeCategory" name="size" required="" value="${category.size}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6"">
                                                                            <label for="capacity">Capacity</label>
                                                                            <input type="number" class="form-control" id="capacity" name="capacity" required="" value="${category.capacity}">
                                                                        </div>
                                                                        <div class="form-group col-sm-6"">
                                                                            <label for="bedInfo">Bed info</label>
                                                                            <input type="text" class="form-control" id="bedInfo" name="bedInfo" required="" value="${category.bedInfo}">
                                                                        </div>
                                                                        <div class="form-group col-sm-12">
                                                                            <label for="description">Description</label>
                                                                            <textarea class="form-control" id="description" name="description" rows="2" required="">${category.description}</textarea>
                                                                        </div>
                                                                        <div class="form-group col-sm-6"">
                                                                            <label for="status">Status</label>
                                                                            <select id="status" required name="status">
                                                                                <c:forEach items="${statuses}" var="status">
                                                                                    <c:if test="${category.status == status}">
                                                                                        <option value="${status}" selected="">${status}</option>
                                                                                    </c:if>
                                                                                    <c:if test="${category.status != status}">
                                                                                        <option value="${status}">${status}</option>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group col-sm-12">
                                                                            <label for="files">Images</label>
                                                                            <input type="file" class="form-control" id="files" name="files" multiple="">
                                                                            <c:forEach items="${category.images}" var="image">
                                                                                <img src="<c:url value="/resources/img/category/${image.name}"/>" class="col-sm-2">
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
                                                <!-- Modal Convenient -->
                                                <div class="modal fade" id="formConvenient${category.id}">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Convenients</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <form action="${pageContext.request.contextPath}/manager/put-convenient" method="POST">
                                                                <div class="modal-body">
                                                                    <input type="text" class="form-control" name="id" hidden="" value="${category.id}">
                                                                    <div class="form-group">
                                                                        <div class="row formtype">
                                                                            <c:forEach items="${convenients}" var="convenient">
                                                                                <div class="form-check form-switch col-sm-6">
                                                                                    <c:set var="contains" value="false" />
                                                                                    <c:forEach items="${category.convenients}" var="c">
                                                                                        <c:if test="${c.id == convenient.id}">
                                                                                            <c:set var="contains" value="true" />
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${contains}">
                                                                                        <input class="form-check-input" id="convenient${convenient.id}" name="convenients" type="checkbox" value="${convenient.id}" checked="">
                                                                                        <label class="form-check-label" for="convenient${convenient.id}">${convenient.name}</label>
                                                                                    </c:if>
                                                                                    <c:if test="${!contains}">
                                                                                        <input class="form-check-input" id="convenient${convenient.id}" name="convenients" type="checkbox" value="${convenient.id}">
                                                                                        <label class="form-check-label" for="convenient${convenient.id}">${convenient.name}</label>
                                                                                    </c:if>
                                                                                </div>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                    <button type="submit"" class="btn btn-primary" >Save</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="tank_paging" class="col-sm-12">
                                        <ul class="pagination">
                                            <c:forEach begin="0" end="${pages}" var="i">
                                                <li class="page-item">
                                                    <c:if test="${i == page}">
                                                        <input disabled="" type="button" value="${i+1}">
                                                    </c:if>
                                                    <c:if test="${i != page}">
                                                        <input id="page" onclick="window.location.href = '<c:url value="view-rcategory?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
                                <h5 class="modal-title" id="exampleModalLabel">Form Room Category</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <form:form action="${pageContext.request.contextPath}/manager/add-rcategory" method="POST" modelAttribute="roomCategory" enctype="multipart/form-data">
                                <div class="modal-body">
                                    <div class="row formtype">
                                        <div class="form-group col-sm-12">
                                            <label for="name">Name</label>
                                            <input type="text" class="form-control" id="name" name="name" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="price">Price</label>
                                            <input type="number" class="form-control" id="price" name="price" required>
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="sizeCategory">Size</label>
                                            <input type="text" class="form-control" min="4" max="4" id="sizeCategory" name="size" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="capacity">Capacity</label>
                                            <input type="number" class="form-control" id="capacity" name="capacity" required="">
                                        </div>
                                        <div class="form-group col-sm-6">
                                            <label for="bedInfo">Bed info</label>
                                            <input type="text" class="form-control" id="bedInfo" name="bedInfo" required="">
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label for="description">Description</label>
                                            <textarea class="form-control" id="description" name="description" rows="2" required=""></textarea>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <label for="files">Images</label>
                                            <input type="file" class="form-control" id="files" name="files" multiple="">
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
        </div>
        <jsp:include page="../include/admin/js-page.jsp"/>
        <script>
            $('#size').change(function () {
                let size = $('#size').val();
                window.location.href = 'view-room-category?size=' + size;
            });
        </script>
    </body>
</html>
