<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow p-4">
            <div class="card-header bg-dark text-white">
                <h2 class="mb-0">Customer List</h2>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search by Customer ID">
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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="customerTable">
                        <!-- Initially display only customers without an account number -->
                        <c:forEach var="customer" items="${accountList}">
                            <c:if test="${empty customer.accountNumber}">
                                <tr>
                                    <td>${customer.customerID}</td>
                                    <td>${customer.first_name}</td>
                                    <td>${customer.last_name}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.accountNumber}</td>
                                    <td>${customer.balance}</td>
                                    <td>${customer.created_at}</td>
                                    <td>
                                        <button type="button" class="btn btn-primary create-account-btn" 
                                                data-customerid="${customer.customerID}">
                                            Create Account
                                        </button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal for entering balance -->
    <div class="modal fade" id="balanceModal" tabindex="-1" aria-labelledby="balanceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="AddAccountController" method="get">
                    <div class="modal-header">
                        <h5 class="modal-title" id="balanceModalLabel">Enter Initial Balance</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="customerIdInput" name="customerId">
                        <div class="mb-3">
                            <label for="balanceInput" class="form-label">Balance</label>
                            <input type="number" class="form-control" id="balanceInput" name="initialBalance" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Create Account</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Handle Create Account button click
            $('.create-account-btn').on('click', function() {
                var customerId = $(this).data('customerid');
                $('#customerIdInput').val(customerId);
                $('#balanceModal').modal('show');
            });

            // Filter the table based on search input
            $('#searchInput').on('keyup', function() {
                var value = $(this).val().toLowerCase();
                $('#customerTable tr').filter(function() {
                    var customerID = $(this).find('td:first').text().toLowerCase();
                    $(this).toggle(customerID.indexOf(value) > -1);
                });
            });

            // Function to reload all rows (including those with account numbers) after a search
            $('#searchInput').on('input', function() {
                var value = $(this).val().toLowerCase();
                $('#customerTable').empty();

                <c:forEach var="customer" items="${accountList}">
                    var customerID = '${customer.customerID}'.toLowerCase();
                    if (customerID.indexOf(value) > -1 || value === "") {
                        $('#customerTable').append(
                            '<tr>' +
                            '<td>${customer.customerID}</td>' +
                            '<td>${customer.first_name}</td>' +
                            '<td>${customer.last_name}</td>' +
                            '<td>${customer.email}</td>' +
                            '<td>${customer.accountNumber}</td>' +
                            '<td>${customer.balance}</td>' +
                            '<td>${customer.created_at}</td>' +
                            '<td><button type="button" class="btn btn-primary create-account-btn" data-customerid="${customer.customerID}">Create Account</button></td>' +
                            '</tr>'
                        );
                    }
                </c:forEach>
            });
        });
    </script>
</body>
</html>
