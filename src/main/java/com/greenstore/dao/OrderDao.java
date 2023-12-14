// OrderDao.java
package com.greenstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenstore.model.Order;

public class OrderDao {

    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public OrderDao(Connection con) {
        super();
        this.con = con;
    }

    public boolean insertOrders(List<Order> orders) {
        boolean result = false;
        try {
            // Assuming that the orderNum is common for all orders in the list
            String orderNum = orders.get(0).getOrderNum();

            // Start a transaction
            con.setAutoCommit(false);

            // Use a batch update for better performance
            query = "INSERT INTO orders (p_id, u_id, o_quantity, o_date, orderNum) VALUES (?, ?, ?, ?, ?)";
            pst = this.con.prepareStatement(query);

            for (Order order : orders) {
                pst.setInt(1, order.getId());
                pst.setInt(2, order.getUid());
                pst.setInt(3, order.getQunatity());
                pst.setString(4, order.getDate());
                pst.setString(5, orderNum);
                pst.addBatch();
            }

            // Execute the batch update
            pst.executeBatch();

            // Commit the transaction
            con.commit();

            // Set the result to true since the batch update was successful
            result = true;

            // Reset auto-commit to true for future operations
            con.setAutoCommit(true);
        } catch (SQLException e) {
            try {
                // Rollback the transaction in case of any exception
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Close resources (statement, etc.)
            // Add code to close the statement
        }
        return result;
    }

    public List<Order> userOrders(int userId) {
        List<Order> list = new ArrayList<>();
        try {
            query = "SELECT orders.o_id, orders.p_id, orders.u_id, orders.o_quantity, orders.o_date, orders.orderNum, " +
                    "products.name, products.category, products.price " +
                    "FROM orders INNER JOIN products ON orders.p_id = products.id WHERE u_id = ? ORDER BY orders.o_id DESC";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("o_id"));
                order.setId(rs.getInt("p_id"));
                order.setUid(rs.getInt("u_id"));
                order.setQunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setOrderNum(rs.getString("orderNum")); // Include orderNum in the result set
                order.setName(rs.getString("name"));
                order.setCategory(rs.getString("category"));
                order.setPrice(rs.getDouble("price") * rs.getInt("o_quantity"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources (result set, statement, etc.)
            // Add code to close the result set and statement
        }
        return list;
    }



    public void cancelOrder(int orderId) {
        try {
            query = "DELETE FROM orders WHERE o_id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, orderId);
            pst.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Add the following method for searching orders by order number
    public List<Order> searchOrderByOrderNum(int userId, String orderNum) {
        List<Order> list = new ArrayList<>();
        try {
            query = "SELECT orders.o_id, orders.p_id, orders.u_id, orders.o_quantity, orders.o_date, orders.orderNum, " +
                    "products.name, products.category, products.price " +
                    "FROM orders INNER JOIN products ON orders.p_id = products.id WHERE u_id = ? AND orderNum=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            pst.setString(2, orderNum);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("o_id"));
                order.setId(rs.getInt("p_id"));
                order.setUid(rs.getInt("u_id"));
                order.setQunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setOrderNum(rs.getString("orderNum")); // Include orderNum in the result set
                order.setName(rs.getString("name"));
                order.setCategory(rs.getString("category"));
                order.setPrice(rs.getDouble("price") * rs.getInt("o_quantity"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources (result set, statement, etc.)
            // Add code to close the result set and statement
        }
        return list;
    }

    public boolean updateOrderStatus(String orderId) {

        return false;
    }

}
