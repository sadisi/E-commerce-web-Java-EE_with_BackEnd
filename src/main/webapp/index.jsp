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

<!-- Product Section Start -->
<section class="product-section pt-0">
	<div class="container-fluid p-0">
		<div class="custom-row">
			<div class="sidebar-col">
				<div class="category-menu">
					<a href="index.jsp" class="web-logo nav-logo">
						<img src="assets/images/logo/5.png" class="img-fluid blur-up lazyload" alt="">
					</a>
					<ul>
						<%
							Set<String> uniqueCategories = new HashSet<>();
							for (Product p : products) {
								uniqueCategories.add(p.getCategory());
							}
							for (String category : uniqueCategories) {
						%>

						<li>
							<div class="category-list">
								<h5>
									<a href="category.jsp?category=<%= category %>"><%= category %></a>
								</h5>
							</div>
						</li>
						<%
							}
						%>
					</ul>
				</div>
			</div>

			<div class="content-col">
				<div class="section-b-space">
					<div class="row g-md-4 g-3">
						<div class="col-xxl-8 col-xl-12 col-md-7">
							<div class="banner-contain hover-effect">
								<img src="assets/images/grocery/banner/11.jpg" class="bg-img blur-up lazyload"
									 alt="">
								<div class="banner-details p-center-left p-sm-5 p-4">
									<div>
										<h2 class="text-kaushan fw-normal orange-color">Sift Super</h2>
										<h3 class="mt-2 mb-3 text-white">TAKE ON THE DAY!</h3>
										<p class="text-content banner-text text-white opacity-75 d-md-block d-none">
											Sift Super new way to Shoping.</p>
										<button onclick="location.href = 'shop-left-sidebar.html';"
												class="btn btn-animation btn-sm mend-auto">Shop Now <i
												class="fa-solid fa-arrow-right icon"></i></button>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xxl-4 col-xl-12 col-md-5">
							<div class="banner-contain hover-effect h-100">
								<img src="assets/images/grocery/banner/12.jpg" class="bg-img blur-up lazyload"
									 alt="">
								<div class="banner-details p-center-left p-4 h-100">
									<div>
										<h2 class="text-kaushan fw-normal orange-color">Organic</h2>
										<h3 class="mt-2 mb-3">Fresh</h3>
										<p class="text-content banner-text w-100">Super Offer to 50%
											Off</p>
										<button onclick="location.href = 'shop-left-sidebar.html';"
												class="btn btn-animation btn-sm mend-auto">Shop Now <i
												class="fa-solid fa-arrow-right icon"></i></button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="title d-block">
					<h2 class="text-theme font-sm">Food Cupboard</h2>
					<p>A virtual assistant collects the products from your list</p>
				</div>

				<div class="row row-cols-xxl-6 row-cols-lg-5 row-cols-md-4 row-cols-sm-3 row-cols-2 g-sm-4 g-3 section-b-space">
					<%
						if (!products.isEmpty()) {
							for (Product p : products) {
					%>
					<div>
						<div class="product-box product-white-bg wow fadeIn">
							<div class="product-image">
								<a href=#>
									<img src="ProductImages/<%=p.getImage() %>"
										 class="img-fluid blur-up lazyload" alt="">
								</a>

							</div>
							<div class="product-detail position-relative">
								<a href="moreinfo.jsp">
									<h6 class="name">
										<%=p.getCategory() %>
									</h6>
								</a>

								<h6 class="sold weight text-content fw-normal"> <%=p.getName() %></h6>

								<h6 class="price theme-color"> Rs. <%=p.getPrice() %></h6>

								<div class="add-to-cart-box bg-white">
									<a href="add-to-cart?id=<%=p.getId()%>">
										<button class="btn btn-add-cart addcart-button" >Add to Cart</button>
									</a>

								</div>
							</div>
						</div>
					</div>
					<%
							}
						}
						else
						{
							out.println("There is no products");
						}
					%>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Product Section End -->

<!-- Cookie Bar Box Start -->
<div class="cookie-bar-box">
	<div class="cookie-box">
		<div class="cookie-image">
			<img src="assets/images/cookie-bar.png" class="blur-up lazyload" alt="">
			<h2>Cookies!</h2>
		</div>

		<div class="cookie-contain">
			<h5 class="text-content">We use cookies to make your experience better</h5>
		</div>
	</div>

	<div class="button-group">
		<button class="btn privacy-button">Privacy Policy</button>
		<button class="btn ok-button">OK</button>
	</div>
</div>
<!-- Cookie Bar Box End -->


<!-- Tap to top start -->
<div class="theme-option">
	<div class="back-to-top">
		<a id="back-to-top" href="#">
			<i class="fas fa-chevron-up"></i>
		</a>
	</div>
</div>
<!-- Tap to top end -->

<!-- Bg overlay Start -->
<div class="bg-overlay"></div>
<!-- Bg overlay End -->


<%@include file="/includes/footer.jsp"%>
</body>
</html>


























