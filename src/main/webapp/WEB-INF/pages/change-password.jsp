<%-- 
    Document   : change-password
    Created on : Nov 30, 2022, 9:10:13 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Edit Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <jsp:include page="include/user/css-page.jsp" />
    </head>
    <body>
        <jsp:include page="include/user/header.jsp"/><hr>
        <div class="container" style=" margin: auto">
            <div class="main-wrapper">
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="row">
                            <div class="col-sm-6">
                                <h3 class="page-title mt-5">Change Password</h3> <br><br>
                                <form id="formChange">
                                    <div class="form-group">
                                        <label for="newPassword">New password</label>
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" min="6" required="">
                                    </div><br>
                                    <div class="form-group">
                                        <label for="confirmPassword">Confirm new password</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" min="6" required>
                                    </div>
                                    <p class="text-danger" id="error"></p><br>
                                    <button type="submit" onclick="changePassword()" class="btn btn-primary" >Save</button>
                                </form>
                            </div>
                            <div class="col-sm-4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <img style="margin-left: 200px;" src="resources/img/about/about-2.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            </div>  
                        </div>

                    </div>
                </div>
            </div>
        </div>
<jsp:include page="include/user/footer-page.jsp"/>

<jsp:include page="include/user/js-page.jsp"/>
<script>
    $("#formChange").submit(function (event) {
        event.preventDefault();
    });

    function changePassword() {
        let newPassword = $('#newPassword').val();
        let confirmPassword = $('#confirmPassword').val();
        $.ajax({
            url: "change-password",
            type: 'POST',
            data: {
                newPassword: newPassword,
                confirmPassword: confirmPassword
            },
            success: function (data, textStatus, jqXHR) {
                if (data == 'Fail') {
                    $('#error').html('Confirm password is incorrect!');
                } else {
                    alert(data);
                    window.location.href = 'setting';
                }
            }
        });
    }
</script>
</html>
