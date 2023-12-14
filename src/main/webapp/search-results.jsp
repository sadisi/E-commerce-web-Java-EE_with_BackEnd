<%@page import="java.text.DecimalFormat"%>
<%@page import="com.greenstore.dao.OrderDao"%>
<%@page import="com.greenstore.connection.DbCon"%>
<%@page import="com.greenstore.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    if (auth != null) {
        request.setAttribute("person", auth);
        OrderDao orderDao = new OrderDao(DbCon.getConnection());
        String orderNumSearch = request.getParameter("orderNumSearch");

        // Check if the user has submitted a search
        if (orderNumSearch != null && !orderNumSearch.isEmpty()) {
            // Search orders by order number
            orders = orderDao.searchOrderByOrderNum(auth.getId(), orderNumSearch);
        } else {
            // Retrieve all orders for the user
            orders = orderDao.userOrders(auth.getId());
        }
    } else {
        response.sendRedirect("login.jsp");
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/includes/head.jsp"%>
    <title>Green Store Search Results</title>
    <!-- Add your styles or include CSS files if needed -->

    <!-- Bootstrap CSS link -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <style>
        .navbar {
            background-color: #4CAF50;
        }
        .navbar a {
            color: white;
            padding: 14px 16px;
            text-decoration: none;
            display: inline-block;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .space-top-botom-default-order {
            padding-top: 120px;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="#">Green Store</a>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="/">Home</a>
            </li>
        </ul>
    </div>
</nav>

<div class="space-top-botom-default-order">
    <div class="container">
        <div class="card-header my-3">Search Results</div>

        <table class="table table-light">
            <thead>
            <tr>
                <th scope="col">Date</th>
                <th scope="col">Name</th>
                <th scope="col">Category</th>
                <th scope="col">Quantity</th>
                <th scope="col">Price</th>
                <th scope="col">Order Number</th>
                <th scope="col">Cancel</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Order> searchedOrders = (List<Order>) request.getAttribute("searchedOrders");
                if (searchedOrders != null) {
                    for (Order o : searchedOrders) {
            %>
            <tr>
                <td><%= o.getDate() %></td>
                <td><%= o.getName() %></td>
                <td><%= o.getCategory() %></td>
                <td><%= o.getQunatity() %></td>
                <td><%= dcf.format(o.getPrice()) %></td>
                <td><%= o.getOrderNum() %></td>
                <td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%= o.getOrderId() %>">Cancel Order</a></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<%@include file="/includes/footer.jsp"%>

<!-- Bootstrap JS and Popper.js scripts -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
