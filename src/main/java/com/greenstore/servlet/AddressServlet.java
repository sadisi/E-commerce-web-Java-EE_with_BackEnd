package com.greenstore.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import com.greenstore.connection.DbCon;
import com.greenstore.dao.AddressDao;
import com.greenstore.model.Address;
import com.greenstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/address")
public class AddressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User auth = (User) request.getSession().getAttribute("auth");
        if (auth != null) {
            try {
                AddressDao addressDao = new AddressDao(DbCon.getConnection());
                List<Address> addresses = addressDao.getAddressesByUserId(auth.getId());

                request.setAttribute("addresses", addresses);
                request.setAttribute("userId", auth.getId());
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User auth = (User) request.getSession().getAttribute("auth");
            if (auth != null) {
                // Retrieve address details from the form
                String userAddress = request.getParameter("address");
                String city = request.getParameter("city");
                String zipcode = request.getParameter("zipcode");
                String mobileNumber = request.getParameter("mobileNumber");

                // Get the user's existing addresses
                AddressDao addressDao = new AddressDao(DbCon.getConnection());
                try {
                    List<Address> existingAddresses = addressDao.getAddressesByUserId(auth.getId());

                    if (!existingAddresses.isEmpty()) {
                        // User already has an address, update the existing one
                        Address existingAddress = existingAddresses.get(0); // Assuming there's only one address per user
                        existingAddress.setAddress(userAddress);
                        existingAddress.setCity(city);
                        existingAddress.setZipcode(zipcode);
                        existingAddress.setMobileNumber(mobileNumber);

                        boolean updateResult = addressDao.updateAddress(existingAddress);

                        if (updateResult) {
                            // Redirect to checkout.jsp after address update
                            response.sendRedirect("checkout.jsp");
                        } else {
                            // Handle address update failure
                            request.setAttribute("updateError", "Failed to update address.");
                            doGet(request, response);
                        }
                    } else {
                        // User doesn't have an address, insert a new one
                        Address newAddress = new Address();
                        newAddress.setUserId(auth.getId());
                        newAddress.setAddress(userAddress);
                        newAddress.setCity(city);
                        newAddress.setZipcode(zipcode);
                        newAddress.setMobileNumber(mobileNumber);

                        boolean insertResult = addressDao.insertAddress(newAddress);

                        if (insertResult) {
                            // Redirect to checkout.jsp after address insertion
                            response.sendRedirect("checkout.jsp");
                        } else {
                            // Handle address insertion failure
                            request.setAttribute("insertError", "Failed to insert address.");
                            doGet(request, response);
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle the exception
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
