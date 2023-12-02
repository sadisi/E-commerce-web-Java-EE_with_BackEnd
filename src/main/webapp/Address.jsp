<%@ page import="java.util.List" %>
<%@ page import="com.greenstore.model.Address" %>
<%@ page import="com.greenstore.model.User" %>
<%@ page import="com.greenstore.dao.AddressDao" %>
<%@ page import="com.greenstore.connection.DbCon" %>

<%
    // Retrieve the user from the session
    User user = (User) request.getSession().getAttribute("auth");

    // Check if the user is logged in
    if (user != null) {
        try {
            // Retrieve addresses from the database
            AddressDao addressDao = new AddressDao(DbCon.getConnection());
            List<Address> addresses = addressDao.getAddressesByUserId(user.getId());

            // Check if the addresses list is not empty
            if (addresses != null && !addresses.isEmpty()) {
%>


<form>
<!-- Your existing form fields go here -->
<h2>Current Address</h2>
<%
    for (Address address : addresses) {
        // Display address details
%>
<div>
    <p><strong>Address:</strong> <%= address.getAddress() %></p>
    <p><strong>City:</strong> <%= address.getCity() %></p>
    <p><strong>Zipcode:</strong> <%= address.getZipcode() %></p>
    <p><strong>Mobile Number:</strong> <%= address.getMobileNumber() %></p>

    <!-- You can also provide an option to edit or delete the address if needed -->

    <hr>
    <button type="button" id="editButton" onclick="toggleEdit(document.getElementById('enableEdit'))">Checkout</button>
</div>
<%
    }
} else {
%>

<p>No addresses found for the user.</p>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception
        }
    } else {
        // If the user is not logged in, redirect to the login page
        response.sendRedirect("login.jsp");
    }
%>

</form>
<div></div>
<form action="address" method="post">

    <div style="display: flex; align-items:center; margin-bottom: 10px;">
        <label for="enableEdit">EnableEdit:</label>
        <input type="checkbox" id="enableEdit" name="enableEdit" onchange="toggleEdit(this)">
    </div>

    <label for="address">Address:</label>
    <textarea id="address" name="address" rows="4" cols="50" required disabled>${address.address}</textarea>

    <label for="city">City:</label>
    <input type="text" id="city" name="city" value="${address.city}" required disabled>

    <label for="zipcode">Zipcode:</label>
    <input type="text" id="zipcode" name="zipcode" value="${address.zipcode}" required disabled>

    <label for="mobileNumber">Mobile Number:</label>
    <input type="text" id="mobileNumber" name="mobileNumber" value="${address.mobileNumber}" required disabled>

    <!-- Hidden field to store the address ID -->
    <input type="hidden" id="addressId" name="addressId" value="${address.id}">

    <input type="hidden" id="actionType" name="actionType" value="addNew">

    <p1>If you want to Add Or Update Your Address Please Fill The Field.</p1>

    <button type="submit" >Add New OR Update</button>

</form>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Lock the fields on page load
        toggleEdit(document.getElementById('enableEdit'));
    });

    function toggleEdit(checkbox) {
        var addressTextarea = document.getElementById('address');
        var cityInput = document.getElementById('city');
        var zipcodeInput = document.getElementById('zipcode');
        var mobileNumberInput = document.getElementById('mobileNumber');

        if (checkbox.checked) {
            addressTextarea.removeAttribute('disabled');
            cityInput.removeAttribute('disabled');
            zipcodeInput.removeAttribute('disabled');
            mobileNumberInput.removeAttribute('disabled');
        } else {
            addressTextarea.setAttribute('disabled', 'disabled');
            cityInput.setAttribute('disabled', 'disabled');
            zipcodeInput.setAttribute('disabled', 'disabled');
            mobileNumberInput.setAttribute('disabled', 'disabled');
        }
    }
</script>


<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        background-color: #fff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 500px;
        margin-left: 50px;
    }

    label {
        display: block;
        margin-bottom: 10px;
    }

    input, textarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 16px;
        box-sizing: border-box;
    }

    button {
        background-color: #4caf50;
        color: #fff;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-left: 0px;
        margin-top: 10px;

    }

    button:hover {
        background-color: #45a049;
    }

    p1 {
        color: red;
    }
</style>


</body>
</html>
