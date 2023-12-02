<%@page import="com.greenstore.connection.DbCon"%>
<%@page import="com.greenstore.dao.ProductDao"%>
<%@page import="com.greenstore.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>

<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		request.setAttribute("person", auth);
	}
	ProductDao pd = new ProductDao(DbCon.getConnection());
	List<Product> products = pd.getAllProducts();
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/includes/head.jsp"%>

	<title>Swift Super</title>

	<style>
		html, body {
			height: 100%;
			margin: 0;
			padding: 0;
		}

		.wrapper {
			min-height: 100%;
			display: flex;
			flex-direction: column;
		}

		.content {
			flex: 1;
		}
	</style>

</head>
<body class="theme-color-4 bg-gradient-color">
<%@include file="/includes/navbar.jsp"%>

<!-- Loader Start -->
<div class="fullpage-loader">
	<span></span>
	<span></span>
	<span></span>
	<span></span>
	<span></span>

</div>
<!-- Loader End -->


<div class="wrapper">
<div class="col-md-10">
	<div class="row">
		<!-- Display categories vertically on the left side -->
		<div class="col-md-2 my-1">
			<div class="card w-100 h-75">
				<div class="card-body">
					<div class="card-header my-3">All Categories</div>
					<%
						Set<String> uniqueCategories = new HashSet<>();
						for (Product p : products) {
							uniqueCategories.add(p.getCategory());
						}
						for (String category : uniqueCategories) {
					%>
					<h5 class="card-title"><a href="category.jsp?category=<%= category %>"><%= category %></a></h5>
					<%
						}
					%>
				</div>
			</div>
		</div>

		<!-- Display products in the remaining space -->
		<div class="col-md-10">
			<div class="card-header my-3">All Products</div>
			<div class="row">
				<%
					if (!products.isEmpty()) {
						for (Product p : products) {
				%>
				<div class="col-md-2 my-3">
					<div class="card w-100 h-100">
						<img class="card-img-top" src="ProductImages/<%=p.getImage() %>"
							 alt="Card image cap">
						<div class="card-body">
							<h5 class="card-title"><%=p.getName() %></h5>
							<h6 class="price">Price: $<%=p.getPrice() %></h6>
							<h6 class="category">Category: <%=p.getCategory() %></h6>
						</div>
						<div class="d-flex justify-content-center mb-3">
							<a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a>
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
	</div>
</div>
</div>

<%@include file="/includes/footer.jsp"%>
</body>
</html>
