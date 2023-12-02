package com.greenstore.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null && password != null && name != null && !name.isEmpty() && !email.isEmpty() && !password.isEmpty()) {
            saveToDatabase(name,email, password);
            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } else {
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }

    private void saveToDatabase(String name, String email, String password) {
        // JDBC connection and insertion code
        String jdbcURL = "jdbc:mysql://localhost:3306/greenstore";
        String jdbcUsername = "root";
        String jdbcPassword = "123789";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "INSERT INTO users (name,email, password) VALUES (?, ?,?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1,name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, password);
                preparedStatement.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
