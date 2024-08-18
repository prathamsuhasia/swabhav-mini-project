<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Customer</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow p-4">
            <div class="card-header bg-dark text-white ">
                <h4 class="mb-0">Add New Customer</h4>
            </div>
            <div class="card-body">
                <form action="AddNewCustomer" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="firstName">Customer First Name</label>
                        <input type="text" class="form-control" pattern="[A-Za-z]+" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Customer Last Name</label>
                        <input type="text" class="form-control" pattern="[A-Za-z]+" id="lastName" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email ID</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        <button type="reset" class="btn btn-secondary mt-3">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var email = document.getElementById("email").value;
            var isValid = false;

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "CheckEmailServlet", false);  
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    isValid = xhr.responseText === "true";
                }
            };
            xhr.send("email=" + email);

            if (!isValid) {
                alert("Email ID is already in use. Please enter a different email.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
