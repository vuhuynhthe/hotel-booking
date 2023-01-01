<%-- 
    Document   : index
    Created on : Nov 23, 2022, 2:34:56 PM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Hotel Page</title>
        <jsp:include page="../include/admin/css-page.jsp"/>
    </head>
    <body>
        <div class="main-wrapper">
            <jsp:include page="../include/admin/header.jsp"/>
            <jsp:include page="../include/admin/menu.jsp"/>
            <div class="page-wrapper">
                <img style="width: 100%; height: 100%;" src="<c:url value="/resources/img/hero/hero-3.jpg"/>">
            </div>
        </div>
    </div>
    <jsp:include page="../include/admin/js-page.jsp"/>
</body>
</html>
