<%@page import="com.greenstore.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		response.sendRedirect("index.jsp");
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
<title>Swift Supper</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>


	<!-- log in section start -->
	<div class="space-signUpPage">
		<form class="log-in-section background-image-2 section-b-space" action="user-login" method="post">
			<div class="container-fluid-lg w-100">
				<div class="row">
					<div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
						<div class="log-in-box">
							<div class="log-in-title">
								<h3>Welcome To Swift Super</h3>
								<h4>Log In Your Account</h4>
							</div>
								<div class="input-box">
									<div class="row g-4">
										<div class="col-12">
											<div class="form-floating theme-form-floating log-in-form">
												<input type="email" class="form-control" id="email" name="login-email" placeholder="Email Address">
												<label for="email">Email Address</label>
											</div>
										</div>

										<div class="col-12">
											<div class="form-floating theme-form-floating log-in-form">
												<input type="password" class="form-control" id="password" name="login-password" placeholder="Password">
												<label for="password">Password</label>
											</div>
										</div>

										<div class="col-12">
											<div class="forgot-box">
												<div class="form-check ps-0 m-0 remember-box">
													<input class="checkbox_animated check-box" type="checkbox" id="flexCheckDefault">
													<label class="form-check-label" for="flexCheckDefault">Remember me</label>
												</div>
												<a href="signup.jsp" class="forgot-password">Signup ?</a>
											</div>
										</div>

										<div class="col-12">
											<button class="btn btn-animation w-100 justify-content-center" type="submit">Login</button>
										</div>
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- log in section end -->











	<%@include file="/includes/footer.jsp"%>
</body>
</html>