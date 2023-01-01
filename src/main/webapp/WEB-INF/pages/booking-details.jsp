<%-- 
    Document   : booking-details
    Created on : Dec 6, 2022, 7:58:58 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <h1 class="text-center text-danger">Gio Hang</h1>
            <table class="table" style="border:1px solid grey">
                <tr>
                    <th>Số phòng</th>
                    <th>Image</th>
                    <th>Service</th>
                    <th>Price</th>
                    <th>Unit price</th>
                    <th>Action</th>
                </tr>
                <tr id="product${i.id}">
                    <td hidden>${i.id}</td>
                    <td>${i.name}</td>
                    <td>${i.price} $</td>
                    <td>
                        ${i.color.color}
                    </td>
                    <td>
                        ${i.size.size}
                    </td>
                        <td>
                        <input type="button" 
                               value="Delete" 
                               onclick="deleteCart(${i.id})"
                               class="btn btn-danger" />
                    </td>
                </tr>
            </table>
            <div>
                <h4 class="text-info">Tong tien thanh toan: <span id="amountCart">${cartStats.amount}</span> $</h4>
            </div>
        </div>

    </body>
</html>
