// OrderDao.java
package com.greenstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenstore.model.Order;
import com.greenstore.model.Product;

public class OrderDao {

    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public OrderDao(Connection con) {
        super();
        this.con = con;
    }

    public boolean insertOrder(Order model) {
        boolean result = false;
        try {
            query = "INSERT INTO orders (p_id, u_id, o_quantity, o_date,orderNum) VALUES (?, ?, ?, ?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, model.getId()); // Assuming getId() returns product ID
            pst.setInt(2, model.getUid());
            pst.setInt(3, model.getQunatity());
            pst.setString(4, model.getDate());
            pst.setString(5, model.getOrderNum());
            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
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

    public boolean updateOrderStatus(String orderId) {

        return false;
    }

}
