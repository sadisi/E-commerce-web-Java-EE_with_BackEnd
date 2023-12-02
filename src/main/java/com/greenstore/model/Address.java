package com.greenstore.model;

public class Address {
    private int id;
    private int userId;
    private String address;
    private String city;
    private String zipcode;
    private String mobileNumber;

    // Constructors, getters, and setters

    public Address(int id, int userId, String address, String city, String zipcode, String mobileNumber) {
        this.id = id;
        this.userId = userId;
        this.address = address;
        this.city = city;
        this.zipcode = zipcode;
        this.mobileNumber = mobileNumber;
    }

    public Address() {

    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }
}
