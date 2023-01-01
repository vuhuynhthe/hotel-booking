<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>

<div class="sidebar" id="sidebar">
    <div class="sidebar-inner slimscroll">
        <div id="sidebar-menu" class="sidebar-menu">
            <ul>
                <sec:authorize access="isAuthenticated()">
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li class="submenu"> <a href="#"><i class="far fa-user"></i> <span> Accounts </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/admin/view"/>">View account</a></li>
                                <li><a href="<c:url value="/admin/decentralization"/>">Decentralization</a></li>
                            </ul>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_MANAGER')">
                        <li class="active"> <a href="<c:url value="/home"/>""><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a> </li>
                        <li class="list-divider"></li>
                        <li class="submenu"> <a href="#"><i class="fas fa-suitcase"></i> <span> Booking </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/manager/view-booking"/>"> All Booking </a></li>
                            </ul>
                        </li>
                        <li class="submenu"> <a href="#"><i class="fas fa-key"></i> <span> Room </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/manager/view-room-category"/>"> Room Categories </a></li>
                                <li><a href="<c:url value="/manager/view-room"/>"> All Rooms </a></li>
                            </ul>
                        </li>
                        <li class="submenu"> <a href="#"><i class="fas fa-business-time"></i> <span> Services </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/manager/view-service"/>"> All Services </a></li>
                            </ul>
                        </li>
                        <li class="submenu"> <a href="#"><i class="fas fa-tasks"></i></i> <span> Convenients </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/manager/view-convenient"/>"> All Convenients </a></li>
                            </ul>
                        </li>
                        <li class="submenu"> <a href="#"><i class="fas fa-code"></i> <span> Promotions </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/manager/view-promotion"/>"> All Promotions </a></li>
                            </ul>
                        </li>
<!--                        <li class="submenu"> <a href="#"><i class="fas fa-user"></i> <span> Staff </span> <span class="menu-arrow"></span></a>
                            <ul class="submenu_class" style="display: none;">
                                <li><a href="<c:url value="/manager/view-staff"/>"> All Staff </a></li>
                            </ul>
                        </li>-->
                    </sec:authorize>
                </sec:authorize>
            </ul>
        </div>
    </div>
</div>