<%-- 
    Document   : accounts
    Created on : Nov 25, 2022, 3:46:09 PM
    Author     : Administrator
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Accounts Page</title>
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
                                    <h4 class="card-title float-left mt-2">All Account</h4>
                                    <button class="badge badge-pill badge-info float-right" type="button" class="btn btn-primary float-right" id="btnFormAdd" data-toggle="modal" data-target="#formAddd">Add Account</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <form>
                                <div class="row formtype">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Find by name</label>
                                            <input class="form-control" id="input-name" oninput="searchByName(this)" type="text"> </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Find by email</label>
                                            <input class="form-control" id="input-email" oninput="searchByEmail(this)"type="text"> </div>
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
                                                    <th>Email</th>
                                                    <th>Gender</th>
                                                    <th>Birth</th>
                                                    <th>Create Date</th>
                                                    <th>Status</th>
                                                    <th>Role</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tank_account">
                                                <c:forEach items="${listAccount}" var="acc" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>${acc.name}</td>
                                                        <td>${acc.email}</td>
                                                        <td>
                                                            <c:if test="${!acc.gender}">
                                                                Male
                                                            </c:if>
                                                            <c:if test="${acc.gender}">
                                                                Female
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY" value="${acc.birthDate}"/>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd/MM/YYYY HH:mm:ss" value="${acc.createDate}"/>
                                                        </td>
                                                        <td>${acc.status}</td>
                                                        <td>
                                                            <c:forEach items="${acc.userRoles}" var="role" end="0">
                                                                ${role.role}
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <button class="badge badge-pill badge-primary" id="btnFormEdit${acc.id}" data-toggle="modal" data-target="#formEdit${acc.id}" ><i class="fas fa-pencil-alt m-r-5"></i> Edit</button>
                                                            <c:set var="contain" value="false"/>
                                                            <c:forEach items="${acc.userRoles}" var="role">
                                                                <c:if test="${role.role == 'ROLE_ADMIN'}">
                                                                    <c:set var="contain" value="true"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${!contain && acc.bookings.size() == 0 || acc.bookings.size() == null && !contain}">
                                                                <a class="badge badge-danger" href="${pageContext.request.contextPath}/admin/delete-account?id=${acc.id}" onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt m-r-5"></i> Delete</a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <!-- Modal Edit -->
                                                <div class="modal fade" id="formEdit${acc.id}">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Form Staff</h5>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            </div>
                                                            <form:form action="${pageContext.request.contextPath}/admin/update" method="POST" modelAttribute="account">
                                                                <div class="modal-body">
                                                                    <input value="${acc.id}" name="id" hidden="">
                                                                    <input value="${acc.password}" name="password" hidden="">
                                                                    <input value="${acc.createDate}" name="createDate" hidden="">
                                                                    <div class="form-group">
                                                                        <label for="name">Name</label>
                                                                        <input type="text" class="form-control" id="name" name="name" value="${acc.name}" required="">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email">Email</label>
                                                                        <input type="email" class="form-control" id="email" name="email" value="${acc.email}" readonly="">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="gender">Gender</label>
                                                                        <select id="gender" required name="gender">
                                                                            <c:if test="${!acc.gender}">
                                                                                <option value="false" selected="">Male</option>
                                                                                <option value="true">Female</option>
                                                                            </c:if>
                                                                            <c:if test="${acc.gender}">
                                                                                <option value="true" selected="">Female</option>
                                                                                <option value="false">Male</option>
                                                                            </c:if>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="birth">Birth</label>
                                                                        <input type="date" class="form-control" id="birthDate" name="birthDate" value="${acc.birthDate}" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="phoneNumber">Phone</label>
                                                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${acc.phoneNumber}" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="status">Status</label>
                                                                        <select id="status" required name="status">
                                                                            <c:forEach items="${statuses}" var="status">
                                                                                <c:if test="${acc.status == status}">
                                                                                    <option value="${status}" selected="">${status}</option>
                                                                                </c:if>
                                                                                <c:if test="${acc.status != status}">
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
                                                    <input id="page" onclick="window.location.href = '<c:url value="view?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
        <div class="modal fade" id="formAddd">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Form Account</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <form:form id="formAdd" modelAttribute="account">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required="">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required="">
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select id="gender" required name="gender">
                                    <option value="false">Male</option>
                                    <option value="true">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="birth">Birth</label>
                                <input type="date" class="form-control" id="birthDate" name="birthDate" required>
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Phone</label>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
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
        <div class="modal-loading"></div>
        <jsp:include page="../include/admin/js-page.jsp"/>
        <script>
            $("#size").change(function () {
                let size = document.getElementById("size").value;
                window.location.href = 'view?size=' + size;
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
            $('#formAdd').submit(function (e) {
                e.preventDefault();
                let form = $('#formAdd');
                $.ajax({
                    url: 'add',
                    type: 'POST',
                    data: form.serialize(),
                    success: function (data, textStatus, jqXHR) {
                        if (data == 'OK') {
                            alert('Sign up success!');
                            location.reload();
                        } else {
                            alert(data);
                        }
                    }
                })
            });
        </script>
        <script>
            function searchByName(param) {
                let txtSearch = param.value;

                call(txtSearch);
            }


            function searchByEmail(param) {
                let txtSearch = param.value;

                $.ajax({
                    url: "search-by-key",
                    type: 'GET',
                    data: {
                        email: txtSearch
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#tank_account").html(data);
                        $('#input-name').prop('readonly', true);
                        if (txtSearch == '') {
                            $('#input-name').prop('readonly', false);
                            call(txtSearch);
                        }
                    }
                });
            }

            function call(txtSearch) {
                $.ajax({
                    url: "search-by-key",
                    type: 'GET',
                    data: {
                        name: txtSearch,
                        email: null
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#tank_account").html(data);
                        $('#input-email').prop('readonly', true);
                        if (txtSearch == '') {
                            $('#input-email').prop('readonly', false);
                        }
                    }
                });
            }
        </script>
    </body>
</html>
