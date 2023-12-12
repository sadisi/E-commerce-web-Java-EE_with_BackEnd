        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.greenstore.model.Cart" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.greenstore.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.greenstore.connection.DbCon" %>

<%@ include file="/includes/head.jsp" %>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    double total = 0;
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DbCon.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }

    // Retrieve selected address details from the request parameters
    String selectedAddress = (String) request.getAttribute("selectedAddress");
    String selectedCity = (String) request.getAttribute("selectedCity");
    String selectedZipcode = (String) request.getAttribute("selectedZipcode");
    String selectedMobileNumber = (String) request.getAttribute("selectedMobileNumber");
%>
<html>
<head>
    <title>Checkout - Swift Super</title>
    <!-- Bootstrap CSS link -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Add your custom styles here -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            margin: 30px;
        }

        table {
            width: 100%;
        }

        th, td {
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        .selected-address {
            margin-top: 20px;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 0px;
            margin-top: 10px;

        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container my-3">
    <h2>Checkout</h2>
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Category</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <!-- Add any other columns you want to display -->
        </tr>
        </thead>
        <tbody>
        <%
            if (cart_list != null) {
                for (Cart c : cartProduct) {
        %>
        <tr>
            <td><%=c.getName()%></td>
            <td><%=c.getCategory()%></td>
            <td><%=dcf.format(c.getPrice())%></td>
            <td><%=c.getQuantity()%></td>
            <!-- Add any other columns you want to display -->
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4">No items in the cart</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- Display total price -->
    <div class="total-price">
        <h3>Total Price:RS.<%=dcf.format(total)%></h3>
    </div>
    <div>
        <button type="submit">Pay Now</button>
    </div>
</div>

<div class="container selected-address">
    <h3>Selected Address:</h3>
    <p><strong>Address:</strong> <%=selectedAddress%></p>
    <p><strong>City:</strong> <%=selectedCity%></p>
    <p><strong>Zipcode:</strong> <%=selectedZipcode%></p>
    <p><strong>Mobile Number:</strong> <%=selectedMobileNumber%></p>
</div>

<!-- Bootstrap JS and Popper.js scripts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
