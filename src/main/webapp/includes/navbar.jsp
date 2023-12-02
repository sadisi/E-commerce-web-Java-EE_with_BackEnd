
<!-- Header Start -->
<header class="pb-0 fixed-header">
	<div class="top-nav top-header">
		<div class="container-fluid-xs">
			<div class="row">
				<div class="col-12">
					<div class="navbar-top">
						<button class="navbar-toggler d-xl-none d-inline navbar-menu-button" type="button"
								data-bs-toggle="offcanvas" data-bs-target="#primaryMenu">
                                <span class="navbar-toggler-icon navbar-toggler-icon-2">
                                    <i class="fa-solid fa-bars"></i>
                                </span>
						</button>

						<div class="middle-box">
							<div class="search-box">
								<div class="input-group">
									<input type="search" class="form-control" placeholder="I'm searching for..."
										   aria-label="Recipient's username" aria-describedby="button-addon2">
									<button class="btn bg-theme" type="button" id="button-addon2">
										<i data-feather="search"></i>
									</button>
								</div>
							</div>
						</div>

						<div class="rightside-box">
							<div class="search-full">
								<div class="input-group">
                                        <span class="input-group-text">
                                            <i data-feather="search" class="font-light"></i>
                                        </span>
									<input type="text" class="form-control search-type" placeholder="Search here..">
									<span class="input-group-text close-search">
                                            <i data-feather="x" class="font-light"></i>
                                        </span>
								</div>
							</div>
							<ul class="right-side-menu">
								<li class="right-side">
									<div class="delivery-login-box">
										<div class="delivery-icon">
											<div class="search-box">
												<i data-feather="search"></i>
											</div>
										</div>
									</div>
								</li>
								<li class="right-side">
									<a href="#" class="delivery-login-box">
										<div class="delivery-icon">
											<i data-feather="phone-call"></i>
										</div>
									</a>
								</li>
								<li class="right-side">
									<div class="onhover-dropdown header-badge">
										<button type="button" class="btn p-0 position-relative header-wishlist">
											<i data-feather="shopping-cart"></i>
											<span class="position-absolute top-0 start-100 translate-middle badge">2
                                                    <span class="visually-hidden">unread messages</span>
                                                </span>
										</button>

										<div class="onhover-div">
											<ul class="cart-list">
												<li class="product-box-contain">
													<div class="drop-cart">
														<a href="product-left-thumbnail.html" class="drop-image">
															<img src="assets/images/vegetable/product/1.png"
																 class="blur-up lazyload" alt="">
														</a>

														<div class="drop-contain">
															<a href="product-left-thumbnail.html">
																<h5>Fantasy Crunchy Choco Chip Cookies</h5>
															</a>
															<h6><span>1 x</span> Rs 220.00</h6>
															<button class="close-button close_button">
																<i class="fa-solid fa-xmark"></i>
															</button>
														</div>
													</div>
												</li>

												<li class="product-box-contain">
													<div class="drop-cart">
														<a href="#" class="drop-image">
															<img src="assets/images/vegetable/product/2.png"
																 class="blur-up lazyload" alt="">
														</a>

														<div class="drop-contain">
															<a href="product-left-thumbnail.html">
																<h5>Peanut Butter Bite Premium Butter Cookies 600 g
																</h5>
															</a>
															<h6><span>1 x</span> Rs 320.00</h6>
															<button class="close-button close_button">
																<i class="fa-solid fa-xmark"></i>
															</button>
														</div>
													</div>
												</li>
											</ul>

											<div class="price-box">
												<h5>Total :</h5>
												<h4 class="theme-color fw-bold">Rs 540.00</h4>
											</div>

											<div class="button-group">
												<a href="viewcart.jsp" class="btn btn-sm cart-button">View Cart</a>
												<a href="checkout.jsp" class="btn btn-sm cart-button theme-bg-color
                                                        text-white">Checkout</a>
											</div>
										</div>
									</div>
								</li>
								<li class="right-side onhover-dropdown">
									<div class="delivery-login-box">
										<div class="delivery-icon">
											<i data-feather="user"></i>
										</div>
									</div>

									<div class="onhover-div onhover-div-login">
										<ul class="user-box-name">
											<li class="product-box-contain">
												<i></i>
												<a href="login.jsp">Log In</a>
											</li>

											<li class="product-box-contain">
												<a href="signup.jsp">Register</a>
											</li>


											<li class="product-box-contain">
												<a href="cart.jsp">Cart  <span class="badge badge-danger">${cart_list.size()}</span></a>
											</li>

											<%
												if (auth != null) {
											%>

											<li class="product-box-contain">
												<a href="orders.jsp">Orders</a>
											</li>
											<li class="product-box-contain">
												<a href="log-out">Logout</a>
											</li>

											<%
											} else {
											%>

											<li class="product-box-contain">
												<a href="login.jsp">Login</a>
											</li>
											<%
												}
											%>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- Header End -->


