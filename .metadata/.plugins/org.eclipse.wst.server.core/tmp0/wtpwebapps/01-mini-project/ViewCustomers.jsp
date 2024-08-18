<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View Customers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h2 class="mb-0">Customer List</h2>
        </div>
        <div class="card-body">
            <!-- Search input -->
            <div class="mb-3">
                <input type="text" id="searchInput" class="form-control" placeholder="Search by First or Last Name">
            </div>
            
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Customer ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Account Number</th>
                        <th>Balance</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody id="customerTable">
                    <c:forEach var="customer" items="${customerList}">
                        <tr>
                            <td>${customer.customerID}</td>
                            <td>${customer.first_name}</td>
                            <td>${customer.last_name}</td>
                            <td>${customer.email}</td>
                            <td>${customer.accountNumber}</td>
                            <td>${customer.balance}</td>
                            <td>${customer.created_at}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Filter the table based on search input
        $('#searchInput').on('keyup', function() {
            var value = $(this).val().toLowerCase();
            $('#customerTable tr').filter(function() {
                $(this).toggle(
                    $(this).find('td:nth-child(2)').text().toLowerCase().indexOf(value) > -1 ||
                    $(this).find('td:nth-child(3)').text().toLowerCase().indexOf(value) > -1
                );
            });
        });
    });
</script>

</body>
</html>
