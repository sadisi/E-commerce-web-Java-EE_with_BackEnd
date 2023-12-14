package com.greenstore.servlet;

import java.io.IOException;
import java.util.ArrayList;
import com.greenstore.model.Cart;
import com.greenstore.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Checkout-Servlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart-list");

        if (cartList != null && !cartList.isEmpty()) {

            session.setAttribute("checkout-cart-list", cartList);

            // Retrieve selected address details from request parameters
            String selectedAddress = request.getParameter("selectedAddress");
            String selectedCity = request.getParameter("selectedCity");
            String selectedZipcode = request.getParameter("selectedZipcode");
            String selectedMobileNumber = request.getParameter("selectedMobileNumber");

            // Set selected address details as request attributes
            request.setAttribute("selectedAddress", selectedAddress);
            request.setAttribute("selectedCity", selectedCity);
            request.setAttribute("selectedZipcode", selectedZipcode);
            request.setAttribute("selectedMobileNumber", selectedMobileNumber);

            // Forward the request to checkout.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}
