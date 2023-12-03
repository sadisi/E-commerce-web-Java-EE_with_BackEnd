
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
									<a href="index.jsp" class="delivery-login-box" >
										<h3>Home</h3>
									</a>
								</li>
								<li class="right-side">
									<a href="cart.jsp"  class="delivery-login-box position-relative header-wishlist" >
										<h3>Cart  </h3>
										<span class="position-absolute top-0 start-100 translate-middle badge">
											${cart_list.size()}
										</span>
									</a>
								</li>
								<%
									if (auth != null) {
								%>
								<li class="right-side">
									<a href="orders.jsp" class="delivery-login-box" >
										<h3>Orders</h3>
									</a>
								</li>
								<li class="right-side">
									<a href="log-out" class="delivery-login-box" >
										<h3>Logout</h3>
									</a>
								</li>
								<%
								} else {
								%>
								<li class="right-side">
									<a href="login.jsp" class="delivery-login-box" >
										<h3>Login</h3>
									</a>
								</li>
								<%
									}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- Header End -->


