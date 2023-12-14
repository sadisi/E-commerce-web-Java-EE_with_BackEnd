package com.greenstore.servlet;

import com.greenstore.connection.DbCon;
import com.greenstore.dao.OrderDao;
import com.greenstore.model.Order;
import com.greenstore.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/search-orders")
public class SearchOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderNum = request.getParameter("orderNum");

        // Assuming you have a valid userId in your session
        User auth = (User) request.getSession().getAttribute("auth");
        int userId = auth.getId();

        OrderDao orderDao = null;
        try {
            orderDao = new OrderDao(DbCon.getConnection());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        List<Order> searchedOrders = orderDao.searchOrderByOrderNum(userId, orderNum);

        request.setAttribute("searchedOrders", searchedOrders);

        // Forward the request to your JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("search-results.jsp");
        dispatcher.forward(request, response);
    }
}
