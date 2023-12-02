package com.greenstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.greenstore.model.Address;

public class AddressDao {
    private Connection connection;

    public AddressDao(Connection connection) {
        this.connection = connection;
    }

    public boolean insertAddress(Address address) throws SQLException {
        String query = "INSERT INTO address (user_id, address, city, zipcode, mobile_number) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, address.getUserId());
            preparedStatement.setString(2, address.getAddress());
            preparedStatement.setString(3, address.getCity());
            preparedStatement.setString(4, address.getZipcode());
            preparedStatement.setString(5, address.getMobileNumber());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }


    public boolean updateAddress(Address address) throws SQLException {
        String query = "UPDATE address SET address = ?, city = ?, zipcode = ?, mobile_number = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, address.getAddress());
            preparedStatement.setString(2, address.getCity());
            preparedStatement.setString(3, address.getZipcode());
            preparedStatement.setString(4, address.getMobileNumber());
            preparedStatement.setInt(5, address.getId());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }


    public List<Address> getAddressesByUserId(int userId) throws SQLException {
        List<Address> addresses = new ArrayList<>();
        String query = "SELECT * FROM address WHERE user_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Address address = new Address();
                    address.setId(resultSet.getInt("id"));
                    address.setUserId(resultSet.getInt("user_id"));
                    address.setAddress(resultSet.getString("address"));
                    address.setCity(resultSet.getString("city"));
                    address.setZipcode(resultSet.getString("zipcode"));
                    address.setMobileNumber(resultSet.getString("mobile_number"));
                    addresses.add(address);
                }
            }
        }
        return addresses;
    }






}
