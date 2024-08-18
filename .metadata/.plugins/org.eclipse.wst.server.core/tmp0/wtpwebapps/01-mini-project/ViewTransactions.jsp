<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Transactions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h2 class="mb-0">Transaction List</h2>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <label for="transactionType" class="form-label">Filter by Transaction Type</label>
                <select id="transactionType" class="form-select">
                    <option value="all">All</option>
                    <option value="Credit">Credit</option>
                    <option value="Debit">Debit</option>
                </select>
            </div>
            
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Transaction ID</th>
                        <th>Sender Account Number</th>
                        <th>Receiver Account Number</th>
                        <th>Transaction Type</th>
                        <th>Amount</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody id="transactionTable">
                    <c:forEach var="transaction" items="${transactionList}">
                        <tr class="transaction-row" data-type="${transaction.transaction_type}">
                            <td>${transaction.transactionID}</td>
                            <td>${transaction.senderAccountNumber}</td>
                            <td>${transaction.recieverAccountNumber}</td>
                            <td>${transaction.transaction_type}</td>
                            <td>${transaction.amount}</td>
                            <td>${transaction.date}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#transactionType').on('change', function() {
            var selectedType = $(this).val().toLowerCase();
            if (selectedType === "all") {
                $('.transaction-row').show();
            } else {
                $('.transaction-row').each(function() {
                    var rowType = $(this).data('type').toLowerCase();
                    $(this).toggle(rowType === selectedType);
                });
            }
        });
    });
</script>
</body>
</html>
