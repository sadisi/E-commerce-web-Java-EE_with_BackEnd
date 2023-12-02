<%@page import="com.greenstore.dao.ProductDao"%>
<%@page import="com.greenstore.model.Product"%>
<%@page import="java.util.List"%>
<%@ page import="com.greenstore.connection.DbCon" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/includes/head.jsp"%>
<html>
<head>
    <title>Green Store Category</title>
</head>
<body>

<div class="container">
    <div class="card-header my-3">Category: <%= request.getParameter("category") %></div>
    <div class="row">
        <%
            ProductDao pd = new ProductDao(DbCon.getConnection());
            List<Product> categoryProducts = pd.getProductsByCategory(request.getParameter("category"));
            if (!categoryProducts.isEmpty()) {
                for (Product p : categoryProducts) {
        %>
        <div class="col-md-3 my-4">
            <div class="card w-100 h-100">
                <img class="card-img-top" src="ProductImages/<%=p.getImage() %>" alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title"><%=p.getName() %></h5>
                    <h6 class="price">Price: Rs<%=p.getPrice() %></h6>
                    <h6 class="category">Category: <%=p.getCategory() %></h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a>
                        <a class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
                out.println("There is no products");
            }
        %>
    </div>
</div>

</body>
</html>
