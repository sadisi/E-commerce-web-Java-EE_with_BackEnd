package com.greenstore.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.greenstore.connection.DbCon;
import com.greenstore.dao.OrderDao;
import com.greenstore.model.Cart;
import com.greenstore.model.Order;
import com.greenstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart-check-out")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			User auth = (User) request.getSession().getAttribute("auth");

			if (cart_list != null && auth != null) {
				OrderDao oDao = new OrderDao(DbCon.getConnection());
				String orderNum = generateOrderNumber();

				for (Cart c : cart_list) {
					Order order = new Order();
					order.setId(c.getId());
					order.setUid(auth.getId());
					order.setQunatity(c.getQuantity());
					order.setDate(formatter.format(date));
					order.setOrderNum(orderNum);

					boolean result = oDao.insertOrder(order);

					if (result) {
						// Send order confirmation email
						SendEmailUtil.sendOrderConfirmationEmail(auth.getEmail(), orderNum);

						// Set orderNum in the session
						request.getSession().setAttribute("orderNum", orderNum);
					} else {
						// Handle the case where order insertion failed
						response.getWriter().write("Order processing failed");
						return;
					}
				}

				cart_list.clear();

				// Assuming the last order in the loop is representative for order ID
				int orderIdInt = cart_list.get(cart_list.size() - 1).getId();

                 // Set orderNum in the session
				request.getSession().setAttribute("orderNum", orderNum);


				// Send a success response
				response.getWriter().write("Order processed successfully");
			} else {
				if (auth == null) {
					// Send a response indicating the need for authentication
					response.getWriter().write("Authentication required");
				} else {
					// Send a response indicating the failure of order processing
					response.getWriter().write("Order processing failed");
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			// Send a response indicating the failure of order processing
			response.getWriter().write("Order processing failed");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private String generateOrderNumber() {
		// Static prefix for the order number
		String prefix = "ORD";

		// Generate a timestamp portion
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String timestamp = dateFormat.format(new Date());

		// Generate a random portion using UUID
		String randomString = UUID.randomUUID().toString().replace("-", "").substring(0, 6);

		// Combine all parts to form the unique order number
		return prefix + timestamp + randomString;
	}
}
