<%-- 
    Document   : decentralization
    Created on : Nov 28, 2022, 8:54:13 AM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Decentralization Page</title>
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
                            <table class=" table table-stripped table table-hover table-center mb-0">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>ADMIN</th>
                                        <th>MANAGER</th>
                                        <th>RECIPTION</th>
                                        <th>USER</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="tank_account">
                                    <c:forEach items="${listAccount}" var="acc" varStatus="loop">
                                    <form action="${pageContext.request.contextPath}/admin/set-role" method="POST">
                                        <input type="text" name="id" value="${acc.id}" hidden="">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>${acc.name}</td>
                                            <td>${acc.email}</td>
                                            <td>
                                                <c:set var="contains" value="false" />
                                                <c:forEach items="${acc.userRoles}" var="userRole">
                                                    <c:if test="${userRole.role == roleAdmin}">
                                                        <c:set var="contains" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${contains}">
                                                    <input type="checkbox" name="roleAdmin" checked="">
                                                </c:if>
                                                <c:if test="${!contains}">
                                                    <input type="checkbox" name="roleAdmin">
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:set var="contains" value="false" />
                                                <c:forEach items="${acc.userRoles}" var="userRole">
                                                    <c:if test="${userRole.role == roleManager}">
                                                        <c:set var="contains" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${contains}">
                                                    <input type="checkbox" name="roleManager" checked="">
                                                </c:if>
                                                <c:if test="${!contains}">
                                                    <input type="checkbox" name="roleManager">
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:set var="contains" value="false" />
                                                <c:forEach items="${acc.userRoles}" var="userRole">
                                                    <c:if test="${userRole.role == roleReciption}">
                                                        <c:set var="contains" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${contains}">
                                                    <input type="checkbox" name="roleReciption" checked="">
                                                </c:if>
                                                <c:if test="${!contains}">
                                                    <input type="checkbox" name="roleReciption">
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:set var="contains" value="false" />
                                                <c:forEach items="${acc.userRoles}" var="userRole">
                                                    <c:if test="${userRole.role == roleUser}">
                                                        <c:set var="contains" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${contains}">
                                                    <input type="checkbox" name="roleUser" checked="">
                                                </c:if>
                                                <c:if test="${!contains}">
                                                    <input type="checkbox" name="roleUser">
                                                </c:if>
                                            </td>
                                            <td>
                                                <button type="submit"><i class="fas fa-wallet m-r-5"></i>Save</button>
                                            </td>
                                        </tr>
                                    </form>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div id="tank_paging" class="col-sm-12">
                                <ul class="pagination">
                                    <c:forEach begin="0" end="${pages}" var="i">
                                        <li class="page-item">
                                            <c:if test="${i == page}">
                                                <input disabled="" type="button" value="${i+1}">
                                            </c:if>
                                            <c:if test="${i != page}">
                                                <input id="page" onclick="window.location.href = '<c:url value="decentralization?page=${i}&size=${size}"/>'" type="button" value="${i+1}">
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
        <div class="modal-loading"></div>
        <jsp:include page="../include/admin/js-page.jsp"/>
        <script>
            $("#size").change(function () {
                let size = document.getElementById("size").value;
                window.location.href = 'decentralization?size=' + size;
            });
            $body = $("body");

            $(document).on({
                ajaxStart: function () {
                    $body.addClass("loading");
                },
                ajaxStop: function () {
                    $body.removeClass("loading");
                }
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
                        email: txtSearch,
                        action: 'setRole'
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
                        email: null,
                        action: 'setRole'
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
        <script>
            function setRole(id) {
                let roleAdmin = false;
                let roleManager = false;
                let roleReciption = false;
                let roleUser = false;
                if ($('#roleAdmin' + id).is(":checked"))
                {
                    roleAdmin = true;
                }
                if ($('#roleManager' + id).is(":checked"))
                {
                    roleManager = true;
                }
                if ($('#roleReciption' + id).is(":checked"))
                {
                    roleReciption = true;
                }
                if ($('#roleUser' + id).is(":checked"))
                {
                    roleUser = true;
                }
                window.location.href = 'set-role?id=' + id + '&roleAdmin=' + roleAdmin + '&roleManager=' + roleManager + '&roleReciption=' + roleReciption + '&roleUser=' + roleUser + '';
            }
        </script>
    </body>
</html>

